import 'dart:async';

import 'package:aniflow/app/local/ani_flow_localizations.dart';
import 'package:aniflow/core/common/definitions/media_list_status.dart';
import 'package:aniflow/core/common/util/error_handler.dart';
import 'package:aniflow/core/common/util/logger.dart';
import 'package:aniflow/core/data/auth_repository.dart';
import 'package:aniflow/core/data/favorite_repository.dart';
import 'package:aniflow/core/data/hi_animation_repository.dart';
import 'package:aniflow/core/data/load_result.dart';
import 'package:aniflow/core/data/media_information_repository.dart';
import 'package:aniflow/core/data/media_list_repository.dart';
import 'package:aniflow/core/data/model/anime_list_item_model.dart';
import 'package:aniflow/core/data/model/extension/media_list_item_model_extension.dart';
import 'package:aniflow/core/data/model/media_model.dart';
import 'package:aniflow/core/data/user_data_repository.dart';
import 'package:aniflow/core/design_system/widget/aniflow_snackbar.dart';
import 'package:aniflow/core/design_system/widget/update_media_list_bottom_sheet.dart';
import 'package:aniflow/feature/detail_media/bloc/detail_media_ui_state.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

sealed class DetailAnimeEvent {}

class _OnDetailAnimeModelChangedEvent extends DetailAnimeEvent {
  _OnDetailAnimeModelChangedEvent({required this.model});

  final MediaModel model;
}

class _OnMediaListItemChanged extends DetailAnimeEvent {
  _OnMediaListItemChanged({required this.mediaListItemModel});

  final MediaListItemModel? mediaListItemModel;
}

class OnMediaListModified extends DetailAnimeEvent {
  OnMediaListModified({required this.result});

  final MediaListModifyResult result;
}

class OnToggleFavoriteState extends DetailAnimeEvent {
  OnToggleFavoriteState({required this.isAnime, required this.mediaId});

  final bool isAnime;
  final String mediaId;
}

class _OnLoadingStateChanged extends DetailAnimeEvent {
  _OnLoadingStateChanged({required this.isLoading});

  final bool isLoading;
}

class _OnEpisodeFound extends DetailAnimeEvent {
  _OnEpisodeFound({required this.episode});

  final Episode episode;
}

class OnMarkWatchedClick extends DetailAnimeEvent {}

class _OnFindEpisodeError extends DetailAnimeEvent {
  _OnFindEpisodeError({
    required this.exception,
    this.searchUrl,
  });

  final Exception exception;
  final String? searchUrl;
}

class _OnStartFindSource extends DetailAnimeEvent {}

class HiAnimationSource extends Equatable {
  final int episode;
  final List<String> keywords;

  const HiAnimationSource(this.episode, this.keywords);

  @override
  List<Object?> get props => [episode, ...keywords];
}

sealed class LoadingState<T> {
  const LoadingState();
}

class None<T> extends LoadingState<T> {
  const None();
}

class Loading<T> extends LoadingState<T> {}

class Ready<T> extends LoadingState<T> {
  final T state;

  Ready(this.state);
}

class Error<T> extends LoadingState<T> {
  final Exception exception;
  final String? searchUrl;

  Error(this.exception, this.searchUrl);
}

@injectable
class DetailMediaBloc extends Bloc<DetailAnimeEvent, DetailMediaUiState> {
  DetailMediaBloc(
    @factoryParam this.mediaId,
    this._authRepository,
    this._favoriteRepository,
    this._userDataRepository,
    this._mediaRepository,
    this._mediaListRepository,
    this._hiAnimationRepository,
  ) : super(DetailMediaUiState(
          userTitleLanguage: _userDataRepository.userData.userTitleLanguage,
          userStaffNameLanguage:
          _userDataRepository.userData.userStaffNameLanguage,
          scoreFormat: _userDataRepository.userData.scoreFormat,
        )) {
    on<_OnDetailAnimeModelChangedEvent>(
      (event, emit) => emit(state.copyWith(detailAnimeModel: event.model)),
    );
    on<_OnMediaListItemChanged>(
      (event, emit) =>
          emit(state.copyWith(mediaListItem: event.mediaListItemModel)),
    );
    on<OnMediaListModified>(_onMediaListModified);
    on<OnToggleFavoriteState>(_onToggleFavoriteState);
    on<_OnLoadingStateChanged>(
      (event, emit) => emit(state.copyWith(isLoading: event.isLoading)),
    );
    on<_OnEpisodeFound>(
      (event, emit) => emit(state.copyWith(episode: Ready(event.episode))),
    );
    on<_OnFindEpisodeError>(
      (event, emit) => emit(
          state.copyWith(episode: Error(event.exception, event.searchUrl))),
    );
    on<_OnStartFindSource>(
      (event, emit) => emit(state.copyWith(episode: Loading())),
    );
    on<OnMarkWatchedClick>(_onMarkWatchedClick);

    _init();
  }

  final String mediaId;
  final MediaInformationRepository _mediaRepository;
  final MediaListRepository _mediaListRepository;
  final FavoriteRepository _favoriteRepository;
  final AuthRepository _authRepository;
  final HiAnimationRepository _hiAnimationRepository;
  final UserDataRepository _userDataRepository;

  HiAnimationSource? _hiAnimationSource;

  StreamSubscription? _detailAnimeSub;
  StreamSubscription? _isTrackingSub;

  CancelToken? _toggleFavoriteCancelToken;
  CancelToken? _networkActionCancelToken;
  CancelToken? _findPlaySourceCancelToken;

  void _init() async {
    _detailAnimeSub = _mediaRepository.getDetailMediaInfoStream(mediaId).listen(
      (animeModel) {
        add(_OnDetailAnimeModelChangedEvent(model: animeModel));
      },
    );

    final userData = await _authRepository.getAuthedUserStream().first;
    if (userData != null) {
      _isTrackingSub = _mediaListRepository
          .getMediaListItemByUserAndIdStream(
              userId: userData.id, animeId: mediaId)
          .listen(
        (item) {
          add(_OnMediaListItemChanged(mediaListItemModel: item));
        },
      );
    }

    /// start fetch detail anime info.
    /// detail info stream will emit new value when data ready.
    _startFetchDetailAnimeInfo();
  }

  @override
  void onChange(Change<DetailMediaUiState> change) {
    super.onChange(change);
    final progress = change.nextState.mediaListItem?.progress;
    final title = change.nextState.detailAnimeModel?.title;

    if (progress != null && title != null) {
      final hasNextReleasingEpisode =
          change.nextState.mediaListItem?.hasNextReleasingEpisode == true;
      final nextProgress = hasNextReleasingEpisode ? progress + 1 : null;
      if (nextProgress != null) {
        _updateHiAnimationSource(
          HiAnimationSource(
            nextProgress,
            [title.english, title.romaji, title.native]
                .where((e) => e.isNotEmpty)
                .toList(),
          ),
        );
      }
    }
  }

  @override
  Future<void> close() {
    _detailAnimeSub?.cancel();
    _isTrackingSub?.cancel();

    _toggleFavoriteCancelToken?.cancel();
    _networkActionCancelToken?.cancel();
    _findPlaySourceCancelToken?.cancel();

    return super.close();
  }

  void _startFetchDetailAnimeInfo() async {
    _networkActionCancelToken?.cancel();
    _networkActionCancelToken = CancelToken();

    add(_OnLoadingStateChanged(isLoading: true));
    await Future.wait([
      _mediaRepository.startFetchDetailAnimeInfo(
        id: mediaId,
        token: _networkActionCancelToken,
      ),
      _mediaListRepository.syncMediaListItem(
        mediaId: mediaId,
        format: _userDataRepository.userData.scoreFormat,
        token: _networkActionCancelToken,
      ),
    ]);
    add(_OnLoadingStateChanged(isLoading: false));
  }

  Future<void> _onMediaListModified(
      OnMediaListModified event, Emitter<DetailMediaUiState> emit) async {
    final state = event.result;

    add(_OnLoadingStateChanged(isLoading: true));
    final result = await _mediaListRepository.updateMediaList(
      animeId: mediaId,
      status: state.status,
      progress: state.progress,
      progressVolumes: state.progressVolumes,
      score: state.score,
      private: state.private,
      repeat: state.repeat,
      notes: state.notes,
      startedAt: state.startedAt,
      completedAt: state.completedAt,
    );
    add(_OnLoadingStateChanged(isLoading: false));

    if (result is LoadError) {
      ErrorHandler.handleException(exception: result.exception);
    }
  }

  FutureOr<void> _onToggleFavoriteState(
      OnToggleFavoriteState event, Emitter<DetailMediaUiState> emit) async {
    final isAnime = event.isAnime;
    final mediaId = event.mediaId;

    _toggleFavoriteCancelToken?.cancel();
    _toggleFavoriteCancelToken = CancelToken();
    if (isAnime) {
      unawaited(_favoriteRepository.toggleFavoriteAnime(
          mediaId, _toggleFavoriteCancelToken!));
    } else {
      unawaited(_favoriteRepository.toggleFavoriteManga(
          mediaId, _toggleFavoriteCancelToken!));
    }
  }

  void _updateHiAnimationSource(HiAnimationSource source) async {
    if (_hiAnimationSource != source) {
      _hiAnimationSource = source;
      _findPlaySourceCancelToken?.cancel();
      _findPlaySourceCancelToken = CancelToken();
      add(_OnStartFindSource());
      final result = await _hiAnimationRepository.searchPlaySourceByKeyword(
        source.keywords,
        source.episode.toString(),
        _findPlaySourceCancelToken,
      );

      switch (result) {
        case LoadError<Episode>(exception: final exception):
          logger.d('findPlaySource failed ${result.exception}');
          ErrorHandler.handleException(exception: result.exception);
          if (exception is NotFoundEpisodeException) {
            add(_OnFindEpisodeError(
                exception: result.exception, searchUrl: exception.searchUrl));
          } else {
            add(_OnFindEpisodeError(exception: result.exception));
          }
        case LoadSuccess<Episode>():
          logger.d('findPlaySource success ${result.data}');
          add(_OnEpisodeFound(episode: result.data));
      }
    }
  }

  FutureOr<void> _onMarkWatchedClick(
    OnMarkWatchedClick event,
    Emitter<DetailMediaUiState> emit,
  ) async {
    logger.d('_onMarkWatchedClick.');
    final listItem = state.mediaListItem;
    if (listItem == null) {
      logger.d('_onMarkWatchedClick. listItem is null.');
      return;
    }

    final currentProgress = listItem.progress ?? 0;
    final nextEpisode = currentProgress + 1;
    final isFinished = nextEpisode == listItem.animeModel?.episodes;
    final MediaListStatus status =
        isFinished ? MediaListStatus.completed : MediaListStatus.current;

    add(_OnLoadingStateChanged(isLoading: true));
    final result = await _mediaListRepository.updateMediaList(
        animeId: listItem.animeModel!.id,
        status: status,
        progress: nextEpisode);
    add(_OnLoadingStateChanged(isLoading: false));

    if (result is LoadError) {
      ErrorHandler.handleException(exception: result.exception);
    } else {
      if (isFinished) {
//TODO: change to score dialog.
        showSnackBarMessage(
          label: AFLocalizations.of().animeCompleted,
          duration: SnackBarDuration.short,
        );
      } else {
        showSnackBarMessage(
          label: AFLocalizations.of().animeMarkWatched,
          duration: SnackBarDuration.short,
        );
      }
    }
  }
}
