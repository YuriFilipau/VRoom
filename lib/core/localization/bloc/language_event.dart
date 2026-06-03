part of 'language_bloc.dart';

@freezed
sealed class LanguageEvent with _$LanguageEvent {
  const factory LanguageEvent.selected(AppLanguage language) = LanguageSelected;
}
