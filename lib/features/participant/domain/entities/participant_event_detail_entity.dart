import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vroom/features/participant/domain/entities/participant_certificate_entity.dart';
import 'package:vroom/features/participant/domain/entities/participant_scanned_quest_entity.dart';

part 'participant_event_detail_entity.freezed.dart';

@freezed
abstract class ParticipantEventDetailEntity
    with _$ParticipantEventDetailEntity {
  const factory ParticipantEventDetailEntity({
    required int id,
    required String title,
    required String description,
    required String imageUrl,
    required int progressPercent,
    required ParticipantCertificateEntity certificate,
    required List<ParticipantScannedQuestEntity> scannedQuests,
  }) = _ParticipantEventDetailEntity;
}
