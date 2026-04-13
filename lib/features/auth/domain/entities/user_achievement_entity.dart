import 'package:equatable/equatable.dart';

class UserAchievementEntity extends Equatable {
  const UserAchievementEntity({
    required this.id,
    required this.title,
    required this.iconKey,
    required this.isUnlocked,
  });

  final int id;
  final String title;
  final String iconKey;
  final bool isUnlocked;

  @override
  List<Object?> get props => [id, title, iconKey, isUnlocked];
}
