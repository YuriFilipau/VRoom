import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/app_bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final secureStorage = const FlutterSecureStorage();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    AppBootstrap(
      secureStorage: secureStorage,
      sharedPreferences: sharedPreferences,
    ),
  );
}
