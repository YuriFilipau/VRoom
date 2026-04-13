import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vroom/features/auth/domain/entities/user_achievement_entity.dart';

part 'user_achievement_model.freezed.dart';
part 'user_achievement_model.g.dart';

@freezed
abstract class UserAchievement with _$UserAchievement {
  const UserAchievement._();

  const factory UserAchievement({
    required int id,
    required String title,
    @JsonKey(name: 'icon_key') required String iconKey,
    @JsonKey(name: 'is_unlocked') required bool isUnlocked,
  }) = _UserAchievement;

  factory UserAchievement.fromJson(Map<String, dynamic> json) =>
      _$UserAchievementFromJson(json);

  UserAchievementEntity toEntity() => UserAchievementEntity(
    id: id,
    title: title,
    iconKey: iconKey,
    isUnlocked: isUnlocked,
  );
}
