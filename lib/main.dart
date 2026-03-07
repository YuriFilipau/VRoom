import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/app.dart';
import 'core/dependencies/get_it.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize external dependencies
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:8000',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  // Add interceptors
  dio.interceptors.add(LogInterceptor(responseBody: true));

  final secureStorage = const FlutterSecureStorage();
  final sharedPreferences = await SharedPreferences.getInstance();

  // Initialize dependency injection
  await di.init(
    dio: dio,
    baseUrl: 'http://localhost:8000',
    secureStorage: secureStorage,
    sharedPreferences: sharedPreferences,
  );
  runApp(const App());
}
