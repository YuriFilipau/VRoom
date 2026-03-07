import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vroom/core/error/failures.dart';
import 'package:vroom/core/usecases/usecase.dart';
import 'package:vroom/features/auth/domain/entities/user_entity.dart';
import 'package:vroom/features/auth/domain/usecases/check_auth_usecase.dart';
import 'package:vroom/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:vroom/features/auth/domain/usecases/login_usecase.dart';
import 'package:vroom/features/auth/domain/usecases/register_usecase.dart';
import 'package:vroom/features/auth/domain/usecases/logout_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final CheckAuthUseCase checkAuthUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.checkAuthUseCase,
    required this.getCurrentUserUseCase,
  }) : super(const Initial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<Login>(_onLogin);
    on<Register>(_onRegister);
    on<Logout>(_onLogout);
    add(const CheckAuthStatus());
  }

  FutureOr<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(const Loading());

    final result = await getCurrentUserUseCase(NoParams());

    result.fold((failure) => emit(const Unauthenticated()), (user) {
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(const Unauthenticated());
      }
    });
  }

  FutureOr<void> _onLogin(Login event, Emitter<AuthState> emit) async {
    emit(const Loading());

    final result = await loginUseCase(
      LoginParams(login: event.login, password: event.password),
    );

    result.fold(
      (failure) => emit(Error(_mapFailureToMessage(failure))),
      (user) => emit(Authenticated(user)),
    );
  }

  FutureOr<void> _onRegister(Register event, Emitter<AuthState> emit) async {
    emit(const Loading());

    final result = await registerUseCase(
      RegisterParams(
        login: event.login,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
      ),
    );

    result.fold(
      (failure) => emit(Error(_mapFailureToMessage(failure))),
      (user) => emit(Authenticated(user)),
    );
  }

  FutureOr<void> _onLogout(Logout event, Emitter<AuthState> emit) async {
    emit(const Loading());

    final result = await logoutUseCase(NoParams());

    result.fold(
      (failure) => emit(Error(_mapFailureToMessage(failure))),
      (_) => emit(const Unauthenticated()),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.when(
      server: (message) => 'Ошибка сервера: $message',
      network: () => 'Нет подключения к интернету',
      cache: () => 'Ошибка кэша',
      unauthorized: () => 'Неверный логин или пароль',
      validation: (message, _) => message,
      emailAlreadyInUse: () => 'Логин уже используется',
      weakPassword: (message) => message,
    );
  }
}
