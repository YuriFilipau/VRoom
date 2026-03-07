import 'package:dartz/dartz.dart';
import 'package:vroom/core/error/failures.dart';
import 'package:vroom/core/usecases/usecase.dart';
import 'package:vroom/features/auth/domain/entities/user_entity.dart';
import 'package:vroom/features/auth/domain/repository/auth_repository.dart';

class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(params) async {
    return await repository.login(
      login: params.login,
      password: params.password,
    );
  }
}

class LoginParams {
  final String login;
  final String password;

  LoginParams({required this.login, required this.password});
}
