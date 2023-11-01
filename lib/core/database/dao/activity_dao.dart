// ignore_for_file: lines_longer_than_80_chars

import 'package:aniflow/core/common/util/global_static_constants.dart';
import 'package:aniflow/core/database/aniflow_database.dart';
import 'package:aniflow/core/database/dao/media_dao.dart';
import 'package:aniflow/core/database/dao/user_data_dao.dart';
import 'package:aniflow/core/database/model/activity_entity.dart';
import 'package:aniflow/core/database/model/media_entity.dart';
import 'package:aniflow/core/database/model/relations/activity_and_user_relation.dart';
import 'package:aniflow/core/database/model/user_entity.dart';
import 'package:sqflite/sqflite.dart';

/// [Tables.activityTable]
mixin ActivityTableColumns {
  static const String id = 'activity_id';
  static const String userId = 'activity_userId';
  static const String mediaId = 'activity_mediaId';
  static const String text = 'activity_text';
  static const String status = 'activity_status';
  static const String progress = 'activity_progress';
  static const String type = 'activity_type';
  static const String replyCount = 'activity_replyCount';
  static const String siteUrl = 'activity_siteUrl';
  static const String isLocked = 'activity_isLocked';
  static const String isLiked = 'activity_isLiked';
  static const String likeCount = 'activity_likeCount';
  static const String isPinned = 'activity_isPinned';
  static const String createdAt = 'activity_createdAt';
}

mixin ActivityFilterTypeCrossRefColumns {
  static const String id = 'activity_filter_type_cross_id';
  static const String activityId = 'activity_filter_type_cross_activity_id';
  static const String category = 'activity_filter_type_cross_filter_category';
}

abstract class ActivityDao {
  Future upsertActivityEntities(
      List<ActivityAndUserRelation> entities, String category);

  Future<List<ActivityAndUserRelation>> getActivityEntities(
      [int page, int perPage, String category]);

  Future clearActivityEntities(String category);
}

class ActivityDaoImpl extends ActivityDao {
  final AniflowDatabase database;

  ActivityDaoImpl(this.database);

  @override
  Future upsertActivityEntities(
      List<ActivityAndUserRelation> entities, String category) async {
    final batch = database.aniflowDB.batch();
    for (final entity in entities) {
      batch.insert(
          Tables.activityFilterTypeCrossRef,
          {
            ActivityFilterTypeCrossRefColumns.activityId: entity.activity.id,
            ActivityFilterTypeCrossRefColumns.category: category,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
      batch.insert(
        Tables.activityTable,
        entity.activity.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      batch.insert(
        Tables.userDataTable,
        entity.user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      if (entity.media != null) {
        batch.insert(
          Tables.mediaTable,
          entity.media!.toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }
    }
    return batch.commit(noResult: true);
  }

  @override
  Future<List<ActivityAndUserRelation>> getActivityEntities([
    int page = 1,
    int perPage = Config.defaultPerPageCount,
    String category = '',
  ]) async {
    final int limit = perPage;
    final int offset = (page - 1) * perPage;

    String sql = 'select * from ${Tables.activityFilterTypeCrossRef} as afc '
        'join ${Tables.activityTable}  as a '
        '  on a.${ActivityTableColumns.id} = afc.${ActivityFilterTypeCrossRefColumns.activityId} '
        'join ${Tables.userDataTable}  as u '
        '  on a.${ActivityTableColumns.userId} = u.${UserDataTableColumns.id} '
        'left join ${Tables.mediaTable} as m '
        '  on a.${ActivityTableColumns.mediaId} = m.${MediaTableColumns.id} '
        'where ${ActivityFilterTypeCrossRefColumns.category} = \'$category\' '
        'order by ${ActivityFilterTypeCrossRefColumns.id} asc '
        'limit $limit '
        'offset $offset ';

    final List<Map<String, dynamic>> result =
        await database.aniflowDB.rawQuery(sql);

    return result.map(
      (e) {
        final mediaEntity = MediaEntity.fromJson(e);
        final isMediaValid = mediaEntity.id.isNotEmpty;
        return ActivityAndUserRelation(
          user: UserEntity.fromJson(e),
          activity: ActivityEntity.fromJson(e),
          media: isMediaValid ? mediaEntity : null,
        );
      },
    ).toList();
  }

  @override
  Future clearActivityEntities(String category) {
    return database.aniflowDB.delete(Tables.activityFilterTypeCrossRef,
        where: '${ActivityFilterTypeCrossRefColumns.category}=\'$category\'');
  }
}
