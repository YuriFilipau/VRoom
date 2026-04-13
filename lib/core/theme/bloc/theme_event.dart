part of 'theme_bloc.dart';

@freezed
sealed class ThemeEvent with _$ThemeEvent {
  const factory ThemeEvent.toggled() = ThemeToggled;

  const factory ThemeEvent.changed(ThemeMode themeMode) = ThemeChanged;
}
