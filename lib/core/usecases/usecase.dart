import 'package:dartz/dartz.dart';
import 'package:vroom/core/error/failures.dart';

abstract class UseCase<Result, Params> {
  Future<Either<Failure, Result>> call(Params params);
}

class NoParams {}
