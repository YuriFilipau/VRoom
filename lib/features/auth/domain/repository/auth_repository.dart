import 'package:dartz/dartz.dart';
import 'package:vroom/core/error/failures.dart';
import 'package:vroom/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String login,
    required String password,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, UserEntity?>> getCurrentUser();

  Future<Either<Failure, bool>> isAuthenticated();

  Future<Either<Failure, UserEntity>> register({
    required String login,
    required String password,
    required String firstName,
    required String lastName,
  });
}
