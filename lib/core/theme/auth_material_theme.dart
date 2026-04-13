import 'package:flutter/material.dart';
import 'package:vroom/core/constants/app_colors.dart';

@immutable
class AuthMaterialTheme extends ThemeExtension<AuthMaterialTheme> {
  const AuthMaterialTheme({
    required this.inputFill,
    required this.border,
    required this.hintText,
    required this.iconBackground,
    required this.iconColor,
    required this.primaryText,
    required this.accent,
  });

  final Color inputFill;
  final Color border;
  final Color hintText;
  final Color iconBackground;
  final Color iconColor;
  final Color primaryText;
  final Color accent;

  factory AuthMaterialTheme.light() {
    return const AuthMaterialTheme(
      inputFill: Color(0xFFECEFF1),
      border: Color(0xFFDCE1E7),
      hintText: Color(0xFF7A8597),
      iconBackground: Color(0xFFE8EAED),
      iconColor: Color(0xFF6F7887),
      primaryText: Color(0xFF1C2433),
      accent: Color(0xFF2F9FE7),
    );
  }

  factory AuthMaterialTheme.dark() {
    return const AuthMaterialTheme(
      inputFill: Color(0xFF171C28),
      border: Color(0xFF262E3F),
      hintText: Color(0xFF8E98AB),
      iconBackground: Color(0xFF171C28),
      iconColor: Color(0xFF95A1B5),
      primaryText: AppColors.textPrimary,
      accent: Color(0xFF2F9FE7),
    );
  }

  @override
  AuthMaterialTheme copyWith({
    Color? inputFill,
    Color? border,
    Color? hintText,
    Color? iconBackground,
    Color? iconColor,
    Color? primaryText,
    Color? accent,
  }) {
    return AuthMaterialTheme(
      inputFill: inputFill ?? this.inputFill,
      border: border ?? this.border,
      hintText: hintText ?? this.hintText,
      iconBackground: iconBackground ?? this.iconBackground,
      iconColor: iconColor ?? this.iconColor,
      primaryText: primaryText ?? this.primaryText,
      accent: accent ?? this.accent,
    );
  }

  @override
  AuthMaterialTheme lerp(ThemeExtension<AuthMaterialTheme>? other, double t) {
    if (other is! AuthMaterialTheme) {
      return this;
    }

    return AuthMaterialTheme(
      inputFill: Color.lerp(inputFill, other.inputFill, t) ?? inputFill,
      border: Color.lerp(border, other.border, t) ?? border,
      hintText: Color.lerp(hintText, other.hintText, t) ?? hintText,
      iconBackground:
          Color.lerp(iconBackground, other.iconBackground, t) ?? iconBackground,
      iconColor: Color.lerp(iconColor, other.iconColor, t) ?? iconColor,
      primaryText: Color.lerp(primaryText, other.primaryText, t) ?? primaryText,
      accent: Color.lerp(accent, other.accent, t) ?? accent,
    );
  }
}
