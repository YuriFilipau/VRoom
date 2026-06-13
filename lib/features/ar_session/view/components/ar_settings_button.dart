import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_entity.dart';
import 'package:vroom/features/ar_session/view/components/ar_settings_dialog.dart';

class ArSettingsButton extends StatelessWidget {
  const ArSettingsButton({
    required this.supportsAr,
    required this.iconBuilder,
    required this.hasSceneRootAnchor,
    required this.isResolvingSceneAnchor,
    required this.isUploadingSceneAnchor,
    required this.onSave,
    required this.onResetSceneAnchor,
    required this.onPlaceTestAnchor,
    required this.onPlaceFinishAnchor,
    required this.onOpenTest,
    super.key,
  });

  final bool supportsAr;
  final IconData Function(ArAssetPreviewIcon placeholder) iconBuilder;
  final bool hasSceneRootAnchor;
  final bool isResolvingSceneAnchor;
  final bool isUploadingSceneAnchor;
  final VoidCallback onSave;
  final VoidCallback onResetSceneAnchor;
  final VoidCallback onPlaceTestAnchor;
  final VoidCallback onPlaceFinishAnchor;
  final VoidCallback onOpenTest;

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      child: Material(
        color: Colors.black.withValues(alpha: 0.52),
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: IconButton(
          tooltip: 'Настройки сцены',
          onPressed: () => showArSettingsDialog(
            context: context,
            supportsAr: supportsAr,
            iconBuilder: iconBuilder,
            hasSceneRootAnchor: hasSceneRootAnchor,
            isResolvingSceneAnchor: isResolvingSceneAnchor,
            isUploadingSceneAnchor: isUploadingSceneAnchor,
            onSave: onSave,
            onResetSceneAnchor: onResetSceneAnchor,
            onPlaceTestAnchor: onPlaceTestAnchor,
            onPlaceFinishAnchor: onPlaceFinishAnchor,
            onOpenTest: onOpenTest,
          ),
          icon: const Icon(Icons.settings_rounded, color: Colors.white),
        ),
      ),
    );
  }
}
