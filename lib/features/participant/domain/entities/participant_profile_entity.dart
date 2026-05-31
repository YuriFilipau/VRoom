import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vroom/features/auth/domain/entities/user_achievement_entity.dart';
import 'package:vroom/features/auth/domain/entities/user_activity_entity.dart';

part 'participant_profile_entity.freezed.dart';

@freezed
abstract class ParticipantProfileEntity with _$ParticipantProfileEntity {
  const factory ParticipantProfileEntity({
    required int id,
    required String login,
    required String firstName,
    required String lastName,
    required bool isStaff,
    String? school,
    String? schoolClass,
    int? schoolClassNumber,
    String? schoolClassLetter,
    String? avatarUrl,
    required List<UserAchievementEntity> achievements,
    required List<UserActivityEntity> recentActivities,
    required int joinedEventsCount,
    required int completedQuestsCount,
  }) = _ParticipantProfileEntity;
}
