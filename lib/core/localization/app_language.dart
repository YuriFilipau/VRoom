import 'package:flutter/widgets.dart';

enum AppLanguage {
  turkish('tr', Locale('tr'), '🇹🇷', 'Türkçe'),
  english('en', Locale('en'), '🇺🇸', 'English'),
  arabic('ar', Locale('ar'), '🇸🇦', 'العربية'),
  german('de', Locale('de'), '🇩🇪', 'Deutsch'),
  spanish('es', Locale('es'), '🇪🇸', 'Español'),
  french('fr', Locale('fr'), '🇫🇷', 'Français'),
  hindi('hi', Locale('hi'), '🇮🇳', 'हिन्दी'),
  indonesian('id', Locale('id'), '🇮🇩', 'Indonesia'),
  italian('it', Locale('it'), '🇮🇹', 'Italiano'),
  japanese('ja', Locale('ja'), '🇯🇵', '日本語'),
  korean('ko', Locale('ko'), '🇰🇷', '한국어'),
  portuguese('pt', Locale('pt'), '🇧🇷', 'Português'),
  russian('ru', Locale('ru'), '🇷🇺', 'Русский'),
  chinese('zh', Locale('zh'), '🇨🇳', '中文');

  const AppLanguage(this.code, this.locale, this.flag, this.nativeName);

  static const defaultLanguage = AppLanguage.russian;

  final String code;
  final Locale locale;
  final String flag;
  final String nativeName;

  bool get isRtl => this == AppLanguage.arabic;

  TextDirection get textDirection =>
      isRtl ? TextDirection.rtl : TextDirection.ltr;

  static AppLanguage? tryFromCode(String? code) {
    for (final language in AppLanguage.values) {
      if (language.code == code) {
        return language;
      }
    }

    return null;
  }

  static AppLanguage fromCode(String? code) {
    return tryFromCode(code) ?? defaultLanguage;
  }

  static AppLanguage fromLocale(Locale locale) {
    return fromCode(locale.languageCode);
  }
}
