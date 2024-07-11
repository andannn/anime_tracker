// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:aniflow/core/background_task/di/workmanager_module.dart'
    as _i92;
import 'package:aniflow/core/background_task/executors/post_anilist_notification_task_executor.dart'
    as _i64;
import 'package:aniflow/core/background_task/task_manager.dart' as _i69;
import 'package:aniflow/core/common/definitions/activity_filter_type.dart'
    as _i88;
import 'package:aniflow/core/common/definitions/activity_scope_category.dart'
    as _i87;
import 'package:aniflow/core/common/definitions/media_category.dart' as _i73;
import 'package:aniflow/core/common/definitions/media_sort.dart' as _i67;
import 'package:aniflow/core/common/definitions/media_type.dart' as _i38;
import 'package:aniflow/core/common/definitions/staff_language.dart' as _i61;
import 'package:aniflow/core/common/message/message.dart' as _i8;
import 'package:aniflow/core/data/activity_repository.dart' as _i44;
import 'package:aniflow/core/data/auth_repository.dart' as _i45;
import 'package:aniflow/core/data/character_repository.dart' as _i31;
import 'package:aniflow/core/data/favorite_repository.dart' as _i46;
import 'package:aniflow/core/data/hi_animation_repository.dart' as _i30;
import 'package:aniflow/core/data/media_information_repository.dart' as _i43;
import 'package:aniflow/core/data/media_list_repository.dart' as _i49;
import 'package:aniflow/core/data/notification_repository.dart' as _i27;
import 'package:aniflow/core/data/search_repository.dart' as _i36;
import 'package:aniflow/core/data/user_data_repository.dart' as _i28;
import 'package:aniflow/core/data/user_info_repository.dart' as _i23;
import 'package:aniflow/core/data/user_statistics_repository.dart' as _i24;
import 'package:aniflow/core/database/aniflow_database.dart' as _i5;
import 'package:aniflow/core/database/dao/activity_dao.dart' as _i13;
import 'package:aniflow/core/database/dao/airing_schedules_dao.dart' as _i14;
import 'package:aniflow/core/database/dao/character_dao.dart' as _i15;
import 'package:aniflow/core/database/dao/episode_dao.dart' as _i19;
import 'package:aniflow/core/database/dao/favorite_dao.dart' as _i18;
import 'package:aniflow/core/database/dao/media_dao.dart' as _i17;
import 'package:aniflow/core/database/dao/media_list_dao.dart' as _i16;
import 'package:aniflow/core/database/dao/staff_dao.dart' as _i12;
import 'package:aniflow/core/database/dao/studio_dao.dart' as _i11;
import 'package:aniflow/core/database/dao/user_dao.dart' as _i10;
import 'package:aniflow/core/database/di/database_module.dart' as _i91;
import 'package:aniflow/core/firebase/remote_config/di/remote_config_module.dart'
    as _i93;
import 'package:aniflow/core/firebase/remote_config/remote_config_manager.dart'
    as _i20;
import 'package:aniflow/core/network/ani_list_data_source.dart' as _i21;
import 'package:aniflow/core/network/auth_data_source.dart' as _i22;
import 'package:aniflow/core/network/di/di_network_module.dart' as _i57;
import 'package:aniflow/core/network/hianime_data_source.dart' as _i25;
import 'package:aniflow/core/shared_preference/di/shared_preferences_module.dart'
    as _i90;
import 'package:aniflow/core/shared_preference/user_data_preferences.dart'
    as _i26;
import 'package:aniflow/feature/activity_replies/bloc/activity_replies_bloc.dart'
    as _i48;
import 'package:aniflow/feature/airing_schedule/airing_schedule_of_day/airing_schedule_of_day_bloc.dart'
    as _i75;
import 'package:aniflow/feature/airing_schedule/movie_schedule_time_line/movie_schedule_time_line_bloc.dart'
    as _i85;
import 'package:aniflow/feature/aniflow_home/auth/bloc/auth_bloc.dart' as _i68;
import 'package:aniflow/feature/aniflow_home/discover/airing_schedule/today_airing_schedule_bloc.dart'
    as _i65;
import 'package:aniflow/feature/aniflow_home/discover/birthday_characters/birthday_characters_bloc.dart'
    as _i33;
import 'package:aniflow/feature/aniflow_home/discover/discover_bloc.dart'
    as _i70;
import 'package:aniflow/feature/aniflow_home/discover/media_category_preview/media_category_preview_bloc.dart'
    as _i79;
import 'package:aniflow/feature/aniflow_home/discover/next_to_watch/next_to_watch_bloc.dart'
    as _i82;
import 'package:aniflow/feature/aniflow_home/discover/recent_movies/recent_movies_bloc.dart'
    as _i80;
import 'package:aniflow/feature/aniflow_home/media_track/bloc/track_bloc.dart'
    as _i89;
import 'package:aniflow/feature/aniflow_home/social/activity/bloc/activity_bloc.dart'
    as _i78;
import 'package:aniflow/feature/aniflow_home/social/activity/bloc/activity_item_bloc.dart'
    as _i47;
import 'package:aniflow/feature/aniflow_home/social/activity/bloc/activity_paging_bloc.dart'
    as _i86;
import 'package:aniflow/feature/birthday_characters_page/birthday_character_page_bloc.dart'
    as _i32;
import 'package:aniflow/feature/character_page/bloc/character_page_bloc.dart'
    as _i53;
import 'package:aniflow/feature/character_page/bloc/character_paging_bloc.dart'
    as _i60;
import 'package:aniflow/feature/detail_character/bloc/detail_character_bloc.dart'
    as _i77;
import 'package:aniflow/feature/detail_media/bloc/detail_media_bloc.dart'
    as _i74;
import 'package:aniflow/feature/detail_staff/bloc/detail_staff_bloc.dart'
    as _i81;
import 'package:aniflow/feature/detail_staff/bloc/voice_actor_contents_paging_bloc.dart'
    as _i66;
import 'package:aniflow/feature/detail_studio/bloc/detail_studio_bloc.dart'
    as _i76;
import 'package:aniflow/feature/detail_studio/bloc/studio_contents_paging_bloc.dart'
    as _i84;
import 'package:aniflow/feature/edit_profile/bloc/edit_profile_bloc.dart'
    as _i54;
import 'package:aniflow/feature/media_list_update_page/bloc/media_list_update_bloc.dart'
    as _i71;
import 'package:aniflow/feature/media_page/bloc/media_page_bloc.dart' as _i72;
import 'package:aniflow/feature/notification/bloc/notification_bloc.dart'
    as _i4;
import 'package:aniflow/feature/notification/bloc/notification_paging_bloc.dart'
    as _i35;
import 'package:aniflow/feature/profile/profile_bloc.dart' as _i29;
import 'package:aniflow/feature/profile/sub_activity/user_activity_paging_bloc.dart'
    as _i59;
import 'package:aniflow/feature/profile/sub_favorite/bloc/favorite_anime_paging_bloc.dart'
    as _i55;
import 'package:aniflow/feature/profile/sub_favorite/bloc/favorite_character_paging_bloc.dart'
    as _i50;
import 'package:aniflow/feature/profile/sub_favorite/bloc/favorite_manga_paging_bloc.dart'
    as _i83;
import 'package:aniflow/feature/profile/sub_favorite/bloc/favorite_staff_paging_bloc.dart'
    as _i51;
import 'package:aniflow/feature/profile/sub_media_list/bloc/anime_list_paging_bloc.dart'
    as _i62;
import 'package:aniflow/feature/profile/sub_media_list/bloc/manga_list_paging_bloc.dart'
    as _i63;
import 'package:aniflow/feature/profile/sub_stats/bloc/stats_bloc.dart' as _i34;
import 'package:aniflow/feature/search/bloc/search_bloc.dart' as _i52;
import 'package:aniflow/feature/search/paging/character_search_result_paging_bloc.dart'
    as _i42;
import 'package:aniflow/feature/search/paging/media_search_result_paging_bloc.dart'
    as _i37;
import 'package:aniflow/feature/search/paging/staff_search_result_paging_bloc.dart'
    as _i41;
import 'package:aniflow/feature/search/paging/studio_search_result_paging_bloc.dart'
    as _i39;
import 'package:aniflow/feature/search/paging/user_search_result_paging_bloc.dart'
    as _i40;
import 'package:aniflow/feature/settings/bloc/settings_bloc.dart' as _i56;
import 'package:aniflow/feature/staff_page/bloc/staff_page_bloc.dart' as _i58;
import 'package:dio/dio.dart' as _i6;
import 'package:firebase_remote_config/firebase_remote_config.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;
import 'package:workmanager/workmanager.dart' as _i7;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    final dIDataBaseModule = _$DIDataBaseModule();
    final dINetworkModule = _$DINetworkModule();
    final dIWorkmanagerModule = _$DIWorkmanagerModule();
    final dIFirebaseRemoteConfigModule = _$DIFirebaseRemoteConfigModule();
    await gh.factoryAsync<_i3.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i4.NotificationBloc>(() => _i4.NotificationBloc());
    gh.lazySingleton<_i5.AniflowDatabase>(() => dIDataBaseModule.database);
    gh.lazySingleton<_i6.Dio>(() => dINetworkModule.dio);
    await gh.lazySingletonAsync<_i7.Workmanager>(
      () => dIWorkmanagerModule.workManager,
      preResolve: true,
    );
    gh.lazySingleton<_i8.MessageRepository>(() => _i8.MessageRepository());
    await gh.lazySingletonAsync<_i9.FirebaseRemoteConfig>(
      () => dIFirebaseRemoteConfigModule.remoteConfig,
      preResolve: true,
    );
    gh.factory<_i10.UserDao>(
        () => dIDataBaseModule.getUserDao(gh<_i5.AniflowDatabase>()));
    gh.factory<_i11.StudioDao>(
        () => dIDataBaseModule.getStudioDao(gh<_i5.AniflowDatabase>()));
    gh.factory<_i12.StaffDao>(
        () => dIDataBaseModule.getStaffDao(gh<_i5.AniflowDatabase>()));
    gh.factory<_i13.ActivityDao>(
        () => dIDataBaseModule.getActivityDao(gh<_i5.AniflowDatabase>()));
    gh.factory<_i14.AiringSchedulesDao>(() =>
        dIDataBaseModule.getAiringSchedulesDao(gh<_i5.AniflowDatabase>()));
    gh.factory<_i15.CharacterDao>(
        () => dIDataBaseModule.geCharacterDao(gh<_i5.AniflowDatabase>()));
    gh.factory<_i16.MediaListDao>(
        () => dIDataBaseModule.geMediaListDao(gh<_i5.AniflowDatabase>()));
    gh.factory<_i17.MediaDao>(
        () => dIDataBaseModule.geMediaDao(gh<_i5.AniflowDatabase>()));
    gh.factory<_i18.FavoriteDao>(
        () => dIDataBaseModule.geFavoriteDao(gh<_i5.AniflowDatabase>()));
    gh.factory<_i19.EpisodeDao>(
        () => dIDataBaseModule.geEpisodeDao(gh<_i5.AniflowDatabase>()));
    gh.lazySingleton<_i20.RemoteConfigManager>(
        () => _i20.RemoteConfigManager(gh<_i9.FirebaseRemoteConfig>()));
    gh.lazySingleton<_i21.AniListDataSource>(
        () => _i21.AniListDataSource(gh<_i6.Dio>()));
    gh.lazySingleton<_i22.AuthDataSource>(
        () => _i22.AuthDataSource(gh<_i6.Dio>()));
    gh.lazySingleton<_i23.UserInfoRepository>(
        () => _i23.UserInfoRepository(gh<_i10.UserDao>()));
    gh.lazySingleton<_i24.UserStatisticsRepository>(
        () => _i24.UserStatisticsRepository(
              gh<_i17.MediaDao>(),
              gh<_i21.AniListDataSource>(),
            ));
    gh.lazySingleton<_i25.HiAnimationDataSource>(
        () => _i25.HiAnimationDataSource(dio: gh<_i6.Dio>()));
    gh.factory<_i26.UserDataPreferences>(
        () => _i26.UserDataPreferences(gh<_i3.SharedPreferences>()));
    gh.lazySingleton<_i27.NotificationRepository>(
        () => _i27.NotificationRepository(
              gh<_i22.AuthDataSource>(),
              gh<_i10.UserDao>(),
              gh<_i17.MediaDao>(),
            ));
    gh.lazySingleton<_i28.UserDataRepository>(() => _i28.UserDataRepository(
          gh<_i26.UserDataPreferences>(),
          gh<_i20.RemoteConfigManager>(),
        ));
    gh.factoryParam<_i29.ProfileBloc, String?, dynamic>((
      _userId,
      _,
    ) =>
        _i29.ProfileBloc(
          _userId,
          gh<_i23.UserInfoRepository>(),
          gh<_i28.UserDataRepository>(),
        ));
    gh.factory<_i30.HiAnimationRepository>(() => _i30.HiAnimationRepository(
          gh<_i25.HiAnimationDataSource>(),
          gh<_i19.EpisodeDao>(),
        ));
    gh.factory<_i31.CharacterRepository>(() => _i31.CharacterRepository(
          gh<_i15.CharacterDao>(),
          gh<_i21.AniListDataSource>(),
        ));
    gh.factory<_i32.BirthdayCharacterPageBloc>(
        () => _i32.BirthdayCharacterPageBloc(gh<_i31.CharacterRepository>()));
    gh.factory<_i33.BirthdayCharactersBloc>(
        () => _i33.BirthdayCharactersBloc(gh<_i31.CharacterRepository>()));
    gh.factoryParam<_i34.StatsBloc, String, dynamic>((
      userId,
      _,
    ) =>
        _i34.StatsBloc(
          gh<_i24.UserStatisticsRepository>(),
          gh<_i8.MessageRepository>(),
          gh<_i28.UserDataRepository>(),
          userId,
        ));
    gh.factoryParam<_i35.NotificationPagingBloc, _i27.NotificationCategory,
        dynamic>((
      _category,
      _,
    ) =>
        _i35.NotificationPagingBloc(
          gh<_i27.NotificationRepository>(),
          _category,
        ));
    gh.lazySingleton<_i36.SearchRepository>(() => _i36.SearchRepository(
          gh<_i21.AniListDataSource>(),
          gh<_i17.MediaDao>(),
          gh<_i15.CharacterDao>(),
          gh<_i12.StaffDao>(),
          gh<_i11.StudioDao>(),
          gh<_i10.UserDao>(),
        ));
    gh.factoryParam<_i37.MediaSearchResultPagingBloc, _i38.MediaType, String>((
      _mediaType,
      _searchString,
    ) =>
        _i37.MediaSearchResultPagingBloc(
          _mediaType,
          _searchString,
          gh<_i36.SearchRepository>(),
        ));
    gh.factoryParam<_i39.StudioSearchResultPagingBloc, String, dynamic>((
      _searchString,
      _,
    ) =>
        _i39.StudioSearchResultPagingBloc(
          _searchString,
          gh<_i36.SearchRepository>(),
        ));
    gh.factoryParam<_i40.UserSearchResultPagingBloc, String, dynamic>((
      _searchString,
      _,
    ) =>
        _i40.UserSearchResultPagingBloc(
          _searchString,
          gh<_i36.SearchRepository>(),
        ));
    gh.factoryParam<_i41.StaffSearchResultPagingBloc, String, dynamic>((
      _searchString,
      _,
    ) =>
        _i41.StaffSearchResultPagingBloc(
          _searchString,
          gh<_i36.SearchRepository>(),
        ));
    gh.factoryParam<_i42.CharacterSearchResultPagingBloc, String, dynamic>((
      _searchString,
      _,
    ) =>
        _i42.CharacterSearchResultPagingBloc(
          _searchString,
          gh<_i36.SearchRepository>(),
        ));
    gh.lazySingleton<_i43.MediaInformationRepository>(
        () => _i43.MediaInformationRepository(
              gh<_i21.AniListDataSource>(),
              gh<_i15.CharacterDao>(),
              gh<_i12.StaffDao>(),
              gh<_i11.StudioDao>(),
              gh<_i14.AiringSchedulesDao>(),
              gh<_i17.MediaDao>(),
              gh<_i28.UserDataRepository>(),
            ));
    gh.lazySingleton<_i44.ActivityRepository>(() => _i44.ActivityRepository(
          gh<_i13.ActivityDao>(),
          gh<_i21.AniListDataSource>(),
          gh<_i26.UserDataPreferences>(),
        ));
    gh.lazySingleton<_i45.AuthRepository>(() => _i45.AuthRepository(
          gh<_i22.AuthDataSource>(),
          gh<_i10.UserDao>(),
          gh<_i16.MediaListDao>(),
          gh<_i26.UserDataPreferences>(),
        ));
    gh.lazySingleton<_i46.FavoriteRepository>(() => _i46.FavoriteRepository(
          gh<_i21.AniListDataSource>(),
          gh<_i10.UserDao>(),
          gh<_i17.MediaDao>(),
          gh<_i12.StaffDao>(),
          gh<_i15.CharacterDao>(),
          gh<_i16.MediaListDao>(),
          gh<_i18.FavoriteDao>(),
          gh<_i28.UserDataRepository>(),
        ));
    gh.factoryParam<_i47.ActivityStatusBloc, String, dynamic>((
      activityId,
      _,
    ) =>
        _i47.ActivityStatusBloc(
          gh<_i44.ActivityRepository>(),
          gh<_i8.MessageRepository>(),
          activityId,
        ));
    gh.factoryParam<_i48.ActivityRepliesBloc, String, dynamic>((
      activityId,
      _,
    ) =>
        _i48.ActivityRepliesBloc(
          gh<_i44.ActivityRepository>(),
          gh<_i8.MessageRepository>(),
          activityId,
        ));
    gh.lazySingleton<_i49.MediaListRepository>(() => _i49.MediaListRepository(
          gh<_i22.AuthDataSource>(),
          gh<_i21.AniListDataSource>(),
          gh<_i16.MediaListDao>(),
          gh<_i10.UserDao>(),
          gh<_i17.MediaDao>(),
          gh<_i28.UserDataRepository>(),
        ));
    gh.factoryParam<_i50.FavoriteCharacterPagingBloc, String, int>((
      userId,
      perPageCount,
    ) =>
        _i50.FavoriteCharacterPagingBloc(
          userId,
          gh<_i46.FavoriteRepository>(),
          gh<_i28.UserDataRepository>(),
          perPageCount,
        ));
    gh.factoryParam<_i51.FavoriteStaffPagingBloc, String, int>((
      userId,
      perPageCount,
    ) =>
        _i51.FavoriteStaffPagingBloc(
          userId,
          gh<_i46.FavoriteRepository>(),
          gh<_i28.UserDataRepository>(),
          perPageCount,
        ));
    gh.factory<_i52.SearchBloc>(
        () => _i52.SearchBloc(gh<_i28.UserDataRepository>()));
    gh.factory<_i53.CharacterPageBloc>(
        () => _i53.CharacterPageBloc(gh<_i28.UserDataRepository>()));
    gh.factory<_i54.EditProfileBloc>(
        () => _i54.EditProfileBloc(gh<_i45.AuthRepository>()));
    gh.factoryParam<_i55.FavoriteAnimePagingBloc, String, int>((
      userId,
      perPageCount,
    ) =>
        _i55.FavoriteAnimePagingBloc(
          userId,
          perPageCount,
          gh<_i46.FavoriteRepository>(),
        ));
    gh.factory<_i56.SettingsBloc>(() => _i56.SettingsBloc(
          gh<_i28.UserDataRepository>(),
          gh<_i45.AuthRepository>(),
          gh<_i8.MessageRepository>(),
        ));
    gh.factory<_i57.AniListTokenHeaderInterceptor>(() =>
        _i57.AniListTokenHeaderInterceptor(gh<_i28.UserDataRepository>()));
    gh.factoryParam<_i58.StaffPageBloc, String, dynamic>((
      animeId,
      _,
    ) =>
        _i58.StaffPageBloc(
          animeId,
          gh<_i43.MediaInformationRepository>(),
          gh<_i28.UserDataRepository>(),
        ));
    gh.factoryParam<_i59.UserActivityPagingBloc, String, int>((
      userId,
      perPageCount,
    ) =>
        _i59.UserActivityPagingBloc(
          userId,
          gh<_i44.ActivityRepository>(),
          gh<_i28.UserDataRepository>(),
          perPageCount,
        ));
    gh.factoryParam<_i60.CharacterPagingBloc, String, _i61.StaffLanguage>((
      animeId,
      staffLanguage,
    ) =>
        _i60.CharacterPagingBloc(
          animeId,
          staffLanguage,
          gh<_i43.MediaInformationRepository>(),
        ));
    gh.factoryParam<_i62.WatchingAnimeListPagingBloc, String, int>((
      userId,
      perPageCount,
    ) =>
        _i62.WatchingAnimeListPagingBloc(
          userId,
          gh<_i49.MediaListRepository>(),
          perPageCount,
        ));
    gh.factoryParam<_i62.DroppedAnimeListPagingBloc, String, int>((
      userId,
      perPageCount,
    ) =>
        _i62.DroppedAnimeListPagingBloc(
          userId,
          gh<_i49.MediaListRepository>(),
          perPageCount,
        ));
    gh.factoryParam<_i62.CompleteAnimeListPagingBloc, String, int>((
      userId,
      perPageCount,
    ) =>
        _i62.CompleteAnimeListPagingBloc(
          userId,
          gh<_i49.MediaListRepository>(),
          perPageCount,
        ));
    gh.factoryParam<_i63.ReadingMangaListPagingBloc, String, int>((
      userId,
      perPageCount,
    ) =>
        _i63.ReadingMangaListPagingBloc(
          userId,
          gh<_i49.MediaListRepository>(),
          perPageCount,
        ));
    gh.factoryParam<_i63.DroppedMangaListPagingBloc, String, int>((
      userId,
      perPageCount,
    ) =>
        _i63.DroppedMangaListPagingBloc(
          userId,
          gh<_i49.MediaListRepository>(),
          perPageCount,
        ));
    gh.factory<_i64.PostAnilistNotificationExecutor>(
        () => _i64.PostAnilistNotificationExecutor(
              gh<_i27.NotificationRepository>(),
              gh<_i45.AuthRepository>(),
              gh<_i28.UserDataRepository>(),
            ));
    gh.factory<_i65.TodayAiringScheduleBloc>(() =>
        _i65.TodayAiringScheduleBloc(gh<_i43.MediaInformationRepository>()));
    gh.factoryParam<_i66.VoiceActorContentsPagingBloc, String, _i67.MediaSort>((
      staffId,
      mediaSort,
    ) =>
        _i66.VoiceActorContentsPagingBloc(
          staffId,
          gh<_i43.MediaInformationRepository>(),
          mediaSort,
        ));
    gh.factory<_i68.AuthBloc>(() => _i68.AuthBloc(
          gh<_i45.AuthRepository>(),
          gh<_i8.MessageRepository>(),
        ));
    gh.lazySingleton<_i69.BackgroundTaskManager>(
        () => _i69.BackgroundTaskManager(
              gh<_i45.AuthRepository>(),
              gh<_i7.Workmanager>(),
            ));
    gh.factory<_i70.DiscoverBloc>(() => _i70.DiscoverBloc(
          gh<_i45.AuthRepository>(),
          gh<_i43.MediaInformationRepository>(),
          gh<_i49.MediaListRepository>(),
          gh<_i28.UserDataRepository>(),
          gh<_i8.MessageRepository>(),
          gh<_i31.CharacterRepository>(),
        ));
    gh.factoryParam<_i71.MediaListUpdateBloc, String, dynamic>((
      _mediaId,
      _,
    ) =>
        _i71.MediaListUpdateBloc(
          _mediaId,
          gh<_i49.MediaListRepository>(),
        ));
    gh.factoryParam<_i72.AnimePageBloc, _i73.MediaCategory, dynamic>((
      category,
      _,
    ) =>
        _i72.AnimePageBloc(
          category,
          gh<_i43.MediaInformationRepository>(),
          gh<_i49.MediaListRepository>(),
          gh<_i45.AuthRepository>(),
          gh<_i28.UserDataRepository>(),
        ));
    gh.factoryParam<_i74.DetailMediaBloc, String, dynamic>((
      mediaId,
      _,
    ) =>
        _i74.DetailMediaBloc(
          mediaId,
          gh<_i45.AuthRepository>(),
          gh<_i46.FavoriteRepository>(),
          gh<_i28.UserDataRepository>(),
          gh<_i43.MediaInformationRepository>(),
          gh<_i49.MediaListRepository>(),
          gh<_i30.HiAnimationRepository>(),
          gh<_i8.MessageRepository>(),
        ));
    gh.factoryParam<_i75.AiringScheduleOfDayBloc, DateTime, dynamic>((
      _dateTime,
      _,
    ) =>
        _i75.AiringScheduleOfDayBloc(
          _dateTime,
          gh<_i43.MediaInformationRepository>(),
          gh<_i8.MessageRepository>(),
        ));
    gh.factoryParam<_i76.DetailStudioBloc, String, dynamic>((
      studioId,
      _,
    ) =>
        _i76.DetailStudioBloc(
          studioId,
          gh<_i43.MediaInformationRepository>(),
          gh<_i46.FavoriteRepository>(),
          gh<_i28.UserDataRepository>(),
          gh<_i8.MessageRepository>(),
        ));
    gh.factoryParam<_i77.DetailCharacterBloc, String, dynamic>((
      _characterId,
      _,
    ) =>
        _i77.DetailCharacterBloc(
          _characterId,
          gh<_i43.MediaInformationRepository>(),
          gh<_i8.MessageRepository>(),
          gh<_i46.FavoriteRepository>(),
          gh<_i28.UserDataRepository>(),
        ));
    gh.factory<_i78.ActivityBloc>(
        () => _i78.ActivityBloc(gh<_i44.ActivityRepository>()));
    gh.factoryParam<_i79.MediaCategoryPreviewBloc,
        _i79.MediaCategoryPreviewParams, dynamic>((
      _params,
      _,
    ) =>
        _i79.MediaCategoryPreviewBloc(
          _params,
          gh<_i43.MediaInformationRepository>(),
          gh<_i49.MediaListRepository>(),
        ));
    gh.factory<_i80.RecentMoviesBloc>(
        () => _i80.RecentMoviesBloc(gh<_i43.MediaInformationRepository>()));
    gh.factoryParam<_i81.DetailStaffBloc, String, dynamic>((
      staffId,
      _,
    ) =>
        _i81.DetailStaffBloc(
          staffId,
          gh<_i43.MediaInformationRepository>(),
          gh<_i8.MessageRepository>(),
          gh<_i46.FavoriteRepository>(),
          gh<_i28.UserDataRepository>(),
        ));
    gh.factoryParam<_i82.NextToWatchBloc, String?, _i38.MediaType>((
      _userId,
      _mediaType,
    ) =>
        _i82.NextToWatchBloc(
          _userId,
          _mediaType,
          gh<_i49.MediaListRepository>(),
        ));
    gh.factoryParam<_i83.FavoriteMangaPagingBloc, String, int>((
      userId,
      perPageCount,
    ) =>
        _i83.FavoriteMangaPagingBloc(
          userId,
          gh<_i46.FavoriteRepository>(),
          perPageCount,
        ));
    gh.factoryParam<_i84.StudioContentsPagingBloc, String, dynamic>((
      studioId,
      _,
    ) =>
        _i84.StudioContentsPagingBloc(
          studioId,
          gh<_i43.MediaInformationRepository>(),
        ));
    gh.factory<_i85.MovieScheduleTimeLineBloc>(
        () => _i85.MovieScheduleTimeLineBloc(
              gh<_i43.MediaInformationRepository>(),
              gh<_i8.MessageRepository>(),
            ));
    gh.factoryParam<_i86.ActivityPagingBloc, _i87.ActivityScopeCategory,
        _i88.ActivityFilterType>((
      userType,
      filterType,
    ) =>
        _i86.ActivityPagingBloc(
          gh<_i44.ActivityRepository>(),
          gh<_i28.UserDataRepository>(),
          userType,
          filterType,
        ));
    gh.factory<_i89.TrackBloc>(() => _i89.TrackBloc(
          gh<_i49.MediaListRepository>(),
          gh<_i45.AuthRepository>(),
          gh<_i28.UserDataRepository>(),
          gh<_i8.MessageRepository>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i90.RegisterModule {}

class _$DIDataBaseModule extends _i91.DIDataBaseModule {}

class _$DINetworkModule extends _i57.DINetworkModule {}

class _$DIWorkmanagerModule extends _i92.DIWorkmanagerModule {}

class _$DIFirebaseRemoteConfigModule
    extends _i93.DIFirebaseRemoteConfigModule {}
