import 'package:freezed_annotation/freezed_annotation.dart';

part 'participant_scanned_quest_entity.freezed.dart';

@freezed
abstract class ParticipantScannedQuestEntity
    with _$ParticipantScannedQuestEntity {
  const factory ParticipantScannedQuestEntity({
    required int id,
    required String title,
    required String imageUrl,
    required int progressPercent,
    required String statusLabel,
    required bool hasTest,
    required bool testCompleted,
    required bool testPassed,
    required int? score,
    required int? passingScore,
  }) = _ParticipantScannedQuestEntity;
}
