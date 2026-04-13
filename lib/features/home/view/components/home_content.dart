import 'package:flutter/material.dart';
import 'package:vroom/core/shared/widgets/staggered_appear.dart';
import 'package:vroom/core/theme/dashboard_material_theme.dart';
import 'package:vroom/features/auth/domain/entities/user_entity.dart';
import 'package:vroom/features/home/view/components/home_header.dart';
import 'package:vroom/features/home/view/components/quest_card.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({required this.user, super.key});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final dashboardTheme = Theme.of(context).extension<DashboardMaterialTheme>()!;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StaggeredAppear(index: 0, child: HomeHeader(user: user)),
          const SizedBox(height: 18),
          StaggeredAppear(
            index: 1,
            child: Text(
              'МОИ КВЕСТЫ',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: dashboardTheme.sectionTitle,
                fontSize: 18,
                letterSpacing: 0.7,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...user.quests.asMap().entries.map((entry) {
            final index = entry.key;
            final quest = entry.value;

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: StaggeredAppear(
                index: index + 2,
                child: QuestCard(
                  title: quest.title,
                  imageUrl: quest.imageUrl,
                  progressPercent: quest.progressPercent,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
