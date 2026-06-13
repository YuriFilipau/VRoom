import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/features/ar_session/view/bloc/ar_session_bloc.dart';

class FinishAnchorButton extends StatelessWidget {
  const FinishAnchorButton({
    required this.hasFinishAnchor,
    required this.enabled,
    required this.onPlaceRequested,
    super.key,
  });

  final bool hasFinishAnchor;
  final bool enabled;
  final VoidCallback onPlaceRequested;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: !enabled
            ? null
            : () {
                if (hasFinishAnchor) {
                  context.read<ArSessionBloc>().add(
                    const ArSessionFinishAnchorRemoved(),
                  );
                  return;
                }
                onPlaceRequested();
              },
        icon: Icon(
          hasFinishAnchor
              ? Icons.flag_circle_outlined
              : Icons.add_location_alt_outlined,
        ),
        label: Text(
          hasFinishAnchor
              ? 'Удалить точку окончания квеста'
              : 'Добавить точку окончания квеста',
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.onSurface,
          disabledForegroundColor: colorScheme.onSurface.withValues(
            alpha: 0.35,
          ),
          side: BorderSide(
            color: colorScheme.outline.withValues(alpha: enabled ? 0.55 : 0.24),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.lg),
          ),
          minimumSize: const Size.fromHeight(50),
        ),
      ),
    );
  }
}
