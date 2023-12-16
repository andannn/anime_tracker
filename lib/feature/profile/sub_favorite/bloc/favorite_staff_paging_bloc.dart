import 'dart:async';

import 'package:aniflow/core/common/util/global_static_constants.dart';
import 'package:aniflow/core/data/favorite_repository.dart';
import 'package:aniflow/core/data/load_result.dart';
import 'package:aniflow/core/data/model/staff_model.dart';
import 'package:aniflow/core/paging/page_loading_state.dart';
import 'package:aniflow/core/paging/refresh_paging_bloc.dart';
import 'package:dio/dio.dart';

class FavoriteStaffPagingBloc extends RefreshPagingBloc<StaffModel> {
  FavoriteStaffPagingBloc(
    this.userId, {
    this.perPageCount = AfConfig.profilePageDefaultPerPageCount,
    required FavoriteRepository favoriteRepository,
  })  : _favoriteRepository = favoriteRepository,
        super(const PageInit(data: []));

  final String userId;
  final FavoriteRepository _favoriteRepository;
  final int perPageCount;

  @override
  Future<LoadResult<List<StaffModel>>> loadPage({
    required int page,
    bool isRefresh = false,
    CancelToken? cancelToken,
  }) {
    return _favoriteRepository.loadFavoriteStaffByPage(
      userId: userId,
      loadType: isRefresh
          ? Refresh(perPageCount)
          : Append(page: page, perPage: perPageCount),
      token: cancelToken,
    );
  }
}
