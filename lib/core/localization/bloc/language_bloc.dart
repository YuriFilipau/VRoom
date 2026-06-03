import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vroom/core/localization/app_language.dart';

part 'language_bloc.freezed.dart';
part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences,
      super(
        LanguageState(
          selectedLanguage: _readSelectedLanguage(sharedPreferences),
        ),
      ) {
    on<LanguageSelected>(_onLanguageSelected);
  }

  static const _languageCodeKey = 'selected_language_code';

  final SharedPreferences _sharedPreferences;

  static AppLanguage? _readSelectedLanguage(
    SharedPreferences sharedPreferences,
  ) {
    return AppLanguage.tryFromCode(
      sharedPreferences.getString(_languageCodeKey),
    );
  }

  Future<void> _onLanguageSelected(
    LanguageSelected event,
    Emitter<LanguageState> emit,
  ) async {
    emit(state.copyWith(selectedLanguage: event.language));
    await _sharedPreferences.setString(_languageCodeKey, event.language.code);
  }
}
