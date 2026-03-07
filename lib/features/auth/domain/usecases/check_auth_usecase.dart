import 'package:dartz/dartz.dart';
import 'package:vroom/core/error/failures.dart';
import 'package:vroom/core/usecases/usecase.dart';
import 'package:vroom/features/auth/domain/repository/auth_repository.dart';

class CheckAuthUseCase implements UseCase<bool, NoParams> {
  final AuthRepository repository;

  CheckAuthUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.isAuthenticated();
  }
}
