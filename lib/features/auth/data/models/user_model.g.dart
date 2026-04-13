// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: (json['id'] as num).toInt(),
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  login: json['login'] as String,
  quests:
      (json['quests'] as List<dynamic>?)
          ?.map((e) => UserQuest.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  achievements:
      (json['achievements'] as List<dynamic>?)
          ?.map((e) => UserAchievement.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  recentActivities:
      (json['recent_activities'] as List<dynamic>?)
          ?.map((e) => UserActivity.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'login': instance.login,
  'quests': instance.quests,
  'achievements': instance.achievements,
  'recent_activities': instance.recentActivities,
};
