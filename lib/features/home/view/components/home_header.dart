import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vroom/core/theme/dashboard_material_theme.dart';
import 'package:vroom/core/theme/bloc/theme_bloc.dart';
import 'package:vroom/features/auth/domain/entities/user_entity.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({required this.user, super.key});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Привет,', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 2),
              Text(
                '${user.firstName} 👋',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 34 / 1.5,
                ),
              ),
            ],
          ),
        ),
        _RoundIconButton(
          icon: isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          onTap: () => context.read<ThemeBloc>().add(
            const ThemeEvent.toggled(),
          ),
        ),
        const SizedBox(width: 8),
        const _RoundIconButton(icon: Icons.notifications_none),
      ],
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dashboardTheme = Theme.of(context).extension<DashboardMaterialTheme>()!;

    return Material(
      color: dashboardTheme.softSurface,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, color: Theme.of(context).iconTheme.color),
        ),
      ),
    );
  }
}
