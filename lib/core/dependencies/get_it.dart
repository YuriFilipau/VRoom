import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vroom/core/localization/bloc/language_bloc.dart';
import 'package:vroom/core/network/auth_interceptor.dart';
import 'package:vroom/core/network/backend_discovery_service.dart';
import 'package:vroom/core/theme/bloc/theme_bloc.dart';
import 'package:vroom/features/ar_session/data/repository/ar_repository_impl.dart';
import 'package:vroom/features/ar_session/domain/repository/ar_repository.dart';
import 'package:vroom/features/ar_session/domain/usecases/get_ar_scene_usecase.dart';
import 'package:vroom/features/ar_session/domain/usecases/save_ar_layout_usecase.dart';
import 'package:vroom/features/ar_session/view/bloc/ar_session_bloc.dart';
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
import 'package:vroom/features/onboarding/data/datasource/impl/onboarding_local_datasource_impl.dart';
import 'package:vroom/features/onboarding/data/datasource/onboarding_local_datasource.dart';
import 'package:vroom/features/onboarding/data/repository/onboarding_repository_impl.dart';
import 'package:vroom/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:vroom/features/organizer/data/repository/organizer_repository_impl.dart';
import 'package:vroom/features/organizer/domain/repository/organizer_repository.dart';
import 'package:vroom/features/participant/data/repository/participant_repository_impl.dart';
import 'package:vroom/features/participant/domain/repository/participant_repository.dart';
import 'package:vroom/features/quest_test/data/repository/quest_test_repository_impl.dart';
import 'package:vroom/features/quest_test/domain/repository/quest_test_repository.dart';
import 'package:vroom/features/quest_test/domain/usecases/get_latest_quest_test_result_usecase.dart';
import 'package:vroom/features/quest_test/domain/usecases/get_quest_test_usecase.dart';
import 'package:vroom/features/quest_test/domain/usecases/submit_quest_test_usecase.dart';
import 'package:vroom/features/quest_test/view/bloc/quest_test_bloc.dart';
import 'package:vroom/features/qr_scanner/data/repository/qr_scanner_repository_impl.dart';
import 'package:vroom/features/qr_scanner/domain/repository/qr_scanner_repository.dart';
import 'package:vroom/features/qr_scanner/domain/usecases/process_qr_code_usecase.dart';
import 'package:vroom/features/qr_scanner/view/bloc/qr_scanner_bloc.dart';

final locator = GetIt.instance;

Future<void> init({
  required Dio dio,
  required String baseUrl,
  required BackendDiscoveryService backendDiscoveryService,
  required FlutterSecureStorage secureStorage,
  required SharedPreferences sharedPreferences,
}) async {
  if (locator.isRegistered<Dio>()) {
    return;
  }

  locator.registerLazySingleton<Dio>(() => dio);
  locator.registerLazySingleton<String>(() => baseUrl, instanceName: 'baseUrl');
  locator.registerLazySingleton<BackendDiscoveryService>(
    () => backendDiscoveryService,
  );
  locator.registerLazySingleton<FlutterSecureStorage>(() => secureStorage);
  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  locator.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(
      secureStorage: locator<FlutterSecureStorage>(),
      sharedPreferences: locator<SharedPreferences>(),
    ),
  );

  dio.interceptors.add(
    AuthInterceptor(
      dio: dio,
      authLocalDatasource: locator<AuthLocalDatasource>(),
    ),
  );

  locator.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(dio: locator<Dio>()),
  );

  locator.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSourceImpl(
      sharedPreferences: locator<SharedPreferences>(),
    ),
  );

  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDatasource: locator(),
      localDatasource: locator(),
    ),
  );
  locator.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(localDataSource: locator()),
  );
  locator.registerLazySingleton<ParticipantRepository>(
    () => ParticipantRepositoryImpl(dio: locator<Dio>()),
  );
  locator.registerLazySingleton<OrganizerRepository>(
    () => OrganizerRepositoryImpl(dio: locator<Dio>()),
  );
  locator.registerLazySingleton<QrScannerRepository>(
    () => QrScannerRepositoryImpl(dio: locator<Dio>()),
  );
  locator.registerLazySingleton<QuestTestRepository>(
    () => QuestTestRepositoryImpl(dio: locator<Dio>()),
  );
  locator.registerLazySingleton<ArRepository>(
    () => ArRepositoryImpl(
      dio: locator<Dio>(),
      sharedPreferences: locator<SharedPreferences>(),
    ),
  );

  locator.registerLazySingleton(() => LoginUseCase(repository: locator()));
  locator.registerLazySingleton(() => LogoutUseCase(repository: locator()));
  locator.registerLazySingleton(() => RegisterUseCase(repository: locator()));
  locator.registerLazySingleton(
    () => GetCurrentUserUseCase(repository: locator()),
  );
  locator.registerLazySingleton(() => CheckAuthUseCase(repository: locator()));
  locator.registerLazySingleton(
    () => ProcessQrCodeUseCase(repository: locator()),
  );
  locator.registerLazySingleton(() => GetArSceneUseCase(repository: locator()));
  locator.registerLazySingleton(
    () => SaveArLayoutUseCase(repository: locator()),
  );
  locator.registerLazySingleton(
    () => GetQuestTestUseCase(repository: locator()),
  );
  locator.registerLazySingleton(
    () => GetLatestQuestTestResultUseCase(repository: locator()),
  );
  locator.registerLazySingleton(
    () => SubmitQuestTestUseCase(repository: locator()),
  );

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
  locator.registerFactory(
    () => LanguageBloc(sharedPreferences: locator<SharedPreferences>()),
  );
  locator.registerFactory(() => QrScannerBloc(processQrCodeUseCase: locator()));
  locator.registerFactory(
    () => QuestTestBloc(
      getQuestTestUseCase: locator(),
      getLatestResultUseCase: locator(),
      submitQuestTestUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => ArSessionBloc(
      getArSceneUseCase: locator(),
      saveArLayoutUseCase: locator(),
    ),
  );
}
