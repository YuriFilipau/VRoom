// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserActivity _$UserActivityFromJson(Map<String, dynamic> json) =>
    _UserActivity(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      timeLabel: json['time_label'] as String,
    );

Map<String, dynamic> _$UserActivityToJson(_UserActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'time_label': instance.timeLabel,
    };
