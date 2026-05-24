import 'package:vroom/features/participant/domain/entities/participant_event_detail_entity.dart';
import 'package:vroom/features/participant/domain/entities/participant_event_entity.dart';
import 'package:vroom/features/participant/domain/entities/participant_profile_entity.dart';

abstract interface class ParticipantRepository {
  Future<ParticipantProfileEntity> getProfile();

  Future<List<ParticipantEventEntity>> getMyEvents();

  Future<ParticipantEventDetailEntity> getEventDetail(int eventId);
}
