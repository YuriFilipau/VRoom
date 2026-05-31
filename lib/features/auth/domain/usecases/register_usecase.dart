import 'package:dartz/dartz.dart';
import 'package:vroom/core/error/failures.dart';
import 'package:vroom/core/usecases/usecase.dart';
import 'package:vroom/features/auth/domain/entities/user_entity.dart';
import 'package:vroom/features/auth/domain/repository/auth_repository.dart';

class RegisterUseCase implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(params) async {
    return await repository.register(
      login: params.login,
      password: params.password,
      firstName: params.firstName,
      lastName: params.lastName,
      school: params.school,
      schoolClass: params.schoolClass,
    );
  }
}

class RegisterParams {
  final String login;
  final String password;
  final String firstName;
  final String lastName;
  final String? school;
  final String? schoolClass;

  const RegisterParams({
    required this.login,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.school,
    this.schoolClass,
  });
}
