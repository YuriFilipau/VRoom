import 'package:flutter/material.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/features/auth/domain/entities/user_entity.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({required this.user, super.key});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 86,
          height: 86,
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            _initials(user),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontSize: 26,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '${user.firstName} ${user.lastName}',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: 36 / 1.5,
          ),
        ),
        const SizedBox(height: 4),
        Text('@${user.login}', style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  String _initials(UserEntity user) {
    final first = user.firstName.isEmpty ? '' : user.firstName[0];
    final last = user.lastName.isEmpty ? '' : user.lastName[0];
    return (first + last).toUpperCase();
  }
}
