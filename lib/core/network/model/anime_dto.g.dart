// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AnimeDto _$$_AnimeDtoFromJson(Map<String, dynamic> json) => _$_AnimeDto(
      id: json['id'] as int? ?? -1,
      title: json['title'] == null
          ? null
          : MediaTitle.fromJson(json['title'] as Map<String, dynamic>),
      coverImage: (json['coverImage'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String?),
          ) ??
          const {},
      description: json['description'] as String?,
      status: $enumDecodeNullable(_$MediaStatusEnumMap, json['status']),
      source: $enumDecodeNullable(_$AnimeSourceEnumMap, json['source']),
      episodes: json['episodes'] as int?,
      seasonYear: json['seasonYear'] as int?,
      season: $enumDecodeNullable(_$AnimeSeasonEnumMap, json['season']),
      hashtag: json['hashtag'] as String?,
      bannerImage: json['bannerImage'] as String?,
      averageScore: json['averageScore'] as int?,
      trending: json['trending'] as int?,
      favourites: json['favourites'] as int?,
      genres: json['genres'] as List<dynamic>? ?? const [],
      trailer: json['trailer'] == null
          ? null
          : TrailerDto.fromJson(json['trailer'] as Map<String, dynamic>),
      nextAiringEpisode: json['nextAiringEpisode'] == null
          ? null
          : AiringScheduleDto.fromJson(
              json['nextAiringEpisode'] as Map<String, dynamic>),
      rankings: (json['rankings'] as List<dynamic>?)
              ?.map((e) => e == null
                  ? null
                  : AnimeRank.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      characters: json['characters'] == null
          ? null
          : CharacterConnection.fromJson(
              json['characters'] as Map<String, dynamic>),
      staff: json['staff'] == null
          ? null
          : StaffConnection.fromJson(json['staff'] as Map<String, dynamic>),
      externalLinks: (json['externalLinks'] as List<dynamic>?)
              ?.map((e) =>
                  MediaExternalLinkDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_AnimeDtoToJson(_$_AnimeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'coverImage': instance.coverImage,
      'description': instance.description,
      'status': _$MediaStatusEnumMap[instance.status],
      'source': _$AnimeSourceEnumMap[instance.source],
      'episodes': instance.episodes,
      'seasonYear': instance.seasonYear,
      'season': _$AnimeSeasonEnumMap[instance.season],
      'hashtag': instance.hashtag,
      'bannerImage': instance.bannerImage,
      'averageScore': instance.averageScore,
      'trending': instance.trending,
      'favourites': instance.favourites,
      'genres': instance.genres,
      'trailer': instance.trailer,
      'nextAiringEpisode': instance.nextAiringEpisode,
      'rankings': instance.rankings,
      'characters': instance.characters,
      'staff': instance.staff,
      'externalLinks': instance.externalLinks,
    };

const _$MediaStatusEnumMap = {
  MediaStatus.releasing: 'RELEASING',
  MediaStatus.finished: 'FINISHED',
  MediaStatus.notYetReleased: 'NOT_YET_RELEASED',
};

const _$AnimeSourceEnumMap = {
  AnimeSource.original: 'ORIGINAL',
  AnimeSource.manga: 'MANGA',
  AnimeSource.lightNovel: 'LIGHT_NOVEL',
  AnimeSource.visualNovel: 'VISUAL_NOVEL',
  AnimeSource.videoGame: 'VIDEO_GAME',
  AnimeSource.other: 'OTHER',
};

const _$AnimeSeasonEnumMap = {
  AnimeSeason.winter: 'WINTER',
  AnimeSeason.spring: 'SPRING',
  AnimeSeason.summer: 'SUMMER',
  AnimeSeason.fall: 'FALL',
};
