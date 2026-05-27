import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/localization/app_localizations.dart';
import 'package:vroom/core/localization/bloc/language_bloc.dart';
import 'package:vroom/core/shared/widgets/staggered_appear.dart';
import 'package:vroom/core/theme/dashboard_material_theme.dart';
import 'package:vroom/features/auth/view/bloc/auth_bloc.dart';
import 'package:vroom/features/language/view/components/language_picker_sheet.dart';
import 'package:vroom/features/participant/domain/entities/participant_profile_entity.dart';
import 'package:vroom/features/profile/view/components/profile_achievement_tile.dart';
import 'package:vroom/features/profile/view/components/profile_activity_tile.dart';
import 'package:vroom/features/profile/view/components/profile_header.dart';
import 'package:vroom/features/profile/view/components/profile_language_tile.dart';
import 'package:vroom/features/profile/view/components/profile_stat_card.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({required this.user, super.key});

  final ParticipantProfileEntity user;

  @override
  Widget build(BuildContext context) {
    final dashboardTheme = Theme.of(
      context,
    ).extension<DashboardMaterialTheme>()!;
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StaggeredAppear(
            index: 0,
            child: Center(child: ProfileHeader(user: user)),
          ),
          const SizedBox(height: 18),
          StaggeredAppear(
            index: 1,
            child: Row(
              children: [
                Expanded(
                  child: ProfileStatCard(
                    title: '${user.joinedEventsCount}',
                    subtitle: l10n.profileJoinedEvents,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ProfileStatCard(
                    title: '${user.completedQuestsCount}',
                    subtitle: l10n.profileScannedQuests,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          StaggeredAppear(
            index: 2,
            child: Text(
              l10n.profileAchievements.toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: dashboardTheme.sectionTitle,
                fontSize: 18,
                letterSpacing: 0.7,
              ),
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            itemCount: user.achievements.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) => StaggeredAppear(
              index: index + 3,
              child: ProfileAchievementTile(item: user.achievements[index]),
            ),
          ),
          const SizedBox(height: 22),
          StaggeredAppear(
            index: user.achievements.length + 3,
            child: Text(
              l10n.profileRecentActivities.toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: dashboardTheme.sectionTitle,
                fontSize: 18,
                letterSpacing: 0.7,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ...user.recentActivities.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: StaggeredAppear(
                index: user.achievements.length + entry.key + 4,
                child: ProfileActivityTile(item: entry.value),
              ),
            );
          }),
          const SizedBox(height: 10),
          StaggeredAppear(
            index: user.achievements.length + user.recentActivities.length + 5,
            child: BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, state) {
                return ProfileLanguageTile(
                  title: l10n.profileLanguageTitle,
                  subtitle: l10n.profileLanguageSubtitle,
                  language: state.effectiveLanguage,
                  onTap: () => showLanguagePickerSheet(context),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          StaggeredAppear(
            index: user.achievements.length + user.recentActivities.length + 6,
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: OutlinedButton.icon(
                onPressed: () =>
                    context.read<AuthBloc>().add(const AuthEvent.logout()),
                icon: const Icon(Icons.logout, color: AppColors.error),
                label: Text(
                  l10n.profileLogout,
                  style: const TextStyle(
                    color: AppColors.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF3A2530)
                        : const Color(0xFFE9C8CE),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 88),
        ],
      ),
    );
  }
}
