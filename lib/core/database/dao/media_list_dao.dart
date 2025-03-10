import 'package:aniflow/core/common/util/global_static_constants.dart';
import 'package:aniflow/core/data/model/extension/media_list_item_model_extension.dart';
import 'package:aniflow/core/data/model/sorted_group_media_list_model.dart';
import 'package:aniflow/core/database/aniflow_database.dart';
import 'package:aniflow/core/database/relations/media_list_and_media_relation.dart';
import 'package:aniflow/core/database/relations/sorted_group_media_list_entity.dart';
import 'package:aniflow/core/database/tables/media_airing_schedule_updated_table.dart';
import 'package:aniflow/core/database/tables/media_list_table.dart';
import 'package:aniflow/core/database/tables/media_table.dart';
import 'package:collection/collection.dart';
import 'package:drift/drift.dart';

part 'media_list_dao.g.dart';

@DriftAccessor(tables: [
  MediaListTable,
  MediaTable,
  MediaAiringScheduleUpdatedTable,
])
class MediaListDao extends DatabaseAccessor<AniflowDatabase>
    with _$MediaListDaoMixin {
  MediaListDao(super.db);

  Future removeMediaListOfUser(String userId) {
    return attachedDatabase.transaction(() async {
      return (delete(mediaListTable)..where((t) => t.userId.equals(userId)))
          .go();
    });
  }

  Future<List<MediaListAndMediaRelation>> getMediaListByPage(
      String userId, List<String> status,
      {required String mediaType,
      required int page,
      int perPage = AfConfig.defaultPerPageCount}) {
    final int limit = perPage;
    final int offset = (page - 1) * perPage;

    final query = select(mediaListTable).join([
      leftOuterJoin(mediaTable, mediaListTable.mediaId.equalsExp(mediaTable.id))
    ])
      ..where(
        mediaListTable.status.isIn(status) &
            mediaListTable.userId.equals(userId) &
            mediaTable.type.equals(mediaType),
      )
      ..orderBy([OrderingTerm.desc(mediaListTable.updatedAt)])
      ..limit(limit, offset: offset);

    return query
        .map(
          (row) => MediaListAndMediaRelation(
              mediaListEntity: row.readTable(mediaListTable),
              mediaEntity: row.readTable(mediaTable)),
        )
        .get();
  }

  Stream<List<String>> getAllMediaIdInMediaListStream(
      String userId, List<String> status, String mediaType) {
    final query = select(mediaListTable).join([
      leftOuterJoin(mediaTable, mediaListTable.mediaId.equalsExp(mediaTable.id))
    ])
      ..where(
        mediaListTable.status.isIn(status) &
            mediaListTable.userId.equals(userId) &
            mediaTable.type.equals(mediaType),
      );

    return query
        .map((row) => row.read(mediaTable.id))
        .watch()
        .map((value) => value.nonNulls.toList());
  }

  Stream<List<MediaListAndMediaRelation>> getMediaListStream(
      String userId, List<String> status, String mediaType) {
    final query = select(mediaListTable).join([
      innerJoin(mediaTable, mediaListTable.mediaId.equalsExp(mediaTable.id))
    ])
      ..where(
        mediaListTable.status.isIn(status) &
            mediaListTable.userId.equals(userId) &
            mediaTable.type.equals(mediaType),
      )
      ..orderBy([
        OrderingTerm.desc(mediaListTable.updatedAt),
      ]);

    return query
        .map(
          (row) => MediaListAndMediaRelation(
            mediaListEntity: row.readTable(mediaListTable),
            mediaEntity: row.readTable(mediaTable),
          ),
        )
        .watch();
  }

  Future<MediaListEntity?> getMediaListItem(String mediaId, String userId) {
    return (select(mediaListTable)
          ..where((tbl) =>
              mediaListTable.mediaId.equals(mediaId) &
              mediaListTable.userId.equals(userId)))
        .getSingleOrNull();
  }

  Future<MediaListAndMediaRelation?> getMediaListItemByMediaId(
      String mediaId, String userId) async {
    final media = await (select(mediaTable)
          ..where((t) => mediaTable.id.equals(mediaId)))
        .getSingle();
    final mediaList = await (select(mediaListTable)
          ..where((t) =>
              mediaListTable.mediaId.equals(mediaId) &
              mediaListTable.userId.equals(userId)))
        .getSingleOrNull();

    return MediaListAndMediaRelation(
      mediaListEntity: mediaList,
      mediaEntity: media,
    );
  }

  Stream<MediaListAndMediaRelation?> getMediaListOfUserStream(
      String userId, String mediaId) {
    final query = select(mediaListTable).join([
      leftOuterJoin(mediaTable, mediaListTable.mediaId.equalsExp(mediaTable.id))
    ])
      ..where(mediaListTable.mediaId.equals(mediaId) &
          mediaListTable.userId.equals(userId));

    return query
        .map(
          (row) => MediaListAndMediaRelation(
            mediaListEntity: row.readTable(mediaListTable),
            mediaEntity: row.readTable(mediaTable),
          ),
        )
        .watchSingleOrNull();
  }

  Future upsertMediaListEntities(List<MediaListEntity> entities) async {
    return attachedDatabase.transaction(() async {
      await batch((batch) {
        batch.insertAll(
          mediaListTable,
          entities,
          mode: InsertMode.insertOrReplace,
        );
      });
    });
  }

  Future deleteMediaListOfUser(String userId) {
    return attachedDatabase.transaction(() async {
      return (delete(mediaListTable)..where((tbl) => tbl.userId.equals(userId)))
          .go();
    });
  }

  Stream<SortedGroupMediaListEntity> getAllSortedMediaListOfUserStream(
      String userId, List<String> status, String mediaType) {
    SortedGroupMediaListEntity sortList(List<MediaListAndMediaRelation> list) {
      bool isNewUpdateMedia(MediaListAndMediaRelation relation) {
        final updateTime =
            relation.mediaAiringScheduleUpdatedEntity?.updateTime;
        if (updateTime == null) {
          return false;
        }

        final isInRange = DateTime.now().difference(updateTime) <
            const Duration(days: newUpdateDayRange);
        final hasNextEpisode = relation.hasNextReleasingEpisode;
        return isInRange && hasNextEpisode;
      }

      final map = list.groupListsBy((e) => isNewUpdateMedia(e));
      // Ordered by newest to oldest.
      final newUpdateList = (map[true] ?? [])
          .sortedBy((e) => e.mediaAiringScheduleUpdatedEntity!.updateTime)
          .reversed
          .toList();
      final otherList = (map[false] ?? [])
          .sortedBy<num>((e) => e.mediaListEntity?.updatedAt ?? 0)
          .reversed
          .toList();
      return SortedGroupMediaListEntity(newUpdateList, otherList);
    }

    final query = select(mediaListTable).join([
      innerJoin(mediaTable, mediaListTable.mediaId.equalsExp(mediaTable.id)),
      leftOuterJoin(
          mediaAiringScheduleUpdatedTable,
          mediaListTable.mediaId
              .equalsExp(mediaAiringScheduleUpdatedTable.updatedMediaId))
    ])
      ..where(
        mediaListTable.status.isIn(status) &
            mediaListTable.userId.equals(userId) &
            mediaTable.type.equals(mediaType),
      );

    return query
        .map(
          (row) => MediaListAndMediaRelation(
            mediaListEntity: row.readTable(mediaListTable),
            mediaEntity: row.readTable(mediaTable),
            mediaAiringScheduleUpdatedEntity:
                row.readTableOrNull(mediaAiringScheduleUpdatedTable),
          ),
        )
        .watch()
        .distinct(
            (pre, next) => const DeepCollectionEquality().equals(pre, next))
        .map(sortList);
  }

  /// upsert mediaList and ignore media when conflict.
  Future upsertMediaListAndMediaRelations(
      List<MediaListAndMediaRelation> entities) {
    return attachedDatabase.transaction(() async {
      return batch((batch) {
        batch.insertAll(
          mediaListTable,
          entities.map((e) => e.mediaListEntity).nonNulls,
          mode: InsertMode.replace,
        );

        // insert the table or update columns except Value.absent().
        batch.insertAllOnConflictUpdate(
          mediaTable,
          entities.map((e) => e.mediaEntity.toCompanion(true)),
        );
      });
    });
  }
}
