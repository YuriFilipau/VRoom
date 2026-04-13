import 'package:flutter/material.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/theme/dashboard_material_theme.dart';
import 'package:vroom/features/auth/domain/entities/user_achievement_entity.dart';

class ProfileAchievementTile extends StatelessWidget {
  const ProfileAchievementTile({required this.item, super.key});

  final UserAchievementEntity item;

  @override
  Widget build(BuildContext context) {
    final dashboardTheme = Theme.of(context).extension<DashboardMaterialTheme>()!;
    final active = item.isUnlocked;

    final iconColor = active
        ? AppColors.primaryBlue
        : dashboardTheme.achievementInactiveText;
    final bg = active
        ? dashboardTheme.achievementActiveBackground
        : dashboardTheme.achievementInactiveBackground;
    final border = active
        ? dashboardTheme.achievementActiveBorder
        : dashboardTheme.achievementInactiveBorder;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 8, 4, 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_iconForKey(item.iconKey), color: iconColor, size: 22),
            const SizedBox(height: 6),
            Text(
              item.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 12,
                height: 1.15,
                color: active
                    ? Theme.of(context).textTheme.bodyLarge?.color
                    : dashboardTheme.achievementInactiveText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconForKey(String key) {
    switch (key) {
      case 'trophy':
        return Icons.emoji_events_outlined;
      case 'bolt':
        return Icons.bolt_outlined;
      case 'target':
        return Icons.gps_fixed;
      case 'star':
        return Icons.star_outline;
      case 'medal':
        return Icons.workspace_premium_outlined;
      case 'shield':
        return Icons.shield_outlined;
      case 'fire':
        return Icons.local_fire_department_outlined;
      case 'diamond':
        return Icons.diamond_outlined;
      default:
        return Icons.check_circle_outline;
    }
  }
}
