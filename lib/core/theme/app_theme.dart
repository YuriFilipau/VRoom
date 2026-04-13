import 'package:flutter/material.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/core/theme/auth_material_theme.dart';
import 'package:vroom/core/theme/dashboard_material_theme.dart';

abstract final class AppTheme {
  static ThemeData get dark => _buildTheme(isDark: true);

  static ThemeData get light => _buildTheme(isDark: false);

  static ThemeData _buildTheme({required bool isDark}) {
    final background = isDark
        ? const Color(0xFF070B14)
        : const Color(0xFFF3F5F7);
    final surface = isDark ? const Color(0xFF171C24) : const Color(0xFFECEFF1);
    final surfaceSecondary = isDark
        ? const Color(0xFF202633)
        : const Color(0xFFFFFFFF);
    final border = isDark ? const Color(0xFF2A3140) : const Color(0xFFDCE1E7);
    final textPrimary = isDark
        ? AppColors.textPrimary
        : const Color(0xFF1A2433);
    final textSecondary = isDark
        ? AppColors.textSecondary
        : const Color(0xFF6B7380);
    final textMuted = isDark ? AppColors.textMuted : const Color(0xFF9FA7B2);

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: AppColors.primaryBlue,
        onPrimary: AppColors.textPrimary,
        secondary: AppColors.primaryCyan,
        onSecondary: AppColors.textPrimary,
        error: AppColors.error,
        onError: AppColors.textPrimary,
        surface: surface,
        onSurface: textPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: textPrimary,
      ),
      textTheme: TextTheme(
        headlineMedium: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          height: 1.1,
        ),
        headlineSmall: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textPrimary,
          height: 1.45,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: textSecondary,
          height: 1.45,
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        hintStyle: TextStyle(color: textMuted),
        labelStyle: TextStyle(color: textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          borderSide: const BorderSide(
            color: AppColors.primaryBlue,
            width: 1.2,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: surfaceSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
        contentTextStyle: TextStyle(color: textPrimary),
      ),
      iconTheme: IconThemeData(color: textSecondary),
      extensions: [
        isDark ? AuthMaterialTheme.dark() : AuthMaterialTheme.light(),
        isDark ? DashboardMaterialTheme.dark() : DashboardMaterialTheme.light(),
      ],
    );
  }
}
