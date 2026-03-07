import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String login;
  final String firstName;
  final String lastName;
  // final String? avatarUrl;

  const UserEntity({
    required this.id,
    required this.login,
    required this.firstName,
    required this.lastName,
    // required this.avatarUrl
  });

  @override
  List<Object?> get props => [id, login, firstName, lastName];
}