import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/features/ar_session/view/bloc/ar_session_bloc.dart';
import 'package:vroom/features/ar_session/view/components/ar_placement_helpers.dart';

class ArSelectedObjectControls extends StatelessWidget {
  const ArSelectedObjectControls({required this.state, super.key});

  final ArSessionState state;

  @override
  Widget build(BuildContext context) {
    final placement = state.selectedPlacement;
    if (!state.isAdmin || placement == null) {
      return const SizedBox.shrink();
    }

    final asset = state.assetForPlacement(placement);
    final scale = arPlacementScale(placement);
    final maxScale = scale > 4 ? scale * 1.4 : 4.0;
    final canDelete = !(state.hasTest && placement.isTestAnchor);

    return PointerInterceptor(
      child: Material(
        color: Colors.black.withValues(alpha: 0.58),
        borderRadius: BorderRadius.circular(22),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Icon(Icons.open_with_rounded, color: Colors.white),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        arPlacementTitle(placement, asset),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Снять выбор',
                      onPressed: () => context.read<ArSessionBloc>().add(
                        const ArSessionPlacementSelected(null),
                      ),
                      icon: const Icon(Icons.close_rounded),
                      color: Colors.white,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Размер',
                      style: TextStyle(color: Colors.white70),
                    ),
                    Expanded(
                      child: Slider(
                        min: 0.2,
                        max: maxScale,
                        value: scale.clamp(0.2, maxScale).toDouble(),
                        activeColor: AppColors.primaryBlue,
                        onChanged: (value) => context.read<ArSessionBloc>().add(
                          ArSessionPlacementScaleChanged(
                            placementId: placement.id,
                            scale: value,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 44,
                      child: Text(
                        '${scale.toStringAsFixed(1)}x',
                        textAlign: TextAlign.end,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: canDelete
                            ? () => context.read<ArSessionBloc>().add(
                                ArSessionPlacementRemoved(placement.id),
                              )
                            : null,
                        icon: const Icon(Icons.delete_outline),
                        label: const Text('Удалить'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          disabledForegroundColor: Colors.white38,
                          side: BorderSide(
                            color: Colors.white.withValues(alpha: 0.22),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadii.lg),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
