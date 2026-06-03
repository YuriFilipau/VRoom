import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_achievement_entity.freezed.dart';

@freezed
abstract class UserAchievementEntity with _$UserAchievementEntity {
  const factory UserAchievementEntity({
    required int id,
    required String title,
    required String iconKey,
    required bool isUnlocked,
  }) = _UserAchievementEntity;
}
