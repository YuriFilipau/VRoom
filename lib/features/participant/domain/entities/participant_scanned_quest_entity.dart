import 'package:freezed_annotation/freezed_annotation.dart';

part 'participant_scanned_quest_entity.freezed.dart';

@freezed
abstract class ParticipantScannedQuestEntity
    with _$ParticipantScannedQuestEntity {
  const factory ParticipantScannedQuestEntity({
    required int id,
    required String title,
    required int progressPercent,
    required String statusLabel,
  }) = _ParticipantScannedQuestEntity;
}
