import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_entity.dart';
import 'package:vroom/features/ar_session/view/bloc/ar_session_bloc.dart';
import 'package:vroom/features/ar_session/view/components/ar_session_ui_bits.dart';

class ArBottomSheet extends StatelessWidget {
  const ArBottomSheet({
    super.key,
    required this.state,
    required this.supportsAr,
    required this.iconBuilder,
    required this.hasSceneRootAnchor,
    required this.isResolvingSceneAnchor,
    required this.isUploadingSceneAnchor,
    required this.onSave,
    required this.onResetSceneAnchor,
  });

  final ArSessionState state;
  final bool supportsAr;
  final IconData Function(ArAssetPreviewIcon placeholder) iconBuilder;
  final bool hasSceneRootAnchor;
  final bool isResolvingSceneAnchor;
  final bool isUploadingSceneAnchor;
  final VoidCallback onSave;
  final VoidCallback onResetSceneAnchor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canSave =
        state.isAdmin &&
        supportsAr &&
        hasSceneRootAnchor &&
        !isUploadingSceneAnchor &&
        state.status != ArSessionStatus.loading &&
        state.status != ArSessionStatus.saving;

    return DraggableScrollableSheet(
      initialChildSize: 0.20,
      minChildSize: 0.15,
      maxChildSize: 0.42,
      builder: (context, scrollController) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: PointerInterceptor(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xE6121A25),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                children: [
                  Center(
                    child: Container(
                      width: 42,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    hasSceneRootAnchor
                        ? state.isAdmin
                              ? 'Persistent anchor сцены готов. Теперь можно расставлять ассеты'
                              : 'Anchor сцены разрешен, можно показывать объекты'
                        : isResolvingSceneAnchor
                        ? 'Идет relocalization сцены'
                        : 'Сцена ждет корневой persistent anchor',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    hasSceneRootAnchor
                        ? state.isAdmin
                              ? 'Все объекты сохраняются как local transform относительно корневого anchor сцены, а не в мировых координатах камеры.'
                              : state.placements.isEmpty
                              ? 'Для этого события пока нет сохраненных объектов. Организатору нужно сначала расставить и сохранить сцену.'
                              : 'Объекты появятся только после успешного resolve/relocalization корневого anchor сцены.'
                        : isResolvingSceneAnchor
                        ? 'Наведите камеру на QR-зону и окружение вокруг нее. Пока resolve не завершится, объекты намеренно не показываются.'
                        : state.isAdmin
                        ? 'Сначала поставьте root anchor в точке QR-кода, затем сохраните сцену. После сохранения anchor получит persistent id.'
                        : 'У этой сцены еще нет persistent anchor или он не был разрешен.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.72),
                    ),
                  ),
                  const SizedBox(height: 14),
                  if (state.assets.isNotEmpty) _AssetPicker(this),
                  if (state.assets.isNotEmpty) const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: MetricBadge(
                          title: 'Код',
                          value: 'quest_${state.questId}',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: MetricBadge(
                          title: hasSceneRootAnchor ? 'Объекты' : 'Anchor',
                          value: hasSceneRootAnchor
                              ? '${state.placements.length}'
                              : isResolvingSceneAnchor
                              ? 'Resolve'
                              : 'Нет',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _ResetAnchorButton(
                    supportsAr: supportsAr,
                    hasSceneRootAnchor: hasSceneRootAnchor,
                    isAdmin: state.isAdmin,
                    onResetSceneAnchor: onResetSceneAnchor,
                  ),
                  if (state.isAdmin) ...[
                    const SizedBox(height: 14),
                    _SaveSceneButton(
                      canSave: canSave,
                      isSaving:
                          state.status == ArSessionStatus.saving ||
                          isUploadingSceneAnchor,
                      hasCloudAnchor:
                          state.rootAnchor?.cloudAnchorId.isNotEmpty ?? false,
                      onSave: onSave,
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

class _AssetPicker extends StatelessWidget {
  const _AssetPicker(this.sheet);

  final ArBottomSheet sheet;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: sheet.state.assets.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final asset = sheet.state.assets[index];
          final isSelected = asset.id == sheet.state.selectedAsset?.id;
          return AssetChip(
            label: asset.name,
            icon: sheet.iconBuilder(asset.previewIcon),
            isSelected: isSelected,
            onTap: sheet.state.isAdmin
                ? () => context.read<ArSessionBloc>().add(
                    ArSessionAssetSelected(asset.id),
                  )
                : null,
          );
        },
      ),
    );
  }
}

class _ResetAnchorButton extends StatelessWidget {
  const _ResetAnchorButton({
    required this.supportsAr,
    required this.hasSceneRootAnchor,
    required this.isAdmin,
    required this.onResetSceneAnchor,
  });

  final bool supportsAr;
  final bool hasSceneRootAnchor;
  final bool isAdmin;
  final VoidCallback onResetSceneAnchor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: supportsAr ? onResetSceneAnchor : null,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: BorderSide(color: Colors.white.withValues(alpha: 0.20)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.lg),
          ),
          minimumSize: const Size.fromHeight(50),
        ),
        child: Text(
          hasSceneRootAnchor
              ? 'Повторно разрешить anchor'
              : isAdmin
              ? 'Создать root anchor'
              : 'Повторить поиск anchor',
        ),
      ),
    );
  }
}

class _SaveSceneButton extends StatelessWidget {
  const _SaveSceneButton({
    required this.canSave,
    required this.isSaving,
    required this.hasCloudAnchor,
    required this.onSave,
  });

  final bool canSave;
  final bool isSaving;
  final bool hasCloudAnchor;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: canSave ? onSave : null,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          disabledBackgroundColor: AppColors.primaryBlue.withValues(
            alpha: 0.45,
          ),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.lg),
          ),
          minimumSize: const Size.fromHeight(54),
        ),
        child: isSaving
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                hasCloudAnchor
                    ? 'Сохранить сцену'
                    : 'Создать persistent anchor и сохранить',
              ),
      ),
    );
  }
}
