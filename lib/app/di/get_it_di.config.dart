// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:aniflow/app/app_bloc.dart' as _i343;
import 'package:aniflow/core/background_task/di/workmanager_module.dart'
    as _i555;
import 'package:aniflow/core/background_task/executors/post_anilist_notification_task_executor.dart'
    as _i462;
import 'package:aniflow/core/background_task/executors/sync_new_released_play_source_executor.dart'
    as _i855;
import 'package:aniflow/core/background_task/task_manager.dart' as _i490;
import 'package:aniflow/core/common/definitions/activity_filter_type.dart'
    as _i196;
import 'package:aniflow/core/common/definitions/activity_scope_category.dart'
    as _i650;
import 'package:aniflow/core/common/definitions/media_category.dart' as _i505;
import 'package:aniflow/core/common/definitions/media_sort.dart' as _i797;
import 'package:aniflow/core/common/definitions/media_type.dart' as _i55;
import 'package:aniflow/core/common/definitions/staff_language.dart' as _i115;
import 'package:aniflow/core/common/util/loading_state_mixin.dart' as _i636;
import 'package:aniflow/core/data/activity_repository.dart' as _i951;
import 'package:aniflow/core/data/auth_repository.dart' as _i768;
import 'package:aniflow/core/data/character_repository.dart' as _i14;
import 'package:aniflow/core/data/favorite_repository.dart' as _i462;
import 'package:aniflow/core/data/github_repository.dart' as _i309;
import 'package:aniflow/core/data/hi_animation_repository.dart' as _i827;
import 'package:aniflow/core/data/media_information_repository.dart' as _i970;
import 'package:aniflow/core/data/media_list_repository.dart' as _i319;
import 'package:aniflow/core/data/message_repository.dart' as _i67;
import 'package:aniflow/core/data/mocks/mock_auth_repository.dart' as _i91;
import 'package:aniflow/core/data/mocks/mock_favorite_repository.dart' as _i989;
import 'package:aniflow/core/data/mocks/mock_hi_animation_repository.dart'
    as _i944;
import 'package:aniflow/core/data/mocks/mock_media_information_repository.dart'
    as _i784;
import 'package:aniflow/core/data/mocks/mock_media_list_repository.dart'
    as _i949;
import 'package:aniflow/core/data/mocks/mock_message_repository.dart' as _i752;
import 'package:aniflow/core/data/mocks/mock_user_data_repository.dart'
    as _i520;
import 'package:aniflow/core/data/notification_repository.dart' as _i221;
import 'package:aniflow/core/data/search_repository.dart' as _i365;
import 'package:aniflow/core/data/user_data_repository.dart' as _i810;
import 'package:aniflow/core/data/user_info_repository.dart' as _i1066;
import 'package:aniflow/core/data/user_statistics_repository.dart' as _i227;
import 'package:aniflow/core/database/aniflow_database.dart' as _i545;
import 'package:aniflow/core/database/dao/activity_dao.dart' as _i302;
import 'package:aniflow/core/database/dao/airing_schedules_dao.dart' as _i1007;
import 'package:aniflow/core/database/dao/character_dao.dart' as _i595;
import 'package:aniflow/core/database/dao/episode_dao.dart' as _i393;
import 'package:aniflow/core/database/dao/favorite_dao.dart' as _i609;
import 'package:aniflow/core/database/dao/github_release_dao.dart' as _i115;
import 'package:aniflow/core/database/dao/media_dao.dart' as _i509;
import 'package:aniflow/core/database/dao/media_list_dao.dart' as _i29;
import 'package:aniflow/core/database/dao/staff_dao.dart' as _i339;
import 'package:aniflow/core/database/dao/studio_dao.dart' as _i159;
import 'package:aniflow/core/database/dao/user_dao.dart' as _i874;
import 'package:aniflow/core/database/di/database_module.dart' as _i669;
import 'package:aniflow/core/firebase/remote_config/di/remote_config_module.dart'
    as _i345;
import 'package:aniflow/core/firebase/remote_config/remote_config_manager.dart'
    as _i630;
import 'package:aniflow/core/network/ani_list_data_source.dart' as _i1001;
import 'package:aniflow/core/network/auth_data_source.dart' as _i1026;
import 'package:aniflow/core/network/di/di_network_module.dart' as _i106;
import 'package:aniflow/core/network/github_data_source.dart' as _i70;
import 'package:aniflow/core/network/hianime_data_source.dart' as _i638;
import 'package:aniflow/core/platform/auth_event_channel.dart' as _i4;
import 'package:aniflow/core/platform/di/auth_event_channel_module.dart'
    as _i329;
import 'package:aniflow/core/shared_preference/di/shared_preferences_module.dart'
    as _i365;
import 'package:aniflow/core/shared_preference/user_data_preferences.dart'
    as _i918;
import 'package:aniflow/feature/activity_replies/bloc/activity_replies_bloc.dart'
    as _i553;
import 'package:aniflow/feature/airing_schedule/airing_schedule_of_day/airing_schedule_of_day_bloc.dart'
    as _i376;
import 'package:aniflow/feature/airing_schedule/movie_schedule_time_line/movie_schedule_time_line_bloc.dart'
    as _i336;
import 'package:aniflow/feature/aniflow_home/aniflow_home_bloc.dart' as _i86;
import 'package:aniflow/feature/auth/bloc/auth_bloc.dart' as _i554;
import 'package:aniflow/feature/birthday_characters_page/birthday_character_page_bloc.dart'
    as _i951;
import 'package:aniflow/feature/character_page/bloc/character_page_bloc.dart'
    as _i234;
import 'package:aniflow/feature/character_page/bloc/character_paging_bloc.dart'
    as _i317;
import 'package:aniflow/feature/detail_character/bloc/detail_character_bloc.dart'
    as _i787;
import 'package:aniflow/feature/detail_media/bloc/detail_media_bloc.dart'
    as _i789;
import 'package:aniflow/feature/detail_staff/bloc/detail_staff_bloc.dart'
    as _i436;
import 'package:aniflow/feature/detail_staff/bloc/voice_actor_contents_paging_bloc.dart'
    as _i801;
import 'package:aniflow/feature/detail_studio/bloc/detail_studio_bloc.dart'
    as _i947;
import 'package:aniflow/feature/detail_studio/bloc/studio_contents_paging_bloc.dart'
    as _i409;
import 'package:aniflow/feature/discover/airing_schedule/today_airing_schedule_bloc.dart'
    as _i779;
import 'package:aniflow/feature/discover/birthday_characters/birthday_characters_bloc.dart'
    as _i854;
import 'package:aniflow/feature/discover/discover_bloc.dart' as _i111;
import 'package:aniflow/feature/discover/media_category_preview/media_category_preview_bloc.dart'
    as _i103;
import 'package:aniflow/feature/discover/next_to_watch/next_to_watch_bloc.dart'
    as _i742;
import 'package:aniflow/feature/discover/recent_movies/recent_movies_bloc.dart'
    as _i1013;
import 'package:aniflow/feature/edit_profile/bloc/edit_profile_bloc.dart'
    as _i847;
import 'package:aniflow/feature/media_list_update_page/bloc/media_list_update_bloc.dart'
    as _i782;
import 'package:aniflow/feature/media_page/bloc/media_page_bloc.dart' as _i748;
import 'package:aniflow/feature/media_track/bloc/track_bloc.dart' as _i552;
import 'package:aniflow/feature/notification/bloc/notification_bloc.dart'
    as _i953;
import 'package:aniflow/feature/notification/bloc/notification_paging_bloc.dart'
    as _i57;
import 'package:aniflow/feature/profile/profile_bloc.dart' as _i688;
import 'package:aniflow/feature/profile/sub_activity/user_activity_paging_bloc.dart'
    as _i131;
import 'package:aniflow/feature/profile/sub_favorite/profile_favorite_bloc.dart'
    as _i440;
import 'package:aniflow/feature/profile/sub_media_list/profile_media_list_bloc.dart'
    as _i653;
import 'package:aniflow/feature/profile/sub_stats/bloc/stats_bloc.dart'
    as _i231;
import 'package:aniflow/feature/search/bloc/search_bloc.dart' as _i993;
import 'package:aniflow/feature/search/paging/character_search_result_paging_bloc.dart'
    as _i982;
import 'package:aniflow/feature/search/paging/media_search_result_paging_bloc.dart'
    as _i425;
import 'package:aniflow/feature/search/paging/staff_search_result_paging_bloc.dart'
    as _i204;
import 'package:aniflow/feature/search/paging/studio_search_result_paging_bloc.dart'
    as _i214;
import 'package:aniflow/feature/search/paging/user_search_result_paging_bloc.dart'
    as _i842;
import 'package:aniflow/feature/settings/check_for_update/check_for_update_bloc.dart'
    as _i308;
import 'package:aniflow/feature/settings/github_link/github_link_bloc.dart'
    as _i1008;
import 'package:aniflow/feature/settings/settings_bloc.dart' as _i565;
import 'package:aniflow/feature/social/activity/bloc/activity_bloc.dart'
    as _i619;
import 'package:aniflow/feature/social/activity/bloc/activity_item_bloc.dart'
    as _i593;
import 'package:aniflow/feature/social/activity/bloc/activity_paging_bloc.dart'
    as _i860;
import 'package:aniflow/feature/staff_page/bloc/staff_page_bloc.dart' as _i782;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_remote_config/firebase_remote_config.dart' as _i627;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:platform_extractor/platform_extractor.dart' as _i974;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:workmanager/workmanager.dart' as _i500;

const String _Mock = 'Mock';
const String _Mobile = 'Mobile';
const String _Desktop = 'Desktop';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final platformEventChannelModule = _$PlatformEventChannelModule();
    final dIFirebaseRemoteConfigModule = _$DIFirebaseRemoteConfigModule();
    final dIDataBaseModule = _$DIDataBaseModule();
    final registerModule = _$RegisterModule();
    final dIWorkmanagerModule = _$DIWorkmanagerModule();
    final dINetworkModule = _$DINetworkModule();
    gh.factory<_i953.NotificationBloc>(() => _i953.NotificationBloc());
    gh.lazySingleton<_i4.AuthEventChannel>(
        () => platformEventChannelModule.getAuthEventChannel());
    gh.lazySingleton<_i974.PlatformExtractor>(
        () => platformEventChannelModule.getPlatformExtractor());
    gh.lazySingleton<_i827.HiAnimationRepository>(
      () => _i944.MockHiAnimationRepository(),
      registerFor: {_Mock},
    );
    gh.lazySingleton<_i970.MediaInformationRepository>(
      () => _i784.MockMediaInformationRepository(),
      registerFor: {_Mock},
    );
    gh.lazySingleton<_i67.MessageRepository>(
      () => _i752.MockMessageRepository(),
      registerFor: {_Mock},
    );
    gh.lazySingleton<_i462.FavoriteRepository>(
      () => _i989.MockFavoriteRepository(),
      registerFor: {_Mock},
    );
    gh.lazySingleton<_i319.MediaListRepository>(
      () => _i949.MockMediaListRepository(),
      registerFor: {_Mock},
    );
    gh.lazySingleton<_i768.AuthRepository>(
      () => _i91.MockAuthRepository(),
      registerFor: {_Mock},
    );
    gh.lazySingleton<_i810.UserDataRepository>(
      () => _i520.MockUserDataRepository(),
      registerFor: {_Mock},
    );
    gh.factory<_i565.SettingsBloc>(() => _i565.SettingsBloc(
          gh<_i810.UserDataRepository>(),
          gh<_i768.AuthRepository>(),
          gh<_i67.MessageRepository>(),
        ));
    gh.factory<_i336.MovieScheduleTimeLineBloc>(
        () => _i336.MovieScheduleTimeLineBloc(
              gh<_i970.MediaInformationRepository>(),
              gh<_i67.MessageRepository>(),
              gh<_i810.UserDataRepository>(),
            ));
    await gh.lazySingletonAsync<_i627.FirebaseRemoteConfig>(
      () => dIFirebaseRemoteConfigModule.remoteConfig,
      registerFor: {
        _Mobile,
        _Desktop,
      },
      preResolve: true,
    );
    gh.lazySingleton<_i67.MessageRepository>(
      () => _i67.MessageRepository(),
      registerFor: {
        _Mobile,
        _Desktop,
      },
    );
    await gh.factoryAsync<_i545.AniflowDatabase>(
      () => dIDataBaseModule.database,
      registerFor: {
        _Mobile,
        _Desktop,
      },
      preResolve: true,
    );
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      registerFor: {
        _Mobile,
        _Desktop,
      },
      preResolve: true,
    );
    await gh.lazySingletonAsync<_i500.Workmanager>(
      () => dIWorkmanagerModule.workManager,
      registerFor: {_Mobile},
      preResolve: true,
    );
    gh.factoryParam<_i748.AnimePageBloc, _i505.MediaCategory, dynamic>((
      category,
      _,
    ) =>
        _i748.AnimePageBloc(
          category,
          gh<_i970.MediaInformationRepository>(),
          gh<_i319.MediaListRepository>(),
          gh<_i768.AuthRepository>(),
          gh<_i810.UserDataRepository>(),
        ));
    gh.factory<_i552.TrackBloc>(() => _i552.TrackBloc(
          gh<_i319.MediaListRepository>(),
          gh<_i768.AuthRepository>(),
          gh<_i810.UserDataRepository>(),
          gh<_i67.MessageRepository>(),
        ));
    gh.factory<_i993.SearchBloc>(
        () => _i993.SearchBloc(gh<_i810.UserDataRepository>()));
    gh.factory<_i234.CharacterPageBloc>(
        () => _i234.CharacterPageBloc(gh<_i810.UserDataRepository>()));
    gh.factoryParam<_i376.AiringScheduleOfDayBloc, DateTime, dynamic>((
      _dateTime,
      _,
    ) =>
        _i376.AiringScheduleOfDayBloc(
          _dateTime,
          gh<_i970.MediaInformationRepository>(),
          gh<_i67.MessageRepository>(),
        ));
    gh.factory<_i554.AuthBloc>(() => _i554.AuthBloc(
          gh<_i768.AuthRepository>(),
          gh<_i67.MessageRepository>(),
        ));
    gh.factory<_i847.EditProfileBloc>(
        () => _i847.EditProfileBloc(gh<_i768.AuthRepository>()));
    gh.lazySingleton<_i918.UserDataPreferences>(
        () => _i918.UserDataPreferences(gh<_i460.SharedPreferences>()));
    gh.factoryParam<_i782.StaffPageBloc, String, dynamic>((
      animeId,
      _,
    ) =>
        _i782.StaffPageBloc(
          animeId,
          gh<_i970.MediaInformationRepository>(),
          gh<_i810.UserDataRepository>(),
        ));
    gh.factoryParam<_i787.DetailCharacterBloc, String, dynamic>((
      _characterId,
      _,
    ) =>
        _i787.DetailCharacterBloc(
          _characterId,
          gh<_i970.MediaInformationRepository>(),
          gh<_i67.MessageRepository>(),
          gh<_i462.FavoriteRepository>(),
          gh<_i810.UserDataRepository>(),
        ));
    gh.factoryParam<_i317.CharacterPagingBloc, String, _i115.StaffLanguage>((
      animeId,
      staffLanguage,
    ) =>
        _i317.CharacterPagingBloc(
          animeId,
          staffLanguage,
          gh<_i970.MediaInformationRepository>(),
        ));
    gh.factoryParam<_i779.TodayAiringScheduleBloc, String?, dynamic>((
      userId,
      _,
    ) =>
        _i779.TodayAiringScheduleBloc(
          userId,
          gh<_i970.MediaInformationRepository>(),
          gh<_i319.MediaListRepository>(),
        ));
    gh.factory<_i343.AppBloc>(
        () => _i343.AppBloc(gh<_i810.UserDataRepository>()));
    gh.factoryParam<_i801.VoiceActorContentsPagingBloc, String,
        _i797.MediaSort>((
      staffId,
      mediaSort,
    ) =>
        _i801.VoiceActorContentsPagingBloc(
          staffId,
          gh<_i970.MediaInformationRepository>(),
          mediaSort,
        ));
    gh.factoryParam<_i947.DetailStudioBloc, String, dynamic>((
      studioId,
      _,
    ) =>
        _i947.DetailStudioBloc(
          studioId,
          gh<_i970.MediaInformationRepository>(),
          gh<_i462.FavoriteRepository>(),
          gh<_i810.UserDataRepository>(),
          gh<_i67.MessageRepository>(),
        ));
    gh.factoryParam<_i103.MediaCategoryPreviewBloc,
        _i103.MediaCategoryPreviewParams, dynamic>((
      _params,
      _,
    ) =>
        _i103.MediaCategoryPreviewBloc(
          _params,
          gh<_i970.MediaInformationRepository>(),
          gh<_i319.MediaListRepository>(),
        ));
    gh.factory<_i855.SyncNewReleasedPlaySourceExecutor>(
        () => _i855.SyncNewReleasedPlaySourceExecutor(
              gh<_i827.HiAnimationRepository>(),
              gh<_i319.MediaListRepository>(),
              gh<_i768.AuthRepository>(),
            ));
    gh.factoryParam<_i789.DetailMediaBloc, String, dynamic>((
      mediaId,
      _,
    ) =>
        _i789.DetailMediaBloc(
          mediaId,
          gh<_i768.AuthRepository>(),
          gh<_i462.FavoriteRepository>(),
          gh<_i810.UserDataRepository>(),
          gh<_i970.MediaInformationRepository>(),
          gh<_i319.MediaListRepository>(),
          gh<_i827.HiAnimationRepository>(),
          gh<_i67.MessageRepository>(),
        ));
    gh.factoryParam<_i436.DetailStaffBloc, String, dynamic>((
      staffId,
      _,
    ) =>
        _i436.DetailStaffBloc(
          staffId,
          gh<_i970.MediaInformationRepository>(),
          gh<_i67.MessageRepository>(),
          gh<_i462.FavoriteRepository>(),
          gh<_i810.UserDataRepository>(),
        ));
    gh.factoryParam<_i782.MediaListUpdateBloc, String, dynamic>((
      _mediaId,
      _,
    ) =>
        _i782.MediaListUpdateBloc(
          _mediaId,
          gh<_i319.MediaListRepository>(),
        ));
    gh.factory<_i874.UserDao>(
        () => dIDataBaseModule.getUserDao(gh<_i545.AniflowDatabase>()));
    gh.factory<_i159.StudioDao>(
        () => dIDataBaseModule.getStudioDao(gh<_i545.AniflowDatabase>()));
    gh.factory<_i339.StaffDao>(
        () => dIDataBaseModule.getStaffDao(gh<_i545.AniflowDatabase>()));
    gh.factory<_i302.ActivityDao>(
        () => dIDataBaseModule.getActivityDao(gh<_i545.AniflowDatabase>()));
    gh.factory<_i1007.AiringSchedulesDao>(() =>
        dIDataBaseModule.getAiringSchedulesDao(gh<_i545.AniflowDatabase>()));
    gh.factory<_i595.CharacterDao>(
        () => dIDataBaseModule.geCharacterDao(gh<_i545.AniflowDatabase>()));
    gh.factory<_i29.MediaListDao>(
        () => dIDataBaseModule.geMediaListDao(gh<_i545.AniflowDatabase>()));
    gh.factory<_i509.MediaDao>(
        () => dIDataBaseModule.geMediaDao(gh<_i545.AniflowDatabase>()));
    gh.factory<_i609.FavoriteDao>(
        () => dIDataBaseModule.geFavoriteDao(gh<_i545.AniflowDatabase>()));
    gh.factory<_i393.EpisodeDao>(
        () => dIDataBaseModule.geEpisodeDao(gh<_i545.AniflowDatabase>()));
    gh.factory<_i115.GithubReleaseDao>(() =>
        dIDataBaseModule.getGithubReleaseDao(gh<_i545.AniflowDatabase>()));
    gh.factory<_i1013.RecentMoviesBloc>(
        () => _i1013.RecentMoviesBloc(gh<_i970.MediaInformationRepository>()));
    gh.lazySingleton<_i630.RemoteConfigManager>(
        () => _i630.RemoteConfigManager(gh<_i627.FirebaseRemoteConfig>()));
    gh.factoryParam<_i742.NextToWatchBloc, String?, _i55.MediaType>((
      _userId,
      _mediaType,
    ) =>
        _i742.NextToWatchBloc(
          _userId,
          _mediaType,
          gh<_i319.MediaListRepository>(),
        ));
    gh.lazySingleton<_i361.Dio>(
      () => dINetworkModule.getDio(gh<_i918.UserDataPreferences>()),
      registerFor: {
        _Mobile,
        _Desktop,
      },
    );
    gh.factoryParam<_i653.ProfileMediaListBloc, _i653.ProfileMediaListParam,
        _i636.LoadingStateRepository>((
      param,
      _loadingStateRepository,
    ) =>
        _i653.ProfileMediaListBloc(
          param,
          _loadingStateRepository,
          gh<_i319.MediaListRepository>(),
          gh<_i810.UserDataRepository>(),
        ));
    gh.lazySingleton<_i1001.AniListDataSource>(
        () => _i1001.AniListDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i1026.AuthDataSource>(
        () => _i1026.AuthDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i70.GithubDataSource>(
        () => _i70.GithubDataSource(gh<_i361.Dio>()));
    gh.factoryParam<_i409.StudioContentsPagingBloc, String, dynamic>((
      studioId,
      _,
    ) =>
        _i409.StudioContentsPagingBloc(
          studioId,
          gh<_i970.MediaInformationRepository>(),
        ));
    gh.factoryParam<_i440.ProfileFavoriteBloc, String,
        _i636.LoadingStateRepository>((
      userId,
      _loadingStateRepository,
    ) =>
        _i440.ProfileFavoriteBloc(
          userId,
          _loadingStateRepository,
          gh<_i462.FavoriteRepository>(),
          gh<_i810.UserDataRepository>(),
        ));
    gh.lazySingleton<_i14.CharacterRepository>(
      () => _i14.CharacterRepository(
        gh<_i595.CharacterDao>(),
        gh<_i1001.AniListDataSource>(),
      ),
      registerFor: {
        _Mobile,
        _Desktop,
      },
    );
    gh.lazySingleton<_i810.UserDataRepository>(
      () => _i810.UserDataRepository(
        gh<_i918.UserDataPreferences>(),
        gh<_i630.RemoteConfigManager>(),
        gh<_i115.GithubReleaseDao>(),
      ),
      registerFor: {
        _Mobile,
        _Desktop,
      },
    );
    gh.lazySingleton<_i638.HiAnimationDataSource>(
        () => _i638.HiAnimationDataSource(dio: gh<_i361.Dio>()));
    gh.lazySingleton<_i319.MediaListRepository>(
      () => _i319.MediaListRepository(
        gh<_i1026.AuthDataSource>(),
        gh<_i1001.AniListDataSource>(),
        gh<_i29.MediaListDao>(),
        gh<_i509.MediaDao>(),
        gh<_i918.UserDataPreferences>(),
      ),
      registerFor: {
        _Mobile,
        _Desktop,
      },
    );
    gh.lazySingleton<_i1066.UserInfoRepository>(
      () => _i1066.UserInfoRepository(gh<_i874.UserDao>()),
      registerFor: {
        _Mobile,
        _Desktop,
      },
    );
    gh.lazySingleton<_i365.SearchRepository>(
      () => _i365.SearchRepository(
        gh<_i1001.AniListDataSource>(),
        gh<_i509.MediaDao>(),
        gh<_i595.CharacterDao>(),
        gh<_i339.StaffDao>(),
        gh<_i159.StudioDao>(),
        gh<_i874.UserDao>(),
      ),
      registerFor: {
        _Mobile,
        _Desktop,
      },
    );
    gh.lazySingleton<_i970.MediaInformationRepository>(
      () => _i970.MediaInformationRepository(
        gh<_i1001.AniListDataSource>(),
        gh<_i595.CharacterDao>(),
        gh<_i339.StaffDao>(),
        gh<_i159.StudioDao>(),
        gh<_i1007.AiringSchedulesDao>(),
        gh<_i509.MediaDao>(),
        gh<_i918.UserDataPreferences>(),
      ),
      registerFor: {
        _Mobile,
        _Desktop,
      },
    );
    gh.factory<_i111.DiscoverBloc>(() => _i111.DiscoverBloc(
          gh<_i768.AuthRepository>(),
          gh<_i970.MediaInformationRepository>(),
          gh<_i319.MediaListRepository>(),
          gh<_i810.UserDataRepository>(),
          gh<_i67.MessageRepository>(),
          gh<_i14.CharacterRepository>(),
        ));
    gh.lazySingleton<_i227.UserStatisticsRepository>(
      () => _i227.UserStatisticsRepository(
        gh<_i509.MediaDao>(),
        gh<_i1001.AniListDataSource>(),
      ),
      registerFor: {
        _Mobile,
        _Desktop,
      },
    );
    gh.factoryParam<_i231.StatsBloc, String, _i636.LoadingStateRepository>((
      userId,
      _loadingStateRepository,
    ) =>
        _i231.StatsBloc(
          userId,
          _loadingStateRepository,
          gh<_i227.UserStatisticsRepository>(),
          gh<_i810.UserDataRepository>(),
        ));
    gh.lazySingleton<_i951.ActivityRepository>(
      () => _i951.ActivityRepository(
        gh<_i302.ActivityDao>(),
        gh<_i1001.AniListDataSource>(),
        gh<_i918.UserDataPreferences>(),
      ),
      registerFor: {
        _Mobile,
        _Desktop,
      },
    );
    gh.lazySingleton<_i462.FavoriteRepository>(
      () => _i462.FavoriteRepository(
        gh<_i1001.AniListDataSource>(),
        gh<_i509.MediaDao>(),
        gh<_i339.StaffDao>(),
        gh<_i595.CharacterDao>(),
        gh<_i609.FavoriteDao>(),
        gh<_i918.UserDataPreferences>(),
        gh<_i159.StudioDao>(),
      ),
      registerFor: {
        _Mobile,
        _Desktop,
      },
    );
    gh.lazySingleton<_i309.GithubRepository>(
      () => _i309.GithubRepository(
        gh<_i70.GithubDataSource>(),
        gh<_i918.UserDataPreferences>(),
        gh<_i115.GithubReleaseDao>(),
      ),
      registerFor: {
        _Mobile,
        _Desktop,
      },
    );
    gh.factory<_i1008.GithubLinkBloc>(
        () => _i1008.GithubLinkBloc(gh<_i309.GithubRepository>()));
    gh.factory<_i854.BirthdayCharactersBloc>(
        () => _i854.BirthdayCharactersBloc(gh<_i14.CharacterRepository>()));
    gh.factory<_i951.BirthdayCharacterPageBloc>(
        () => _i951.BirthdayCharacterPageBloc(gh<_i14.CharacterRepository>()));
    gh.lazySingleton<_i221.NotificationRepository>(
      () => _i221.NotificationRepository(
        gh<_i1026.AuthDataSource>(),
        gh<_i874.UserDao>(),
        gh<_i509.MediaDao>(),
      ),
      registerFor: {
        _Mobile,
        _Desktop,
      },
    );
    gh.lazySingleton<_i768.AuthRepository>(
      () => _i768.AuthRepository(
        gh<_i1026.AuthDataSource>(),
        gh<_i874.UserDao>(),
        gh<_i918.UserDataPreferences>(),
        gh<_i4.AuthEventChannel>(),
      ),
      registerFor: {
        _Mobile,
        _Desktop,
      },
    );
    gh.factoryParam<_i688.ProfileBloc, String?, dynamic>((
      _userId,
      _,
    ) =>
        _i688.ProfileBloc(
          _userId,
          gh<_i1066.UserInfoRepository>(),
          gh<_i810.UserDataRepository>(),
          gh<_i67.MessageRepository>(),
        ));
    gh.factory<_i619.ActivityBloc>(
        () => _i619.ActivityBloc(gh<_i951.ActivityRepository>()));
    gh.factoryParam<_i131.UserActivityPagingBloc, String, dynamic>((
      userId,
      _,
    ) =>
        _i131.UserActivityPagingBloc(
          userId,
          gh<_i951.ActivityRepository>(),
          gh<_i810.UserDataRepository>(),
        ));
    gh.factoryParam<_i57.NotificationPagingBloc, _i221.NotificationCategory,
        dynamic>((
      _category,
      _,
    ) =>
        _i57.NotificationPagingBloc(
          gh<_i221.NotificationRepository>(),
          _category,
        ));
    gh.lazySingleton<_i827.HiAnimationRepository>(
      () => _i827.HiAnimationRepository(
        gh<_i638.HiAnimationDataSource>(),
        gh<_i393.EpisodeDao>(),
        gh<_i918.UserDataPreferences>(),
        gh<_i974.PlatformExtractor>(),
      ),
      registerFor: {
        _Mobile,
        _Desktop,
      },
    );
    gh.singleton<_i490.BackgroundTaskManager>(
      () => _i490.BackgroundTaskManager(
        gh<_i768.AuthRepository>(),
        gh<_i500.Workmanager>(),
      ),
      registerFor: {_Mobile},
    );
    gh.factoryParam<_i860.ActivityPagingBloc, _i650.ActivityScopeCategory,
        _i196.ActivityFilterType>((
      userType,
      filterType,
    ) =>
        _i860.ActivityPagingBloc(
          gh<_i951.ActivityRepository>(),
          gh<_i810.UserDataRepository>(),
          userType,
          filterType,
        ));
    gh.factoryParam<_i214.StudioSearchResultPagingBloc, String, dynamic>((
      _searchString,
      _,
    ) =>
        _i214.StudioSearchResultPagingBloc(
          _searchString,
          gh<_i365.SearchRepository>(),
        ));
    gh.factoryParam<_i842.UserSearchResultPagingBloc, String, dynamic>((
      _searchString,
      _,
    ) =>
        _i842.UserSearchResultPagingBloc(
          _searchString,
          gh<_i365.SearchRepository>(),
        ));
    gh.factoryParam<_i204.StaffSearchResultPagingBloc, String, dynamic>((
      _searchString,
      _,
    ) =>
        _i204.StaffSearchResultPagingBloc(
          _searchString,
          gh<_i365.SearchRepository>(),
        ));
    gh.factoryParam<_i982.CharacterSearchResultPagingBloc, String, dynamic>((
      _searchString,
      _,
    ) =>
        _i982.CharacterSearchResultPagingBloc(
          _searchString,
          gh<_i365.SearchRepository>(),
        ));
    gh.factoryParam<_i425.MediaSearchResultPagingBloc, _i55.MediaType, String>((
      _mediaType,
      _searchString,
    ) =>
        _i425.MediaSearchResultPagingBloc(
          _mediaType,
          _searchString,
          gh<_i365.SearchRepository>(),
          gh<_i810.UserDataRepository>(),
        ));
    gh.factory<_i86.AniflowHomeBloc>(() => _i86.AniflowHomeBloc(
          gh<_i810.UserDataRepository>(),
          gh<_i768.AuthRepository>(),
          gh<_i309.GithubRepository>(),
          gh<_i67.MessageRepository>(),
        ));
    gh.factoryParam<_i553.ActivityRepliesBloc, String, dynamic>((
      activityId,
      _,
    ) =>
        _i553.ActivityRepliesBloc(
          gh<_i951.ActivityRepository>(),
          gh<_i67.MessageRepository>(),
          activityId,
        ));
    gh.factoryParam<_i593.ActivityStatusBloc, String, dynamic>((
      activityId,
      _,
    ) =>
        _i593.ActivityStatusBloc(
          gh<_i951.ActivityRepository>(),
          gh<_i67.MessageRepository>(),
          activityId,
        ));
    gh.factory<_i308.CheckForUpdateBloc>(() => _i308.CheckForUpdateBloc(
          gh<_i67.MessageRepository>(),
          gh<_i309.GithubRepository>(),
        ));
    gh.factory<_i462.PostAnilistNotificationExecutor>(
        () => _i462.PostAnilistNotificationExecutor(
              gh<_i221.NotificationRepository>(),
              gh<_i768.AuthRepository>(),
              gh<_i810.UserDataRepository>(),
            ));
    return this;
  }
}

class _$PlatformEventChannelModule extends _i329.PlatformEventChannelModule {}

class _$DIFirebaseRemoteConfigModule
    extends _i345.DIFirebaseRemoteConfigModule {}

class _$DIDataBaseModule extends _i669.DIDataBaseModule {}

class _$RegisterModule extends _i365.RegisterModule {}

class _$DIWorkmanagerModule extends _i555.DIWorkmanagerModule {}

class _$DINetworkModule extends _i106.DINetworkModule {}
