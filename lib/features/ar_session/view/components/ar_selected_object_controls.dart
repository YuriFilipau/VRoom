import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_placement_entity.dart';
import 'package:vroom/features/ar_session/view/bloc/ar_session_bloc.dart';
import 'package:vroom/features/ar_session/view/components/ar_interaction_editor_dialog.dart';
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
    final moveStep = scale >= 2 ? 0.1 : 0.05;

    return PointerInterceptor(
      child: Material(
        color: Colors.black.withValues(alpha: 0.58),
        borderRadius: BorderRadius.circular(22),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 380),
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
                const SizedBox(height: 6),
                OutlinedButton.icon(
                  onPressed: placement.isActionAnchor
                      ? null
                      : () => showArInteractionEditorDialog(
                          context: context,
                          placement: placement,
                          asset: asset,
                        ),
                  icon: const Icon(Icons.touch_app_outlined),
                  label: const Text('Действие'),
                  style: _controlButtonStyle(),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Позиция',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const Spacer(),
                    _MoveIconButton(
                      tooltip: 'Дальше',
                      icon: Icons.keyboard_arrow_up_rounded,
                      onPressed: () => _move(context, placement, dz: -moveStep),
                    ),
                    _MoveIconButton(
                      tooltip: 'Ближе',
                      icon: Icons.keyboard_arrow_down_rounded,
                      onPressed: () => _move(context, placement, dz: moveStep),
                    ),
                    _MoveIconButton(
                      tooltip: 'Влево',
                      icon: Icons.keyboard_arrow_left_rounded,
                      onPressed: () => _move(context, placement, dx: -moveStep),
                    ),
                    _MoveIconButton(
                      tooltip: 'Вправо',
                      icon: Icons.keyboard_arrow_right_rounded,
                      onPressed: () => _move(context, placement, dx: moveStep),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            _move(context, placement, dy: moveStep),
                        icon: const Icon(Icons.arrow_upward_rounded),
                        label: const Text('Выше'),
                        style: _controlButtonStyle(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            _move(context, placement, dy: -moveStep),
                        icon: const Icon(Icons.arrow_downward_rounded),
                        label: const Text('Ниже'),
                        style: _controlButtonStyle(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
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
                        style: _controlButtonStyle().copyWith(
                          foregroundColor:
                              WidgetStateProperty.resolveWith<Color?>(
                                (states) =>
                                    states.contains(WidgetState.disabled)
                                    ? Colors.white38
                                    : Colors.white,
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

  void _move(
    BuildContext context,
    ArAssetPlacementEntity placement, {
    double dx = 0,
    double dy = 0,
    double dz = 0,
  }) {
    if (placement.localTransform.length != 16) {
      return;
    }
    final transform = Matrix4.fromList(placement.localTransform);
    final translation = transform.getTranslation();
    transform.setTranslation(
      Vector3(translation.x + dx, translation.y + dy, translation.z + dz),
    );
    context.read<ArSessionBloc>().add(
      ArSessionPlacementUpserted(
        placement.copyWith(localTransform: transform.storage.toList()),
      ),
    );
  }

  ButtonStyle _controlButtonStyle() {
    return OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      disabledForegroundColor: Colors.white38,
      side: BorderSide(color: Colors.white.withValues(alpha: 0.22)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
    );
  }
}

class _MoveIconButton extends StatelessWidget {
  const _MoveIconButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      visualDensity: VisualDensity.compact,
      onPressed: onPressed,
      icon: Icon(icon),
      color: Colors.white,
      style: IconButton.styleFrom(
        side: BorderSide(color: Colors.white.withValues(alpha: 0.18)),
      ),
    );
  }
}
