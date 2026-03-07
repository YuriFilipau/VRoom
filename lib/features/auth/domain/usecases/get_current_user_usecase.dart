import 'package:dartz/dartz.dart';
import 'package:vroom/core/error/failures.dart';
import 'package:vroom/core/usecases/usecase.dart';
import 'package:vroom/features/auth/domain/entities/user_entity.dart';
import 'package:vroom/features/auth/domain/repository/auth_repository.dart';

class GetCurrentUserUseCase implements UseCase<UserEntity?, NoParams> {
  final AuthRepository repository;

  GetCurrentUserUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity?>> call(params) async {
    return await repository.getCurrentUser();
  }
}
