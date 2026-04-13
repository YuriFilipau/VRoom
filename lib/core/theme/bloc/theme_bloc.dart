import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_bloc.freezed.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences,
      super(ThemeState(themeMode: _readThemeMode(sharedPreferences))) {
    on<ThemeToggled>(_onThemeToggled);
    on<ThemeChanged>(_onThemeChanged);
  }

  static const _themeModeKey = 'selected_theme_mode';

  final SharedPreferences _sharedPreferences;

  static ThemeMode _readThemeMode(SharedPreferences sharedPreferences) {
    final value = sharedPreferences.getString(_themeModeKey);

    if (value == ThemeMode.light.name) {
      return ThemeMode.light;
    }

    return ThemeMode.dark;
  }

  Future<void> _onThemeToggled(
    ThemeToggled event,
    Emitter<ThemeState> emit,
  ) async {
    final nextMode = state.themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    emit(state.copyWith(themeMode: nextMode));
    await _saveThemeMode(nextMode);
  }

  Future<void> _onThemeChanged(
    ThemeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    emit(state.copyWith(themeMode: event.themeMode));
    await _saveThemeMode(event.themeMode);
  }

  Future<void> _saveThemeMode(ThemeMode themeMode) {
    return _sharedPreferences.setString(_themeModeKey, themeMode.name);
  }
}
