import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.server(String message) = ServerFailure;

  const factory Failure.network() = NetworkFailure;

  const factory Failure.cache() = CacheFailure;

  const factory Failure.unauthorized() = UnauthorizedFailure;

  const factory Failure.validation(
    String message,
    Map<String, String>? fieldErrors,
  ) = ValidationFailure;

  const factory Failure.emailAlreadyInUse() = EmailAlreadyInUseFailure;

  const factory Failure.weakPassword(String message) = WeakPasswordFailure;
}
