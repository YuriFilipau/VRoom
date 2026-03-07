import 'package:dartz/dartz.dart';
import 'package:vroom/core/error/exceptions.dart';
import 'package:vroom/core/error/failures.dart';
import 'package:vroom/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:vroom/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:vroom/features/auth/domain/entities/user_entity.dart';
import 'package:vroom/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  final AuthLocalDatasource localDatasource;

  AuthRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final user = await localDatasource.getCachedUser();
      return Right(user?.toEntity());
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final token = await localDatasource.getCachedToken();
      return Right(token != null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login({
    required String login,
    required String password,
  }) async {
    try {
      final user = await remoteDatasource.login(login, password);
      await localDatasource.cacheTokens(
        accessToken: user.accessToken,
        refreshToken: user.refreshToken,
      );
      await localDatasource.cacheUser(user.user);
      return Right(user.user.toEntity());
    } on AuthException catch (e) {
      return Left(Failure.validation(e.message, null));
    } on ServerException {
      return Left(const Failure.server('Ошибка сервера'));
    } catch (e) {
      return Left(const Failure.server('Неизвестная ошибка'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDatasource.logout();
      await localDatasource.clearToken();
      return const Right(null);
    } catch (e) {
      return const Left(Failure.server('Ошибка при выходе из системы'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String login,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final user = await remoteDatasource.register(
        login: login,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
      await localDatasource.cacheTokens(
        accessToken: user.accessToken,
        refreshToken: user.refreshToken,
      );
      await localDatasource.cacheUser(user.user);
      return Right(user.user.toEntity());
    } on AuthException catch (e) {
      return Left(Failure.validation(e.message, null));
    } on ServerException {
      return Left(const Failure.server('Ошибка сервера при регистрации'));
    }
  }
}
