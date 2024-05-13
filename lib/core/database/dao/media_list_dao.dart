import 'package:aniflow/core/common/util/global_static_constants.dart';
import 'package:aniflow/core/database/aniflow_database.dart';
import 'package:aniflow/core/database/relations/media_list_and_media_relation.dart';
import 'package:aniflow/core/database/tables/media_list_table.dart';
import 'package:aniflow/core/database/tables/media_table.dart';
import 'package:collection/collection.dart';
import 'package:drift/drift.dart';

part 'media_list_dao.g.dart';

@DriftAccessor(tables: [MediaListTable, MediaTable])
class MediaListDao extends DatabaseAccessor<AniflowDatabase>
    with _$MediaListDaoMixin {
  MediaListDao(super.db);

  Future removeMediaListOfUser(String userId) {
    return (delete(mediaListTable)..where((t) => t.userId.equals(userId))).go();
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
        .map((value) => value.whereNotNull().toList());
  }

  Future<MediaListEntity?> getMediaListItem(String mediaId) {
    return (select(mediaListTable)
          ..where((tbl) => mediaListTable.mediaId.equals(mediaId)))
        .getSingleOrNull();
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
    await batch((batch) {
      batch.insertAll(
        mediaListTable,
        entities,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future deleteMediaListOfUser(String userId) {
    return (delete(mediaListTable)..where((tbl) => tbl.userId.equals(userId)))
        .go();
  }

  Stream<List<MediaListAndMediaRelation>> getAllMediaListOfUserStream(
      String userId, List<String> status, String mediaType) {
    List<MediaListAndMediaRelation> sortList(
        List<MediaListAndMediaRelation> list) {
      final map = list.groupListsBy(
          (e) => e.mediaEntity.nextAiringEpisodeUpdateTime != null);
      // Ordered by newest to oldest.
      final newUpdateList = (map[true] ?? [])
          .sortedBy((e) => e.mediaEntity.nextAiringEpisodeUpdateTime!)
          .reversed;
      final otherList = (map[false] ?? [])
          .sortedBy<num>((e) => e.mediaListEntity.updatedAt!)
          .reversed;
      return [...newUpdateList, ...otherList];
    }

    final query = select(mediaListTable).join([
      innerJoin(mediaTable, mediaListTable.mediaId.equalsExp(mediaTable.id))
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
    return batch((batch) {
      batch.insertAll(
        mediaListTable,
        entities.map((e) => e.mediaListEntity),
        mode: InsertMode.replace,
      );

      // insert the table or update columns except Value.absent().
      batch.insertAllOnConflictUpdate(
        mediaTable,
        entities.map((e) => e.mediaEntity.toCompanion(true)),
      );
    });
  }
}
