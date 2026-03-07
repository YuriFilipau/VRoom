import 'package:vroom/features/auth/data/models/user_model.dart';

abstract class AuthLocalDatasource {
  // Access token
  Future<void> cacheToken(String token);
  Future<String?> getCachedToken();

  // Refresh token
  Future<void> cacheRefreshToken(String refreshToken);
  Future<String?> getCachedRefreshToken();

  // Both tokens
  Future<void> cacheTokens({
    required String accessToken,
    required String refreshToken,
  });

  // Update Access token
  Future<void> updateAccessToken(String newAccessToken);

  // User data
  Future<void> cacheUser(User user);
  Future<User?> getCachedUser();

  // Clear
  Future<void> clearToken();

  // Session check
  Future<bool> hasValidSession();
}