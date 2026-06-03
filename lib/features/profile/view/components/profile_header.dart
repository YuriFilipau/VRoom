import 'package:flutter/material.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/features/participant/domain/entities/participant_profile_entity.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({required this.user, super.key});

  final ParticipantProfileEntity user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: SizedBox(
            width: 86,
            height: 86,
            child: user.avatarUrl == null
                ? _InitialsAvatar(initials: _initials(user))
                : Image.network(
                    user.avatarUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) =>
                        _InitialsAvatar(initials: _initials(user)),
                  ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '${user.firstName} ${user.lastName}',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontSize: 36 / 1.5),
        ),
        const SizedBox(height: 4),
        Text('@${user.login}', style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  String _initials(ParticipantProfileEntity user) {
    final first = user.firstName.isEmpty ? '' : user.firstName[0];
    final last = user.lastName.isEmpty ? '' : user.lastName[0];
    return (first + last).toUpperCase();
  }
}

class _InitialsAvatar extends StatelessWidget {
  const _InitialsAvatar({required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
      child: Center(
        child: Text(
          initials,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontSize: 26,
          ),
        ),
      ),
    );
  }
}
