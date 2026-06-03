import 'package:vroom/features/organizer/domain/entities/organizer_event_entity.dart';
import 'package:vroom/features/organizer/domain/entities/organizer_quest_entity.dart';

abstract interface class OrganizerRepository {
  Future<List<OrganizerEventEntity>> getEvents();

  Future<List<OrganizerQuestEntity>> getQuests(int eventId);
}
