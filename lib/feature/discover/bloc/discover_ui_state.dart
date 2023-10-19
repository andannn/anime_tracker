import 'package:anime_tracker/core/common/model/anime_category.dart';
import 'package:anime_tracker/core/data/model/media_model.dart';
import 'package:anime_tracker/core/data/model/user_data_model.dart';
import 'package:anime_tracker/feature/common/page_loading_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'discover_ui_state.freezed.dart';

@freezed
class DiscoverUiState with _$DiscoverUiState {
  factory DiscoverUiState({
    @Default(false) bool isLoading,
    @Default({
      MediaCategory.currentSeasonAnime: PageLoading(data: [], page: 1),
      MediaCategory.nextSeasonAnime: PageLoading(data: [], page: 1),
      MediaCategory.trendingAnime: PageLoading(data: [], page: 1),
      MediaCategory.movieAnime: PageLoading(data: [], page: 1),
      MediaCategory.trendingManga: PageLoading(data: [], page: 1),
      MediaCategory.allTimePopularManga: PageLoading(data: [], page: 1),
    })
    Map<MediaCategory, PagingState<List<MediaModel>>> categoryMediaMap,
    UserData? userData,
  }) = _DiscoverUiState;

  static DiscoverUiState copyWithTrackedIds(
      DiscoverUiState state, Set<String> ids) {
    Map<MediaCategory, PagingState<List<MediaModel>>> stateMap =
        state.categoryMediaMap.map(
      (key, value) => MapEntry(
        key,
        value.updateWith(
          (animeList) => animeList
              .map((e) => e.copyWith(isFollowing: ids.contains(e.id)))
              .toList(),
        ),
      ),
    );

    return state.copyWith(categoryMediaMap: stateMap);
  }
}
