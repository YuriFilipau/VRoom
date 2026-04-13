import 'package:equatable/equatable.dart';
import 'package:vroom/features/auth/domain/entities/user_achievement_entity.dart';
import 'package:vroom/features/auth/domain/entities/user_activity_entity.dart';
import 'package:vroom/features/auth/domain/entities/user_quest_entity.dart';

class UserEntity extends Equatable {
  final int id;
  final String login;
  final String firstName;
  final String lastName;
  final List<UserQuestEntity> quests;
  final List<UserAchievementEntity> achievements;
  final List<UserActivityEntity> recentActivities;
  // final String? avatarUrl;

  const UserEntity({
    required this.id,
    required this.login,
    required this.firstName,
    required this.lastName,
    required this.quests,
    required this.achievements,
    required this.recentActivities,
    // required this.avatarUrl
  });

  @override
  List<Object?> get props => [
    id,
    login,
    firstName,
    lastName,
    quests,
    achievements,
    recentActivities,
  ];
}
