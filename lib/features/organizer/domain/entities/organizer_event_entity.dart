import 'package:freezed_annotation/freezed_annotation.dart';

part 'organizer_event_entity.freezed.dart';

@freezed
abstract class OrganizerEventEntity with _$OrganizerEventEntity {
  const factory OrganizerEventEntity({
    required int id,
    required String title,
    required String subtitle,
    required int questCount,
  }) = _OrganizerEventEntity;
}
