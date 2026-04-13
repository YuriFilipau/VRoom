import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vroom/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:vroom/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:vroom/features/auth/data/datasource/impl/auth_local_datasource_impl.dart';
import 'package:vroom/features/auth/data/datasource/impl/auth_remote_datasource_impl.dart';
import 'package:vroom/features/auth/data/repository/auth_repository_impl.dart';
import 'package:vroom/features/auth/domain/repository/auth_repository.dart';
import 'package:vroom/features/auth/domain/usecases/check_auth_usecase.dart';
import 'package:vroom/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:vroom/features/auth/domain/usecases/login_usecase.dart';
import 'package:vroom/features/auth/domain/usecases/logout_usecase.dart';
import 'package:vroom/features/auth/domain/usecases/register_usecase.dart';
import 'package:vroom/features/auth/view/bloc/auth_bloc.dart';
import 'package:vroom/core/theme/bloc/theme_bloc.dart';
import 'package:vroom/features/onboarding/data/datasource/impl/onboarding_local_datasource_impl.dart';
import 'package:vroom/features/onboarding/data/datasource/onboarding_local_datasource.dart';
import 'package:vroom/features/onboarding/data/repository/onboarding_repository_impl.dart';
import 'package:vroom/features/onboarding/domain/repository/onboarding_repository.dart';

final locator = GetIt.instance;

Future<void> init({
  required Dio dio,
  required String baseUrl,
  required FlutterSecureStorage secureStorage,
  required SharedPreferences sharedPreferences,
}) async {
  // Register all external dependencies
  locator.registerLazySingleton<Dio>(() => dio);
  locator.registerLazySingleton<String>(() => baseUrl, instanceName: 'baseUrl');
  locator.registerLazySingleton<FlutterSecureStorage>(() => secureStorage);
  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // datasource
  locator.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(
      dio: locator<Dio>(),
      baseUrl: locator<String>(instanceName: 'baseUrl'),
    ),
  );

  locator.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(
      secureStorage: locator<FlutterSecureStorage>(),
      sharedPreferences: locator<SharedPreferences>(),
    ),
  );

  locator.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSourceImpl(
      sharedPreferences: locator<SharedPreferences>(),
    ),
  );

  // repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDatasource: locator(),
      localDatasource: locator(),
    ),
  );

  locator.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(localDataSource: locator()),
  );

  // use cases
  locator.registerLazySingleton(() => LoginUseCase(repository: locator()));
  locator.registerLazySingleton(() => LogoutUseCase(repository: locator()));
  locator.registerLazySingleton(() => RegisterUseCase(repository: locator()));
  locator.registerLazySingleton(
    () => GetCurrentUserUseCase(repository: locator()),
  );
  locator.registerLazySingleton(() => CheckAuthUseCase(repository: locator()));

  // bloc
  locator.registerFactory(
    () => AuthBloc(
      loginUseCase: locator(),
      logoutUseCase: locator(),
      registerUseCase: locator(),
      getCurrentUserUseCase: locator(),
      checkAuthUseCase: locator(),
    ),
  );

  locator.registerFactory(
    () => ThemeBloc(sharedPreferences: locator<SharedPreferences>()),
  );
}
