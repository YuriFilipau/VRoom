import 'package:flutter/material.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/core/localization/app_language.dart';
import 'package:vroom/core/theme/dashboard_material_theme.dart';

class LanguageOptionCard extends StatelessWidget {
  const LanguageOptionCard({
    required this.language,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final AppLanguage language;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dashboardTheme = Theme.of(
      context,
    ).extension<DashboardMaterialTheme>()!;
    final borderColor = isSelected
        ? AppColors.primaryCyan
        : dashboardTheme.cardBorder;
    final backgroundColor = isSelected
        ? AppColors.primaryCyan.withValues(alpha: 0.20)
        : dashboardTheme.cardBackground;

    return Semantics(
      button: true,
      selected: isSelected,
      label: language.nativeName,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadii.sm),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(AppRadii.sm),
              border: Border.all(
                color: borderColor,
                width: isSelected ? 1.5 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.primaryCyan.withValues(alpha: 0.16),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                Text(language.flag, style: const TextStyle(fontSize: 22)),
                const SizedBox(width: 10),
                Expanded(
                  child: Directionality(
                    textDirection: language.textDirection,
                    child: Text(
                      language.nativeName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                if (isSelected) ...[
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.primaryCyan,
                    size: 20,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
