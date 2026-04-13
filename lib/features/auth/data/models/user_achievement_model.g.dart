// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_achievement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserAchievement _$UserAchievementFromJson(Map<String, dynamic> json) =>
    _UserAchievement(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      iconKey: json['icon_key'] as String,
      isUnlocked: json['is_unlocked'] as bool,
    );

Map<String, dynamic> _$UserAchievementToJson(_UserAchievement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'icon_key': instance.iconKey,
      'is_unlocked': instance.isUnlocked,
    };
