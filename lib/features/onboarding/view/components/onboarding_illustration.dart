import 'package:flutter/material.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/core/constants/app_sizes.dart';

class OnboardingIllustration extends StatelessWidget {
  const OnboardingIllustration({required this.icon, super.key});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.illustrationSize,
      height: AppSizes.illustrationSize,
      decoration: BoxDecoration(
        gradient: AppColors.illustrationGradient,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        boxShadow: const [
          BoxShadow(
            color: Color(0x24000000),
            blurRadius: 28,
            offset: Offset(0, 20),
          ),
        ],
      ),
      child: Stack(
        children: [
          const Positioned(
            top: 26,
            right: 22,
            child: _IllustrationBadge(
              icon: Icons.auto_awesome_rounded,
              size: 34,
            ),
          ),
          const Positioned(
            left: 26,
            bottom: 28,
            child: _IllustrationBadge(
              icon: Icons.stars_rounded,
              size: 30,
            ),
          ),
          Positioned(
            left: 24,
            top: 24,
            child: Container(
              width: 74,
              height: 74,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.28),
                borderRadius: BorderRadius.circular(AppRadii.lg),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(34),
              ),
              child: Icon(
                icon,
                size: 54,
                color: AppColors.primaryBlue,
              ),
            ),
          ),
          Positioned(
            left: 28,
            right: 28,
            bottom: 24,
            child: Container(
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.32),
                borderRadius: BorderRadius.circular(AppRadii.pill),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IllustrationBadge extends StatelessWidget {
  const _IllustrationBadge({required this.icon, required this.size});

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.iconBadgeSize,
      height: AppSizes.iconBadgeSize,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Icon(icon, size: size, color: AppColors.primaryBlue),
    );
  }
}
