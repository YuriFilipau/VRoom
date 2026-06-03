import 'package:flutter/material.dart';
import 'package:vroom/core/localization/app_localizations.dart';
import 'package:vroom/core/shared/widgets/staggered_appear.dart';
import 'package:vroom/core/theme/dashboard_material_theme.dart';
import 'package:vroom/features/auth/domain/entities/user_entity.dart';
import 'package:vroom/features/home/view/components/home_header.dart';
import 'package:vroom/features/home/view/components/quest_card.dart';
import 'package:vroom/features/participant/domain/entities/participant_event_entity.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    required this.user,
    required this.events,
    required this.onEventTap,
    super.key,
  });

  final UserEntity user;
  final List<ParticipantEventEntity> events;
  final ValueChanged<ParticipantEventEntity> onEventTap;

  @override
  Widget build(BuildContext context) {
    final dashboardTheme = Theme.of(
      context,
    ).extension<DashboardMaterialTheme>()!;
    final l10n = AppLocalizations.of(context);

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
              l10n.homeEventsTitle.toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: dashboardTheme.sectionTitle,
                fontSize: 18,
                letterSpacing: 0.7,
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (events.isEmpty)
            StaggeredAppear(
              index: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  l10n.homeEmptyEvents,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ...events.asMap().entries.map((entry) {
            final index = entry.key;
            final event = entry.value;

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: StaggeredAppear(
                index: index + 2,
                child: GestureDetector(
                  onTap: () => onEventTap(event),
                  child: QuestCard(
                    title: event.title,
                    imageUrl: event.imageUrl,
                    progressPercent: event.progressPercent,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
