import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vroom/features/auth/domain/entities/user_achievement_entity.dart';
import 'package:vroom/features/auth/domain/entities/user_activity_entity.dart';
import 'package:vroom/features/auth/domain/entities/user_quest_entity.dart';

part 'user_entity.freezed.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required int id,
    required String login,
    required String firstName,
    required String lastName,
    required bool isStaff,
    required List<UserQuestEntity> quests,
    required List<UserAchievementEntity> achievements,
    required List<UserActivityEntity> recentActivities,
  }) = _UserEntity;
}
