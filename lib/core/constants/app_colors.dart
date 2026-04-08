import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color background = Color(0xFF11151B);
  static const Color surface = Color(0xFF171C24);
  static const Color surfaceSecondary = Color(0xFF202633);
  static const Color border = Color(0xFF2A3140);
  static const Color textPrimary = Color(0xFFF4F7FB);
  static const Color textSecondary = Color(0xFF8D96A7);
  static const Color textMuted = Color(0xFF596274);
  static const Color primaryBlue = Color(0xFF3A9EEA);
  static const Color primaryCyan = Color(0xFF2ECDBF);
  static const Color dotInactive = Color(0xFF353C4B);
  static const Color success = Color(0xFF2ECDBF);
  static const Color error = Color(0xFFE35D6A);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, primaryCyan],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient illustrationGradient = LinearGradient(
    colors: [Color(0xFFEAF6FF), Color(0xFF9DD7FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
