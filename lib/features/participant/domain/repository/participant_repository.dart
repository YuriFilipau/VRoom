import 'package:dio/dio.dart';
import 'package:vroom/features/participant/domain/entities/participant_certificate_entity.dart';
import 'package:vroom/features/participant/domain/entities/participant_event_detail_entity.dart';
import 'package:vroom/features/participant/domain/entities/participant_event_entity.dart';
import 'package:vroom/features/participant/domain/entities/participant_profile_entity.dart';

abstract interface class ParticipantRepository {
  Future<ParticipantProfileEntity> getProfile();

  Future<ParticipantProfileEntity> updateProfile({
    String? firstName,
    String? lastName,
    String? school,
    String? schoolClass,
    int? schoolClassNumber,
    String? schoolClassLetter,
    MultipartFile? avatar,
  });

  Future<ParticipantProfileEntity> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<List<ParticipantEventEntity>> getMyEvents();

  Future<ParticipantEventDetailEntity> getEventDetail(int eventId);

  Future<ParticipantCertificateEntity> issueCertificate(int eventId);

  Future<ParticipantCertificateEntity> getCertificate(int eventId);

  Future<String> downloadCertificatePdf(int eventId);
}
