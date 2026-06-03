import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_sizes.dart';
import 'package:vroom/core/localization/app_localizations.dart';
import 'package:vroom/core/localization/bloc/language_bloc.dart';
import 'package:vroom/core/shared/widgets/staggered_appear.dart';
import 'package:vroom/core/theme/dashboard_material_theme.dart';
import 'package:vroom/features/auth/view/bloc/auth_bloc.dart';
import 'package:vroom/features/language/view/components/language_picker_sheet.dart';
import 'package:vroom/features/participant/domain/entities/participant_profile_entity.dart';
import 'package:vroom/features/profile/view/components/profile_achievement_tile.dart';
import 'package:vroom/features/profile/view/components/profile_activity_tile.dart';
import 'package:vroom/features/profile/view/components/profile_edit_sheet.dart';
import 'package:vroom/features/profile/view/components/profile_header.dart';
import 'package:vroom/features/profile/view/components/profile_language_tile.dart';
import 'package:vroom/features/profile/view/components/profile_password_sheet.dart';
import 'package:vroom/features/profile/view/components/profile_stat_card.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({
    required this.user,
    required this.onProfileChanged,
    super.key,
  });

  final ParticipantProfileEntity user;
  final ValueChanged<ParticipantProfileEntity> onProfileChanged;

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
            child: _ProfileActions(
              user: user,
              onProfileChanged: onProfileChanged,
            ),
          ),
          const SizedBox(height: 14),
          StaggeredAppear(
            index: 2,
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
          if (user.school != null ||
              user.schoolClass != null ||
              user.schoolClassNumber != null ||
              user.schoolClassLetter != null) ...[
            const SizedBox(height: 12),
            StaggeredAppear(index: 3, child: _ProfileStudyInfo(user: user)),
          ],
          const SizedBox(height: 22),
          StaggeredAppear(
            index: 4,
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
              index: index + 5,
              child: ProfileAchievementTile(item: user.achievements[index]),
            ),
          ),
          const SizedBox(height: 22),
          StaggeredAppear(
            index: user.achievements.length + 5,
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
                index: user.achievements.length + entry.key + 6,
                child: ProfileActivityTile(item: entry.value),
              ),
            );
          }),
          const SizedBox(height: 10),
          StaggeredAppear(
            index: user.achievements.length + user.recentActivities.length + 7,
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
            index: user.achievements.length + user.recentActivities.length + 8,
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

class _ProfileActions extends StatelessWidget {
  const _ProfileActions({required this.user, required this.onProfileChanged});

  final ParticipantProfileEntity user;
  final ValueChanged<ParticipantProfileEntity> onProfileChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      children: [
        Expanded(
          child: _ProfileActionButton(
            onPressed: () async {
              final updated = await showEditProfileSheet(context, user);
              if (updated == null || !context.mounted) {
                return;
              }
              onProfileChanged(updated);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(l10n.profileUpdated)));
            },
            icon: Icons.edit_outlined,
            label: l10n.profileEditAction,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _ProfileActionButton(
            onPressed: () async {
              final updated = await showChangePasswordSheet(context);
              if (updated == null || !context.mounted) {
                return;
              }
              onProfileChanged(updated);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.profilePasswordChanged)),
              );
            },
            icon: Icons.lock_reset_outlined,
            label: l10n.profileChangePasswordAction,
          ),
        ),
      ],
    );
  }
}

class _ProfileActionButton extends StatelessWidget {
  const _ProfileActionButton({
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.inputHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.spacing12),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: AppSizes.spacing8),
              Text(
                label,
                maxLines: 1,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileStudyInfo extends StatelessWidget {
  const _ProfileStudyInfo({required this.user});

  final ParticipantProfileEntity user;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final classLabel =
        user.schoolClass ??
        [
          if (user.schoolClassNumber != null) '${user.schoolClassNumber}',
          if (user.schoolClassLetter != null) user.schoolClassLetter!,
        ].join();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            if (user.school != null)
              _ProfileInfoRow(label: l10n.profileSchool, value: user.school!),
            if (user.school != null && classLabel.isNotEmpty)
              const SizedBox(height: 8),
            if (classLabel.isNotEmpty)
              _ProfileInfoRow(label: l10n.profileClass, value: classLabel),
          ],
        ),
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        const Spacer(),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
