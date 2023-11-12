// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:aniflow/core/common/util/logger.dart';
import 'package:aniflow/core/database/dao/activity_dao.dart';
import 'package:aniflow/core/database/dao/favorite_dao.dart';
import 'package:aniflow/core/database/dao/media_dao.dart';
import 'package:aniflow/core/database/dao/media_list_dao.dart';
import 'package:aniflow/core/database/dao/user_data_dao.dart';
import 'package:sqflite/sqflite.dart';

const databaseFileName = "anime_data_base.db";

mixin Tables {
  static const String mediaTable = 'media_table';
  static const String categoryTable = 'category_table';
  static const String animeCategoryCrossRefTable =
      'anime_category_cross_ref_table';
  static const String characterTable = 'character_table';
  static const String mediaCharacterCrossRefTable =
      'media_character_cross_ref_table';
  static const String mediaStaffCrossRefTable = 'media_staff_cross_ref_table';
  static const String staffTable = 'voice_actor_table';
  static const String userDataTable = 'user_data_table';
  static const String mediaListTable = 'media_list_table';
  static const String airingSchedulesTable = 'airing_schedules_table';
  static const String mediaExternalLickTable = 'media_external_link_table';
  static const String favoriteInfoTable = 'favorite_info_table';
  static const String mediaRelationCrossRef = 'media_relation_cross_ref_table';
  static const String activityTable = 'activity_table';
  static const String activityFilterTypeCrossRef =
      'activity_filter_type_cross_ref_table';
}

const databaseVersion = 1;

class AniflowDatabase {
  static const String _tag = 'AniflowDatabase';

  static AniflowDatabase? _instance;

  factory AniflowDatabase() => _instance ??= AniflowDatabase._();

  AniflowDatabase._();

  Database? _aniflowDB;

  MediaInformationDao? _mediaInformationDaoDao;

  UserDataDao? _userDataDao;

  MediaListDao? _mediaListDao;

  FavoriteDao? _favoriteDao;

  ActivityDao? _activityDao;

  Database get aniflowDB => _aniflowDB!;

  Future<void> initDatabase(
      {required String path, int version = databaseVersion}) async {
    _aniflowDB = await openDatabase(
      path,
      version: version,
      onConfigure: (db) {
        // db.execute('PRAGMA foreign_keys = 1');
        logger.d('$_tag onConfigure');
      },
      onCreate: (Database db, int version) async {
        await _createTables(db);
        logger.d('$_tag onCreate version $version');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        switch (oldVersion) {
          case 1:
            await _onUpgradeToVersion2(db);
            continue version_2;
          version_2:
          case 2:
            await _onUpgradeToVersion3(db);
        }
      },
      onOpen: (Database db) async {
        logger.d('$_tag onOpen');
      },
    );
  }

  MediaInformationDao getMediaInformationDaoDao() =>
      _mediaInformationDaoDao ??= MediaInformationDaoImpl(this);

  UserDataDao getUserDataDao() => _userDataDao ??= UserDataDaoImpl(this);

  MediaListDao getMediaListDao() => _mediaListDao ??= MediaListDaoImpl(this);

  FavoriteDao getFavoriteDao() => _favoriteDao ??= FavoriteDaoImpl(this);

  ActivityDao getActivityDao() => _activityDao ??= ActivityDaoImpl(this);

  Future _createTables(Database db) async {
    final batch = db.batch();
    batch.execute('create table if not exists ${Tables.mediaTable} ('
        '${MediaTableColumns.id} text primary key,'
        '${MediaTableColumns.type} text,'
        '${MediaTableColumns.englishTitle} text,'
        '${MediaTableColumns.romajiTitle} text,'
        '${MediaTableColumns.nativeTitle} text,'
        '${MediaTableColumns.coverImage} text,'
        '${MediaTableColumns.coverImageColor} text,'
        '${MediaTableColumns.description} text,'
        '${MediaTableColumns.source} text,'
        '${MediaTableColumns.bannerImage} text,'
        '${MediaTableColumns.averageScore} integer,'
        '${MediaTableColumns.hashtag} text,'
        '${MediaTableColumns.trending} integer,'
        '${MediaTableColumns.favourites} integer,'
        '${MediaTableColumns.trailerId} text,'
        '${MediaTableColumns.trailerSite} text,'
        '${MediaTableColumns.trailerThumbnail} text,'
        '${MediaTableColumns.episodes} integer,'
        '${MediaTableColumns.seasonYear} integer,'
        '${MediaTableColumns.genres} text,'
        '${MediaTableColumns.season} text,'
        '${MediaTableColumns.status} text,'
        '${MediaTableColumns.timeUntilAiring} integer,'
        '${MediaTableColumns.nextAiringEpisode} integer,'
        '${MediaTableColumns.popularRanking} integer,'
        '${MediaTableColumns.ratedRanking} integer'
        ')');

    batch.execute('create table if not exists ${Tables.categoryTable} ('
        '${CategoryColumns.category} text primary key'
        ')');

    batch.execute(
        'create table if not exists ${Tables.animeCategoryCrossRefTable} ('
        '${MediaCategoryCrossRefColumns.mediaId} text,'
        '${MediaCategoryCrossRefColumns.categoryId} text,'
        '${MediaCategoryCrossRefColumns.timeStamp} integer,'
        'primary key (${MediaCategoryCrossRefColumns.mediaId}, ${MediaCategoryCrossRefColumns.categoryId}),'
        'foreign key (${MediaCategoryCrossRefColumns.mediaId}) references ${Tables.mediaTable} (${MediaTableColumns.id}),'
        'foreign key (${MediaCategoryCrossRefColumns.categoryId}) references ${Tables.categoryTable} (${CategoryColumns.category})'
        ')');

    batch.execute('create table if not exists ${Tables.userDataTable} ('
        '${UserDataTableColumns.id} text primary key,'
        '${UserDataTableColumns.name} text,'
        '${UserDataTableColumns.avatarImage} text,'
        '${UserDataTableColumns.bannerImage} text,'
        '${UserDataTableColumns.profileColor} text'
        ')');

    batch.execute('create table if not exists ${Tables.characterTable} ('
        '${CharacterColumns.id} text primary key,'
        '${CharacterColumns.voiceActorId} text,'
        '${CharacterColumns.role} text,'
        '${CharacterColumns.image} text,'
        '${CharacterColumns.nameEnglish} text,'
        '${CharacterColumns.nameNative} text,'
        'foreign key (${CharacterColumns.voiceActorId}) references ${Tables.staffTable} (${StaffColumns.id})'
        ')');

    batch.execute('create table if not exists ${Tables.staffTable} ('
        '${StaffColumns.id} text primary key,'
        '${StaffColumns.image} text,'
        '${StaffColumns.nameEnglish} text,'
        '${StaffColumns.nameNative} text)');

    batch.execute(
        'create table if not exists ${Tables.mediaCharacterCrossRefTable} ('
        '${CharacterCrossRefColumns.mediaId} text,'
        '${CharacterCrossRefColumns.characterId} text,'
        '${CharacterCrossRefColumns.timeStamp} integer,'
        'primary key (${CharacterCrossRefColumns.mediaId}, ${CharacterCrossRefColumns.characterId}),'
        'foreign key (${CharacterCrossRefColumns.mediaId}) references ${Tables.mediaTable} (${MediaTableColumns.id}),'
        'foreign key (${CharacterCrossRefColumns.characterId}) references ${Tables.characterTable} (${CharacterColumns.id})'
        ')');

    batch.execute(
        'create table if not exists ${Tables.mediaStaffCrossRefTable} ('
        '${MediaStaffCrossRefColumns.mediaId} text,'
        '${MediaStaffCrossRefColumns.staffId} text,'
        '${MediaStaffCrossRefColumns.staffRole} text,'
        '${MediaStaffCrossRefColumns.timeStamp} integer,'
        'primary key (${MediaStaffCrossRefColumns.mediaId}, ${MediaStaffCrossRefColumns.staffRole}),'
        'foreign key (${MediaStaffCrossRefColumns.mediaId}) references ${Tables.mediaTable} (${MediaTableColumns.id}),'
        'foreign key (${MediaStaffCrossRefColumns.staffId}) references ${Tables.staffTable} (${StaffColumns.id})'
        ')');

    batch.execute('create table if not exists ${Tables.mediaListTable} ('
        '${MediaListTableColumns.id} text primary key,'
        '${MediaListTableColumns.userId} text,'
        '${MediaListTableColumns.mediaId} text,'
        '${MediaListTableColumns.status} text,'
        '${MediaListTableColumns.progress} integer,'
        '${MediaListTableColumns.score} integer,'
        '${MediaListTableColumns.updatedAt} integer,'
        'foreign key (${MediaListTableColumns.mediaId}) references ${Tables.mediaTable} (${MediaTableColumns.id})'
        'foreign key (${MediaListTableColumns.userId}) references ${Tables.userDataTable} (${UserDataTableColumns.id})'
        ')');

    batch.execute(
        'create table if not exists ${Tables.airingSchedulesTable} ('
        '${AiringSchedulesColumns.id} text primary key,'
        '${AiringSchedulesColumns.mediaId} text,'
        '${AiringSchedulesColumns.airingAt} integer,'
        '${AiringSchedulesColumns.timeUntilAiring} integer,'
        '${AiringSchedulesColumns.episode} episode,'
        'foreign key (${AiringSchedulesColumns.mediaId}) references ${Tables.mediaTable} (${MediaTableColumns.id})'
        ')');

    batch.execute(
        'create table if not exists ${Tables.mediaExternalLickTable} ('
        '${MediaExternalLinkColumnValues.id} text primary key,'
        '${MediaExternalLinkColumnValues.mediaId} text,'
        '${MediaExternalLinkColumnValues.url} text,'
        '${MediaExternalLinkColumnValues.site} text,'
        '${MediaExternalLinkColumnValues.type} text,'
        '${MediaExternalLinkColumnValues.siteId} integer,'
        '${MediaExternalLinkColumnValues.color} text,'
        '${MediaExternalLinkColumnValues.icon} text,'
        'foreign key (${MediaExternalLinkColumnValues.mediaId}) references ${Tables.mediaTable} (${MediaTableColumns.id})'
        ')');

    batch.execute('create table if not exists ${Tables.favoriteInfoTable} ('
        '${FavoriteInfoTableColumn.id} integer primary key autoincrement,'
        '${FavoriteInfoTableColumn.favoriteType} text,'
        '${FavoriteInfoTableColumn.infoId} text,'
        '${FavoriteInfoTableColumn.userId} text, '
        'unique (${FavoriteInfoTableColumn.favoriteType},${FavoriteInfoTableColumn.infoId},${FavoriteInfoTableColumn.userId})'
        ')');

    batch.execute(
        'create table if not exists ${Tables.mediaRelationCrossRef} ('
        '${MediaRelationCrossRefColumnValues.ownerId} text,'
        '${MediaRelationCrossRefColumnValues.relationId} text,'
        '${MediaRelationCrossRefColumnValues.relationType} text,'
        'primary key (${MediaRelationCrossRefColumnValues.ownerId}, ${MediaRelationCrossRefColumnValues.relationId}),'
        'foreign key (${MediaRelationCrossRefColumnValues.ownerId}) references ${Tables.mediaTable} (${MediaTableColumns.id})'
        'foreign key (${MediaRelationCrossRefColumnValues.relationId}) references ${Tables.mediaTable} (${MediaTableColumns.id})'
        ')');

    batch.execute('create table if not exists ${Tables.activityTable} ('
        '${ActivityTableColumns.id} text primary key,'
        '${ActivityTableColumns.userId} text,'
        '${ActivityTableColumns.mediaId} text,'
        '${ActivityTableColumns.text} text,'
        '${ActivityTableColumns.status} text,'
        '${ActivityTableColumns.progress} text,'
        '${ActivityTableColumns.type} text,'
        '${ActivityTableColumns.replyCount} integer,'
        '${ActivityTableColumns.siteUrl} text,'
        '${ActivityTableColumns.isLocked} integer,'
        '${ActivityTableColumns.isLiked} integer,'
        '${ActivityTableColumns.likeCount} integer,'
        '${ActivityTableColumns.isPinned} integer,'
        '${ActivityTableColumns.createdAt} integer,'
        'foreign key (${ActivityTableColumns.userId}) references ${Tables.userDataTable} (${UserDataTableColumns.id})'
        'foreign key (${ActivityTableColumns.mediaId}) references ${Tables.mediaTable} (${MediaTableColumns.id})'
        ')');

    batch.execute(
        'create table if not exists ${Tables.activityFilterTypeCrossRef} ('
        '${ActivityFilterTypeCrossRefColumns.id} integer primary key autoincrement,'
        '${ActivityFilterTypeCrossRefColumns.activityId} text,'
        '${ActivityFilterTypeCrossRefColumns.category} text,'
        'unique (${ActivityFilterTypeCrossRefColumns.activityId},${ActivityFilterTypeCrossRefColumns.category})'
        'foreign key (${ActivityFilterTypeCrossRefColumns.activityId}) references ${Tables.activityTable} (${ActivityTableColumns.id})'
        ')');

    batch.execute('create table if not exists parent_table ('
        'parent_id text primary key,'
        'name text'
        ')');

    batch.execute('create table if not exists child ('
        'child_id text primary key,'
        'parent_f_key text, '
        'child_name text, '
        'foreign key (parent_f_key) references parent_table (parent_id)'
        ')');

    await batch.commit(noResult: true);
  }

  Future _onUpgradeToVersion2(Database db) async {
    logger.d('$_tag onUpgradeToVersion2');
  }

  Future _onUpgradeToVersion3(Database db) async {
    logger.d('$_tag _onUpgradeToVersion3');
  }
}
