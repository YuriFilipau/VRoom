import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vroom/core/app.dart';
import 'package:vroom/core/constants/app_sizes.dart';
import 'package:vroom/core/dependencies/get_it.dart' as di;
import 'package:vroom/core/network/backend_discovery_service.dart';
import 'package:vroom/core/network/pretty_dio_logger.dart';
import 'package:vroom/core/shared/widgets/app_gradient_button.dart';
import 'package:vroom/core/shared/widgets/app_splash_screen.dart';
import 'package:vroom/core/theme/app_theme.dart';
import 'package:vroom/features/auth/data/datasource/auth_local_datasource.dart';

class AppBootstrap extends StatefulWidget {
  const AppBootstrap({
    required this.secureStorage,
    required this.sharedPreferences,
    super.key,
  });

  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;

  @override
  State<AppBootstrap> createState() => _AppBootstrapState();
}

class _AppBootstrapState extends State<AppBootstrap> {
  late Future<void> _startupFuture;

  @override
  void initState() {
    super.initState();
    _startupFuture = _startApplication();
  }

  Future<void> _startApplication() async {
    final backendDiscoveryService = BackendDiscoveryService(
      sharedPreferences: widget.sharedPreferences,
    );
    final baseUrl = await backendDiscoveryService.resolveBaseUrl();
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(PrettyDioLogger());

    await di.init(
      dio: dio,
      baseUrl: baseUrl,
      backendDiscoveryService: backendDiscoveryService,
      secureStorage: widget.secureStorage,
      sharedPreferences: widget.sharedPreferences,
    );

    if (kDebugMode) {
      await di.locator<AuthLocalDatasource>().clearToken();
    }
  }

  void _retryStartup() {
    setState(() {
      _startupFuture = _startApplication();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _startupFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const _StartupLoadingApp();
        }

        if (snapshot.hasError) {
          return _StartupErrorApp(
            message: _messageFromError(snapshot.error),
            onRetry: _retryStartup,
          );
        }

        return const App();
      },
    );
  }

  String _messageFromError(Object? error) {
    if (error is BackendDiscoveryException) {
      return error.message;
    }
    return backendServerNotFoundMessage;
  }
}

class _StartupLoadingApp extends StatelessWidget {
  const _StartupLoadingApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VRoom',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const AppSplashScreen(),
    );
  }
}

class _StartupErrorApp extends StatelessWidget {
  const _StartupErrorApp({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VRoom',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: Builder(
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
                          Icons.wifi_off_rounded,
                          size: 56,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(height: AppSizes.spacing20),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: AppSizes.spacing24),
                        AppGradientButton(
                          label: 'Повторить',
                          onPressed: onRetry,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
