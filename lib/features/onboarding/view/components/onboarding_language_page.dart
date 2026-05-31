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

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxHeight < 620;
        final headerTopPadding = isCompact
            ? AppSizes.spacing12
            : AppSizes.spacing24;
        final headerBottomPadding = isCompact
            ? AppSizes.spacing16
            : AppSizes.spacing20;
        final gridBottomPadding = isCompact
            ? AppSizes.spacing32
            : AppSizes.spacing40;

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: headerTopPadding),
              child: Column(
                children: [
                  Text(
                    copy.chooseLanguageTitle,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: headerBottomPadding),
            Expanded(
              child: LanguageOptionGrid(
                selectedLanguage: selectedLanguage,
                padding: EdgeInsets.fromLTRB(
                  2,
                  AppSizes.spacing12,
                  2,
                  gridBottomPadding,
                ),
                physics: const BouncingScrollPhysics(),
                clipBehavior: Clip.hardEdge,
                onLanguageSelected: onLanguageSelected,
              ),
            ),
          ],
        );
      },
    );
  }
}
