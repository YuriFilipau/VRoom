import 'package:freezed_annotation/freezed_annotation.dart';

part 'participant_certificate_entity.freezed.dart';

@freezed
abstract class ParticipantCertificateEntity
    with _$ParticipantCertificateEntity {
  const factory ParticipantCertificateEntity({
    required int eventId,
    required bool available,
    required bool issued,
    required String requirementMode,
    required int? scoreThreshold,
    required String? certificateNumber,
    required String? issuedAt,
    required String? artifactUrl,
    required String? renderedContent,
  }) = _ParticipantCertificateEntity;
}
