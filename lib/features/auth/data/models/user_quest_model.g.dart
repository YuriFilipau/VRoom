// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_quest_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserQuest _$UserQuestFromJson(Map<String, dynamic> json) => _UserQuest(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  imageUrl: json['image_url'] as String,
  progressPercent: (json['progress_percent'] as num).toInt(),
);

Map<String, dynamic> _$UserQuestToJson(_UserQuest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image_url': instance.imageUrl,
      'progress_percent': instance.progressPercent,
    };
