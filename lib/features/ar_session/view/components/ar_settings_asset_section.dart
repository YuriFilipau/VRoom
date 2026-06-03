import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_entity.dart';
import 'package:vroom/features/ar_session/view/bloc/ar_session_bloc.dart';
import 'package:vroom/features/ar_session/view/components/ar_settings_anchor_section.dart';

class ArSettingsAssetsSection extends StatelessWidget {
  const ArSettingsAssetsSection({
    required this.state,
    required this.iconBuilder,
    super.key,
  });

  final ArSessionState state;
  final IconData Function(ArAssetPreviewIcon placeholder) iconBuilder;

  @override
  Widget build(BuildContext context) {
    if (state.assets.isEmpty) {
      return const ArSettingsSection(
        title: 'Ассеты',
        child: Text('Моделей пока нет.'),
      );
    }

    return ArSettingsSection(
      title: 'Ассеты',
      child: SizedBox(
        height: 120,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: state.assets.length,
          separatorBuilder: (_, _) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            final asset = state.assets[index];
            final selected = asset.id == state.selectedAsset?.id;
            return _AssetCard(
              asset: asset,
              icon: iconBuilder(asset.previewIcon),
              selected: selected,
            );
          },
        ),
      ),
    );
  }
}

class _AssetCard extends StatelessWidget {
  const _AssetCard({
    required this.asset,
    required this.icon,
    required this.selected,
  });

  final ArAssetEntity asset;
  final IconData icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.md),
      onTap: () =>
          context.read<ArSessionBloc>().add(ArSessionAssetSelected(asset.id)),
      child: Ink(
        width: 112,
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primaryBlue.withValues(alpha: 0.14)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadii.md),
          border: Border.all(
            color: selected
                ? AppColors.primaryBlue
                : Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: _AssetPreview(asset: asset, icon: icon),
              ),
              const SizedBox(height: 8),
              Text(
                asset.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AssetPreview extends StatelessWidget {
  const _AssetPreview({required this.asset, required this.icon});

  final ArAssetEntity asset;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final previewUrl = asset.previewUrl;
    if (previewUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          previewUrl,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => Icon(icon, size: 34),
        ),
      );
    }
    return Center(child: Icon(icon, size: 34));
  }
}
