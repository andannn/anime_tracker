// ignore_for_file: avoid_dynamic_calls

import 'package:aniflow/app/di/env.dart';
import 'package:aniflow/core/common/definitions/user_statics_sort.dart';
import 'package:aniflow/core/common/definitions/user_stats_type.dart';
import 'package:aniflow/core/data/load_result.dart';
import 'package:aniflow/core/data/mappers/media_mapper.dart';
import 'package:aniflow/core/data/model/media_model.dart';
import 'package:aniflow/core/data/model/user_statistics_model.dart';
import 'package:aniflow/core/database/dao/media_dao.dart';
import 'package:aniflow/core/network/ani_list_data_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(env: [AfEnvironment.mobile, AfEnvironment.desktop])
class UserStatisticsRepository {
  UserStatisticsRepository(
    this.mediaDao,
    this.dataSource,
  );

  final AniListDataSource dataSource;
  final MediaDao mediaDao;

  Future<LoadResult<List<UserStatisticsModel>>> getUserStatics(
      {required String userId,
      required UserStatisticType type,
      required UserStaticsSort sort,
      CancelToken? cancelToken}) async {
    try {
      final List statsDto =
          await dataSource.getUserStatistic(userId, type, sort, cancelToken);
      return LoadSuccess(
          data:
              statsDto.map((dto) => UserStatisticsModel.fromDto(dto)).toList());
    } on Exception catch (e) {
      return LoadError(e);
    }
  }

  Future<LoadResult<List<MediaModel>>> getMediasById(
      {required List<String> ids, CancelToken? cancelToken}) async {
    try {
      final cachedMediaEntities = await mediaDao.getMedias(ids);
      if (cachedMediaEntities.length == ids.length) {
        final result = cachedMediaEntities.map((e) => e.toModel()).toList();
        return LoadSuccess(data: result);
      }

      final mediaDtoList = await dataSource.getMediasById(ids, cancelToken);

      final mediaModelList = mediaDtoList.map((e) => e.toModel()).toList();

      return LoadSuccess(data: mediaModelList);
    } on DioException catch (e) {
      return LoadError(e);
    }
  }
}
