import 'package:flutter/material.dart';
import 'package:vroom/core/constants/app_sizes.dart';
import 'package:vroom/features/onboarding/view/components/onboarding_illustration.dart';
import 'package:vroom/features/onboarding/view/onboarding_page_data.dart';

class OnboardingPageContent extends StatelessWidget {
  const OnboardingPageContent({required this.page, super.key});

  final OnboardingPageData page;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      child: Column(
        key: ValueKey(page.title),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OnboardingIllustration(icon: page.icon),
          const SizedBox(height: AppSizes.spacing32),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.spacing12,
            ),
            child: Text(
              page.title,
              textAlign: TextAlign.center,
              style: textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: AppSizes.spacing12),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.spacing16,
            ),
            child: Text(
              page.description,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
