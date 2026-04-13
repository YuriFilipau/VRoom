import 'package:flutter/material.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/theme/dashboard_material_theme.dart';

class QuestCard extends StatelessWidget {
  const QuestCard({
    required this.title,
    required this.imageUrl,
    required this.progressPercent,
    super.key,
  });

  final String title;
  final String imageUrl;
  final int progressPercent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final dashboardTheme = theme.extension<DashboardMaterialTheme>()!;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: dashboardTheme.cardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: dashboardTheme.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.24 : 0.05),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: SizedBox(
              height: 150,
              width: double.infinity,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, _, __) {
                  return const DecoratedBox(
                    decoration: BoxDecoration(gradient: AppColors.primaryGradient),
                    child: Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: LinearProgressIndicator(
                          value: progressPercent / 100,
                          minHeight: 8,
                          backgroundColor: dashboardTheme.progressTrack,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primaryBlue,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '$progressPercent%',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
