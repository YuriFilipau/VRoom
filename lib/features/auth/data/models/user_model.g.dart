// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: (json['id'] as num).toInt(),
  login: json['login'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  avatarUrl: json['avatarUrl'] as String? ?? null,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'login': instance.login,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'avatarUrl': instance.avatarUrl,
};
