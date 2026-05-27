import 'package:flutter/material.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_sizes.dart';
import 'package:vroom/core/localization/app_language.dart';
import 'package:vroom/core/localization/app_localizations.dart';
import 'package:vroom/features/language/view/components/language_option_grid.dart';

class OnboardingLanguagePage extends StatelessWidget {
  const OnboardingLanguagePage({
    required this.selectedLanguage,
    required this.onLanguageSelected,
    super.key,
  });

  final AppLanguage selectedLanguage;
  final ValueChanged<AppLanguage> onLanguageSelected;

  @override
  Widget build(BuildContext context) {
    final copy = AppLocalizations.forLanguage(selectedLanguage);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: AppSizes.spacing4),
          child: Column(
            children: [
              Text(
                copy.chooseLanguageTitle,
                textAlign: TextAlign.center,
                style: textTheme.headlineSmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: AppSizes.spacing8),
              Text(
                copy.chooseLanguageSubtitle,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.spacing24),
        Expanded(
          child: LanguageOptionGrid(
            selectedLanguage: selectedLanguage,
            padding: const EdgeInsets.fromLTRB(2, 4, 2, 28),
            physics: const BouncingScrollPhysics(),
            onLanguageSelected: onLanguageSelected,
          ),
        ),
      ],
    );
  }
}
