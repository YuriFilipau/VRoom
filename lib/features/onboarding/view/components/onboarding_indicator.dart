import 'package:flutter/material.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/core/constants/app_sizes.dart';

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({
    required this.count,
    required this.currentIndex,
    super.key,
  });

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) {
          final isActive = index == currentIndex;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: AppSizes.spacing4),
            width: isActive
                ? AppSizes.pageIndicatorActiveWidth
                : AppSizes.pageIndicatorDot,
            height: AppSizes.pageIndicatorDot,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadii.pill),
              gradient: isActive ? AppColors.primaryGradient : null,
              color: isActive ? null : AppColors.dotInactive,
            ),
          );
        },
      ),
    );
  }
}
