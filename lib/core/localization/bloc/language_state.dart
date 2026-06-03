part of 'language_bloc.dart';

@freezed
abstract class LanguageState with _$LanguageState {
  const LanguageState._();

  const factory LanguageState({required AppLanguage? selectedLanguage}) =
      _LanguageState;

  bool get hasSelectedLanguage => selectedLanguage != null;

  AppLanguage get effectiveLanguage =>
      selectedLanguage ?? AppLanguage.defaultLanguage;
}
