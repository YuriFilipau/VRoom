import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_entity.dart';
import 'package:vroom/features/ar_session/view/bloc/ar_session_bloc.dart';
import 'package:vroom/features/ar_session/view/components/ar_settings_anchor_section.dart';
import 'package:vroom/features/ar_session/view/components/ar_settings_asset_section.dart';
import 'package:vroom/features/ar_session/view/components/ar_settings_placement_section.dart';

Future<void> showArSettingsDialog({
  required BuildContext context,
  required bool supportsAr,
  required IconData Function(ArAssetPreviewIcon placeholder) iconBuilder,
  required bool hasSceneRootAnchor,
  required bool isResolvingSceneAnchor,
  required bool isUploadingSceneAnchor,
  required VoidCallback onSave,
  required VoidCallback onResetSceneAnchor,
  required VoidCallback onPlaceTestAnchor,
  required VoidCallback onPlaceFinishAnchor,
  required VoidCallback onOpenTest,
}) {
  return showDialog<void>(
    context: context,
    builder: (_) => BlocProvider.value(
      value: context.read<ArSessionBloc>(),
      child: _ArSettingsDialog(
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
    ),
  );
}

class _ArSettingsDialog extends StatelessWidget {
  const _ArSettingsDialog({
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
    return BlocBuilder<ArSessionBloc, ArSessionState>(
      builder: (context, state) {
        final canSave =
            state.isAdmin &&
            supportsAr &&
            hasSceneRootAnchor &&
            !isUploadingSceneAnchor &&
            state.status != ArSessionStatus.loading &&
            state.status != ArSessionStatus.saving;

        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 22,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520, maxHeight: 680),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _DialogHeader(state: state),
                  const SizedBox(height: 14),
                  Expanded(
                    child: ListView(
                      children: [
                        ArSettingsSceneStatus(
                          state: state,
                          hasSceneRootAnchor: hasSceneRootAnchor,
                          isResolvingSceneAnchor: isResolvingSceneAnchor,
                        ),
                        if (state.isAdmin) ...[
                          const SizedBox(height: 18),
                          ArSettingsAssetsSection(
                            state: state,
                            iconBuilder: iconBuilder,
                          ),
                          const SizedBox(height: 18),
                          ArSettingsAnchorsSection(
                            state: state,
                            supportsAr: supportsAr,
                            hasSceneRootAnchor: hasSceneRootAnchor,
                            onResetSceneAnchor: onResetSceneAnchor,
                            onPlaceTestAnchor: onPlaceTestAnchor,
                            onPlaceFinishAnchor: onPlaceFinishAnchor,
                          ),
                          const SizedBox(height: 18),
                          ArSettingsPlacementsSection(
                            state: state,
                            iconBuilder: iconBuilder,
                          ),
                        ] else if (state.hasTest) ...[
                          const SizedBox(height: 18),
                          FilledButton.icon(
                            onPressed: onOpenTest,
                            icon: const Icon(Icons.quiz_outlined),
                            label: const Text('Пройти тест'),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (state.isAdmin) ...[
                    const SizedBox(height: 14),
                    FilledButton.icon(
                      onPressed: canSave ? onSave : null,
                      icon:
                          state.status == ArSessionStatus.saving ||
                              isUploadingSceneAnchor
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.save_outlined),
                      label: Text(
                        state.rootAnchor?.cloudAnchorId.isNotEmpty ?? false
                            ? 'Сохранить сцену'
                            : 'Создать облачную точку и сохранить',
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DialogHeader extends StatelessWidget {
  const _DialogHeader({required this.state});

  final ArSessionState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.tune_rounded),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            state.isAdmin ? 'Настройки AR-сцены' : 'AR-сцена',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        IconButton(
          tooltip: 'Закрыть',
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close_rounded),
        ),
      ],
    );
  }
}
