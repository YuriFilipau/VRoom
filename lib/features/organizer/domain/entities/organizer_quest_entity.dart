import 'package:freezed_annotation/freezed_annotation.dart';

part 'organizer_quest_entity.freezed.dart';

@freezed
abstract class OrganizerQuestEntity with _$OrganizerQuestEntity {
  const factory OrganizerQuestEntity({
    required int id,
    required String title,
    required int assetCount,
    required bool hasScene,
  }) = _OrganizerQuestEntity;
}
