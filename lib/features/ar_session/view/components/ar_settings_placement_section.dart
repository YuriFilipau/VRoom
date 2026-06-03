import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_placement_entity.dart';
import 'package:vroom/features/ar_session/view/bloc/ar_session_bloc.dart';
import 'package:vroom/features/ar_session/view/components/ar_placement_helpers.dart';
import 'package:vroom/features/ar_session/view/components/ar_settings_anchor_section.dart';

class ArSettingsPlacementsSection extends StatelessWidget {
  const ArSettingsPlacementsSection({
    required this.state,
    required this.iconBuilder,
    super.key,
  });

  final ArSessionState state;
  final IconData Function(ArAssetPreviewIcon placeholder) iconBuilder;

  @override
  Widget build(BuildContext context) {
    if (state.placements.isEmpty) {
      return const ArSettingsSection(
        title: 'Объекты на сцене',
        child: Text('Пока нет размещённых объектов.'),
      );
    }

    return ArSettingsSection(
      title: 'Объекты на сцене',
      child: Column(
        children: state.placements
            .map((placement) {
              final asset = state.assetForPlacement(placement);
              final icon = iconBuilder(
                asset?.previewIcon ?? ArAssetPreviewIcon.cube,
              );
              return _PlacementRow(
                state: state,
                placement: placement,
                asset: asset,
                icon: icon,
              );
            })
            .toList(growable: false),
      ),
    );
  }
}

class _PlacementRow extends StatelessWidget {
  const _PlacementRow({
    required this.state,
    required this.placement,
    required this.asset,
    required this.icon,
  });

  final ArSessionState state;
  final ArAssetPlacementEntity placement;
  final ArAssetEntity? asset;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final selected = placement.id == state.selectedPlacementId;
    final canDelete = !(state.hasTest && placement.isTestAnchor);
    final scale = arPlacementScale(placement);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primaryBlue.withValues(alpha: 0.12)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadii.md),
          border: Border.all(
            color: selected
                ? AppColors.primaryBlue
                : Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 4, 8),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: () => context.read<ArSessionBloc>().add(
                    ArSessionPlacementSelected(placement.id),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        arPlacementTitle(placement, asset),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 2),
                      Text('Размер: ${scale.toStringAsFixed(1)}x'),
                    ],
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Удалить',
                onPressed: canDelete
                    ? () => context.read<ArSessionBloc>().add(
                        ArSessionPlacementRemoved(placement.id),
                      )
                    : null,
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
