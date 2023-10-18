import 'package:anime_tracker/core/database/dao/anime_dao.dart';
import 'package:anime_tracker/core/database/model/anime_entity.dart';
import 'package:anime_tracker/core/database/model/character_entity.dart';
import 'package:anime_tracker/core/database/model/media_external_link_entity.dart';
import 'package:anime_tracker/core/database/model/staff_entity.dart';

class CharacterAndVoiceActor {
  final CharacterEntity characterEntity;
  final StaffEntity? voiceActorEntity;

  const CharacterAndVoiceActor(
      {required this.characterEntity, required this.voiceActorEntity});
}

class StaffAndRoleEntity {
  const StaffAndRoleEntity({required this.staff, required this.role});

  final StaffEntity staff;
  final String role;

  factory StaffAndRoleEntity.fromJson(Map<String, dynamic> json) =>
      StaffAndRoleEntity(
        staff: StaffEntity.fromJson(json),
        role: json[AnimeStaffCrossRefColumns.staffRole],
      );
}

class AnimeWithDetailInfo {
  final AnimeEntity animeEntity;
  final List<CharacterAndVoiceActor> characterAndVoiceActors;
  final List<StaffAndRoleEntity> staffs;
  final List<MediaExternalLinkEntity> externalLinks;

  AnimeWithDetailInfo({
    required this.animeEntity,
    required this.characterAndVoiceActors,
    required this.staffs,
    required this.externalLinks,
  });
}
