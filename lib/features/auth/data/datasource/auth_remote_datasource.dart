import 'package:vroom/features/auth/data/models/auth_response_model.dart';
import 'package:vroom/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<AuthResponse> login(String login, String password);

  Future<AuthResponse> register({
    required String login,
    required String password,
    required String firstName,
    required String lastName,
  });

  Future<User> getCurrentUser();

  Future<AuthResponse> refreshToken(String refreshToken);

  Future<void> logout();
}