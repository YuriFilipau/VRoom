part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.checkAuthStatus() = CheckAuthStatus;

  const factory AuthEvent.login({
    required String login,
    required String password,
  }) = Login;

  const factory AuthEvent.register({
    required String login,
    required String password,
    required String firstName,
    required String lastName,
  }) = Register;

  const factory AuthEvent.logout() = Logout;
}