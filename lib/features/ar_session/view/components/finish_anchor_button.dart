import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/features/ar_session/view/bloc/ar_session_bloc.dart';

class FinishAnchorButton extends StatelessWidget {
  const FinishAnchorButton({required this.hasFinishAnchor, super.key});

  final bool hasFinishAnchor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          context.read<ArSessionBloc>().add(
            hasFinishAnchor
                ? const ArSessionFinishAnchorRemoved()
                : const ArSessionFinishAnchorAdded(),
          );
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
          foregroundColor: Colors.white,
          side: BorderSide(color: Colors.white.withValues(alpha: 0.20)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.lg),
          ),
          minimumSize: const Size.fromHeight(50),
        ),
      ),
    );
  }
}
