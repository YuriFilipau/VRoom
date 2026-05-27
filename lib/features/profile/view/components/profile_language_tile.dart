import 'package:flutter/material.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/core/localization/app_language.dart';
import 'package:vroom/core/theme/dashboard_material_theme.dart';

class ProfileLanguageTile extends StatelessWidget {
  const ProfileLanguageTile({
    required this.title,
    required this.subtitle,
    required this.language,
    required this.onTap,
    super.key,
  });

  final String title;
  final String subtitle;
  final AppLanguage language;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dashboardTheme = Theme.of(
      context,
    ).extension<DashboardMaterialTheme>()!;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.md),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: dashboardTheme.cardBackground,
            borderRadius: BorderRadius.circular(AppRadii.md),
            border: Border.all(color: dashboardTheme.cardBorder),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryCyan.withValues(alpha: 0.14),
                ),
                child: const Icon(
                  Icons.language_rounded,
                  color: AppColors.primaryCyan,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: dashboardTheme.subtitleText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(language.flag, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 92),
                child: Directionality(
                  textDirection: language.textDirection,
                  child: Text(
                    language.nativeName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.chevron_right_rounded,
                color: dashboardTheme.navIconInactive,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
