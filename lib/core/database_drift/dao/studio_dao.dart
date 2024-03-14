import 'package:aniflow/core/database_drift/aniflow_database.dart';
import 'package:aniflow/core/database_drift/tables/studio_media_cross_reference_table.dart';
import 'package:aniflow/core/database_drift/tables/studio_table.dart';
import 'package:drift/drift.dart';

part 'studio_dao.g.dart';

@DriftAccessor(tables: [StudioTable, StudioMediaCrossRefTable])
class StudioDao extends DatabaseAccessor<AniflowDatabase2>
    with _$StudioDaoMixin {
  StudioDao(super.db);

  Future<StudioEntity?> getStudio(String id) {
    return (select(studioTable)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Stream<StudioEntity?> getStudioStream(String id) {
    return (select(studioTable)..where((t) => t.id.equals(id)))
        .watchSingleOrNull();
  }

  Future upsertStudioEntities(List<StudioEntity> entities) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(studioTable, entities);
    });
  }

  Future insertOrIgnoreStudioEntitiesOfMedia(
    String mediaId,
    List<StudioEntity> entities,
  ) async {
    await batch((batch) async {
      for (final entity in entities) {
        batch.insert(studioTable, entity);
        batch.insert(
          studioMediaCrossRefTable,
          StudioMediaCrossRefTableCompanion.insert(
            studioId: entity.id,
            mediaId: mediaId,
          ),
        );
      }
    });
  }

  Future<List<StudioEntity>> getStudioOfMedia(String mediaId) {
    final query = select(studioTable).join(
      [
        innerJoin(studioMediaCrossRefTable,
            studioTable.id.equalsExp(studioMediaCrossRefTable.studioId))
      ],
    )..where(
        studioMediaCrossRefTable.mediaId.equals(mediaId) &
            studioTable.isAnimationStudio.equals(true),
      );

    return (query.map((row) => row.readTable(studioTable))).get();
  }
}
