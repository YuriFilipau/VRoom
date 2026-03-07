import 'package:dio/dio.dart';
import 'package:vroom/core/error/exceptions.dart';
import 'package:vroom/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:vroom/features/auth/data/models/auth_response_model.dart';
import 'package:vroom/features/auth/data/models/user_model.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio dio;
  final String baseUrl;

  AuthRemoteDatasourceImpl({required this.dio, required this.baseUrl});

  @override
  Future<AuthResponse> login(String login, String password) async {
    try {
      final response = await dio.post(
        '$baseUrl/api/auth/login',
        data: {'login': login, 'password': password},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return AuthResponse(
          accessToken: data['access'],
          refreshToken: data['refresh'],
          user: User.fromJson(data['user']),
        );
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw const AuthException('Неверная пара логин/пароль');
      }
      throw ServerException();
    }
  }

  @override
  Future<AuthResponse> register({
    required String login,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final response = await dio.post(
        '$baseUrl/api/auth/register',
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'login': login,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        final data = response.data;
        return AuthResponse(
          accessToken: data['access'],
          refreshToken: data['refresh'],
          user: User.fromJson(data['user']),
        );
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw const AuthException('Невалидные данные или логин уже существует');
      }
      throw ServerException();
    }
  }

  @override
  Future<User> getCurrentUser() async {
    try {
      final response = await dio.get('$baseUrl/api/me');

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw const AuthException('Не авторизован');
      }
      throw ServerException();
    }
  }

  @override
  Future<AuthResponse> refreshToken(String refreshToken) async {
    try {
      final response = await dio.post(
        '$baseUrl/api/auth/refresh',
        data: {'refresh': refreshToken},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return AuthResponse(
          accessToken: data['access'],
          refreshToken: data['refresh'],
          user: User.fromJson(data['user']),
        );
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw const AuthException('Невалидный refresh token');
      }
      throw ServerException();
    }
  }

  @override
  Future<void> logout() async {
    return Future.value();
  }
}
