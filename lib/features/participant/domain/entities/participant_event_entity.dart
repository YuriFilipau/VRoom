import 'package:freezed_annotation/freezed_annotation.dart';

part 'participant_event_entity.freezed.dart';

@freezed
abstract class ParticipantEventEntity with _$ParticipantEventEntity {
  const factory ParticipantEventEntity({
    required int id,
    required String title,
    required String description,
    required String imageUrl,
    required int progressPercent,
    required bool certificateAvailable,
    required String statusLabel,
    required int scannedQuestsCount,
    required int totalQuestsCount,
  }) = _ParticipantEventEntity;
}
