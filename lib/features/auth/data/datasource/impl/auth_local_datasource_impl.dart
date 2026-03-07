import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vroom/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:vroom/features/auth/data/models/user_model.dart';

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userKey = 'secure_user';

  AuthLocalDatasourceImpl({
    required this.secureStorage,
    required this.sharedPreferences,
  });

  @override
  Future<void> cacheToken(String token) async {
    await secureStorage.write(key: _accessTokenKey, value: token);
  }

  @override
  Future<String?> getCachedToken() async {
    return await secureStorage.read(key: _accessTokenKey);
  }

  @override
  Future<void> cacheRefreshToken(String refreshToken) async {
    await secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  @override
  Future<String?> getCachedRefreshToken() async {
    return await secureStorage.read(key: _refreshTokenKey);
  }

  @override
  Future<void> cacheTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await secureStorage.write(key: _accessTokenKey, value: accessToken);
    await secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  @override
  Future<void> updateAccessToken(String newAccessToken) async {
    await secureStorage.write(key: _accessTokenKey, value: newAccessToken);
  }

  @override
  Future<void> cacheUser(User user) async {
    await secureStorage.write(
      key: _userKey,
      value: json.encode(user.toJson()),
    );
  }

  @override
  Future<User?> getCachedUser() async {
    final jsonString = await secureStorage.read(key: _userKey);
    if (jsonString != null) {
      return User.fromJson(json.decode(jsonString));
    }
    return null;
  }

  @override
  Future<void> clearToken() async {
    await secureStorage.delete(key: _accessTokenKey);
    await secureStorage.delete(key: _refreshTokenKey);
    await secureStorage.delete(key: _userKey);
  }

  @override
  Future<bool> hasValidSession() async {
    final accessToken = await getCachedToken();
    final refreshToken = await getCachedRefreshToken();
    final user = await getCachedUser();

    return accessToken != null && refreshToken != null && user != null;
  }
}