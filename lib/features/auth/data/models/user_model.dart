import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vroom/features/auth/data/models/user_achievement_model.dart';
import 'package:vroom/features/auth/data/models/user_activity_model.dart';
import 'package:vroom/features/auth/data/models/user_quest_model.dart';
import 'package:vroom/features/auth/domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class User with _$User {
  const User._();

  const factory User({
    required int id,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    required String login,
    @Default([]) List<UserQuest> quests,
    @Default([]) List<UserAchievement> achievements,
    @JsonKey(name: 'recent_activities') @Default([])
    List<UserActivity> recentActivities,
    // @Default(null) String? avatarUrl,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  factory User.mock({
    int id = 1,
    String login = 'alexey_p',
    String firstName = 'Алексей',
    String lastName = 'Петров',
  }) {
    return User(
      id: id,
      login: login,
      firstName: firstName,
      lastName: lastName,
      quests: const [
        UserQuest(
          id: 101,
          title: 'Инженер-робототехник',
          imageUrl: 'https://images.unsplash.com/photo-1581092160607-ee22621dd758',
          progressPercent: 75,
        ),
        UserQuest(
          id: 102,
          title: 'Врач-исследователь',
          imageUrl: 'https://images.unsplash.com/photo-1532187863486-abf9dbad1b69',
          progressPercent: 40,
        ),
        UserQuest(
          id: 103,
          title: 'Дизайнер виртуальных миров',
          imageUrl: 'https://images.unsplash.com/photo-1550745165-9bc0b252726f',
          progressPercent: 20,
        ),
      ],
      achievements: const [
        UserAchievement(
          id: 201,
          title: 'Первый квест',
          iconKey: 'trophy',
          isUnlocked: true,
        ),
        UserAchievement(
          id: 202,
          title: 'Быстрый старт',
          iconKey: 'bolt',
          isUnlocked: true,
        ),
        UserAchievement(
          id: 203,
          title: 'Точный ответ',
          iconKey: 'target',
          isUnlocked: true,
        ),
        UserAchievement(
          id: 204,
          title: '5 квестов',
          iconKey: 'star',
          isUnlocked: false,
        ),
        UserAchievement(
          id: 205,
          title: 'Мастер AR',
          iconKey: 'medal',
          isUnlocked: false,
        ),
        UserAchievement(
          id: 206,
          title: 'Без ошибок',
          iconKey: 'shield',
          isUnlocked: false,
        ),
        UserAchievement(
          id: 207,
          title: 'Серия 3 дня',
          iconKey: 'fire',
          isUnlocked: true,
        ),
        UserAchievement(
          id: 208,
          title: 'Легенда',
          iconKey: 'diamond',
          isUnlocked: false,
        ),
      ],
      recentActivities: const [
        UserActivity(
          id: 301,
          title: 'Завершён квест «Инженер-робототехник»',
          timeLabel: '2 часа назад',
        ),
        UserActivity(
          id: 302,
          title: 'Получено достижение «Быстрый старт»',
          timeLabel: 'Вчера',
        ),
        UserActivity(
          id: 303,
          title: 'Начат квест «Врач-исследователь»',
          timeLabel: '2 дня назад',
        ),
      ],
    );
  }

  String get fullName => '$firstName $lastName';
  //bool get hasAvatar => avatarUrl != null && avatarUrl!.isNotEmpty;

  UserEntity toEntity() => UserEntity(
    id: id,
    login: login,
    firstName: firstName,
    lastName: lastName,
    quests: quests.map((quest) => quest.toEntity()).toList(growable: false),
    achievements: achievements
        .map((achievement) => achievement.toEntity())
        .toList(growable: false),
    recentActivities: recentActivities
        .map((activity) => activity.toEntity())
        .toList(growable: false),
    // avatarUrl: avatarUrl,
  );
}
