import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:anime_tracker/core/data/model/anime_title_modle.dart';
import 'package:anime_tracker/core/network/model/character_connection.dart';

part 'detail_anime_dto.freezed.dart';

part 'detail_anime_dto.g.dart';

@freezed
class DetailAnimeDto with _$DetailAnimeDto {
  factory DetailAnimeDto({
    @Default(-1) @JsonKey(name: 'id') int id,
    @JsonKey(name: 'title') AnimeTitle? title,
    @Default({}) @JsonKey(name: 'coverImage') Map<String, String?> coverImage,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'source') String? source,
    @Default('') @JsonKey(name: 'hashtag') String hashtag,
    @JsonKey(name: 'bannerImage') String? bannerImage,
    @JsonKey(name: 'averageScore') int? averageScore,
    @JsonKey(name: 'trending') int? trending,
    @JsonKey(name: 'favourites') int? favourites,
    @JsonKey(name: 'characters') CharacterConnection? characters,
  }) = _DetailAnimeDto;

  factory DetailAnimeDto.fromJson(Map<String, dynamic> json) =>
      _$$_DetailAnimeDtoFromJson(json);
}
