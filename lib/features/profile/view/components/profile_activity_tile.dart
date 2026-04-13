import 'package:flutter/material.dart';
import 'package:vroom/core/theme/dashboard_material_theme.dart';
import 'package:vroom/features/auth/domain/entities/user_activity_entity.dart';

class ProfileActivityTile extends StatelessWidget {
  const ProfileActivityTile({required this.item, super.key});

  final UserActivityEntity item;

  @override
  Widget build(BuildContext context) {
    final dashboardTheme = Theme.of(context).extension<DashboardMaterialTheme>()!;

    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: dashboardTheme.cardBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: dashboardTheme.cardBorder),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 2),
              Text(item.timeLabel, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
