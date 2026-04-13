import 'package:flutter/material.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/theme/dashboard_material_theme.dart';

class ProfileStatCard extends StatelessWidget {
  const ProfileStatCard({
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final dashboardTheme = Theme.of(context).extension<DashboardMaterialTheme>()!;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: dashboardTheme.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: dashboardTheme.cardBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primaryBlue,
              ),
            ),
            const SizedBox(height: 2),
            Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
