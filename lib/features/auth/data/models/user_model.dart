import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vroom/features/auth/domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class User with _$User {
  const User._();

  const factory User({
    required int id,
    required String login,
    required String firstName,
    required String lastName,
    // @Default(null) String? avatarUrl,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  String get fullName => '$firstName $lastName';
  //bool get hasAvatar => avatarUrl != null && avatarUrl!.isNotEmpty;

  UserEntity toEntity() => UserEntity(
    id: id,
    login: login,
    firstName: firstName,
    lastName: lastName,
    // avatarUrl: avatarUrl,
  );
}