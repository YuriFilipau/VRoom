import 'dart:io';

import 'package:ar_flutter_plugin_2/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin_2/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin_2/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin_2/datatypes/node_types.dart';
import 'package:ar_flutter_plugin_2/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin_2/models/ar_anchor.dart';
import 'package:ar_flutter_plugin_2/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin_2/models/ar_node.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/core/dependencies/get_it.dart' as di;
import 'package:vroom/features/ar_session/domain/entities/ar_asset_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_placement_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_session_mode.dart';
import 'package:vroom/features/ar_session/view/bloc/ar_session_bloc.dart';

class ArSessionScreen extends StatelessWidget {
  const ArSessionScreen({
    super.key,
    required this.eventCode,
    required this.mode,
  });

  final String eventCode;
  final ArSessionMode mode;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          di.locator<ArSessionBloc>()
            ..add(ArSessionLoadRequested(eventCode: eventCode, mode: mode)),
      child: _ArSessionView(mode: mode),
    );
  }
}

class _ArSessionView extends StatefulWidget {
  const _ArSessionView({required this.mode});

  final ArSessionMode mode;

  @override
  State<_ArSessionView> createState() => _ArSessionViewState();
}

class _ArSessionViewState extends State<_ArSessionView> {
  ARSessionManager? _arSessionManager;
  ARObjectManager? _arObjectManager;
  ARAnchorManager? _arAnchorManager;

  final Map<String, ARNode> _renderedNodes = {};
  ARPlaneAnchor? _sceneOriginAnchor;
  Matrix4? _sceneOriginTransform;
  bool _isPlacingNode = false;
  int _detectedPlaneCount = 0;

  bool get _supportsAr => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  bool get _isOriginCalibrated => _sceneOriginAnchor != null;

  @override
  void dispose() {
    _arSessionManager?.dispose();
    super.dispose();
  }

  Future<void> _onArViewCreated(
    ARSessionManager sessionManager,
    ARObjectManager objectManager,
    ARAnchorManager anchorManager,
    ARLocationManager locationManager,
  ) async {
    _arSessionManager = sessionManager;
    _arObjectManager = objectManager;
    _arAnchorManager = anchorManager;
    sessionManager.onPlaneDetected = (planeCount) {
      if (!mounted) {
        return;
      }
      setState(() {
        _detectedPlaneCount = planeCount;
      });
    };
    sessionManager.onPlaneOrPointTap = (_) {};
    sessionManager.onError = _onSessionError;

    await sessionManager.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      showWorldOrigin: false,
      handleTaps: true,
      handlePans: widget.mode == ArSessionMode.admin,
      handleRotation: widget.mode == ArSessionMode.admin,
    );
    await objectManager.onInitialize();

    sessionManager.onPlaneOrPointTap = _onPlaneOrPointTapped;
    objectManager.onPanEnd = _onPanEnded;
    objectManager.onRotationEnd = _onRotationEnded;
    objectManager.onNodeTap = _onNodeTapped;

    if (!mounted) {
      return;
    }

    await _syncSceneWithState(context.read<ArSessionBloc>().state);
  }

  ARHitTestResult? _extractPlaneHit(List<ARHitTestResult> results) {
    for (final result in results) {
      if (result.type == ARHitTestResultType.plane) {
        return result;
      }
    }
    return results.isEmpty ? null : results.first;
  }

  Future<Matrix4?> _resolveSceneOriginTransform() async {
    final anchor = _sceneOriginAnchor;
    if (anchor == null) {
      return null;
    }

    final resolvedTransform = await _arSessionManager?.getPose(anchor);
    if (resolvedTransform != null) {
      _sceneOriginTransform = Matrix4.copy(resolvedTransform);
      return _sceneOriginTransform;
    }

    return _sceneOriginTransform == null
        ? null
        : Matrix4.copy(_sceneOriginTransform!);
  }

  Future<Matrix4?> _buildLocalTransform(Matrix4 worldTransform) async {
    final originTransform = await _resolveSceneOriginTransform();
    if (originTransform == null) {
      return null;
    }

    final invertedOrigin = Matrix4.copy(originTransform);
    final determinant = invertedOrigin.invert();
    if (determinant == 0) {
      return null;
    }

    return invertedOrigin * worldTransform;
  }

  Future<void> _clearSceneOrigin() async {
    final currentOrigin = _sceneOriginAnchor;
    if (currentOrigin != null) {
      _arAnchorManager?.removeAnchor(currentOrigin);
    }

    _sceneOriginAnchor = null;
    _sceneOriginTransform = null;
    _renderedNodes.clear();
  }

  Future<void> _setSceneOrigin(
    Matrix4 worldTransform, {
    required bool showFeedback,
  }) async {
    if (_arAnchorManager == null) {
      return;
    }

    await _clearSceneOrigin();

    final anchor = ARPlaneAnchor(
      transformation: worldTransform,
      name: 'scene-origin-${DateTime.now().millisecondsSinceEpoch}',
    );
    final didAddOrigin = await _arAnchorManager!.addAnchor(anchor) ?? false;
    if (!didAddOrigin) {
      _showMessage('Не удалось привязать сцену к QR-точке');
      return;
    }

    _sceneOriginAnchor = anchor;
    _sceneOriginTransform = Matrix4.copy(worldTransform);

    if (!mounted) {
      return;
    }

    setState(() {});
    await _syncSceneWithState(context.read<ArSessionBloc>().state);

    if (showFeedback) {
      _showMessage(
        widget.mode == ArSessionMode.admin
            ? 'Сцена привязана к QR-коду. Теперь можно расставлять объекты.'
            : 'Сцена привязана к QR-коду. Загружаю сохраненные объекты.',
      );
    }
  }

  Future<void> _resetSceneOrigin() async {
    await _clearSceneOrigin();
    if (!mounted) {
      return;
    }

    setState(() {});
    _showMessage(
      'Наведите камеру на место, где расположен QR-код, и тапните по поверхности, чтобы привязать сцену заново.',
    );
  }

  Future<void> _onPlaneOrPointTapped(List<ARHitTestResult> results) async {
    if (_isPlacingNode ||
        _arObjectManager == null ||
        _arAnchorManager == null) {
      return;
    }

    final planeHit = _extractPlaneHit(results);
    if (planeHit == null) {
      _showMessage(
        'Плоскость не найдена. Попробуйте навести камеру на поверхность.',
      );
      return;
    }

    if (!_isOriginCalibrated) {
      await _setSceneOrigin(
        Matrix4.fromList(planeHit.worldTransform.storage),
        showFeedback: true,
      );
      return;
    }

    if (widget.mode != ArSessionMode.admin) {
      return;
    }

    final bloc = context.read<ArSessionBloc>();
    final state = bloc.state;
    final selectedAsset = state.selectedAsset;
    if (selectedAsset == null) {
      _showMessage('Сначала выберите ассет');
      return;
    }

    _isPlacingNode = true;
    final placementId =
        '${selectedAsset.id}-${DateTime.now().microsecondsSinceEpoch}';
    final localTransform = await _buildLocalTransform(
      Matrix4.fromList(planeHit.worldTransform.storage),
    );
    if (localTransform == null || _sceneOriginAnchor == null) {
      _isPlacingNode = false;
      _showMessage('Сначала привяжите сцену к QR-коду');
      return;
    }

    final node = ARNode(
      name: placementId,
      type: NodeType.webGLB,
      uri: selectedAsset.modelUri,
      transformation: localTransform,
      data: {'assetId': selectedAsset.id},
    );
    node.scale = Vector3.all(selectedAsset.scale);

    final didAddNode =
        await _arObjectManager!.addNode(
          node,
          planeAnchor: _sceneOriginAnchor!,
        ) ??
        false;
    if (!didAddNode) {
      _isPlacingNode = false;
      _showMessage('Не удалось разместить ассет');
      return;
    }

    _renderedNodes[placementId] = node;
    bloc.add(
      ArSessionPlacementUpserted(
        ArAssetPlacementEntity(
          id: placementId,
          assetId: selectedAsset.id,
          nodeName: placementId,
          transform: node.transform.storage.toList(),
          anchorName: _sceneOriginAnchor!.name,
        ),
      ),
    );

    _isPlacingNode = false;
  }

  Future<void> _onPanEnded(String nodeName, Matrix4 transform) async {
    await _updatePlacementTransform(nodeName, transform);
  }

  Future<void> _onRotationEnded(String nodeName, Matrix4 transform) async {
    await _updatePlacementTransform(nodeName, transform);
  }

  void _onNodeTapped(List<String> nodeNames) {
    if (!mounted || nodeNames.isEmpty) {
      return;
    }
    _showMessage('Выбран объект: ${nodeNames.first}');
  }

  Future<void> _updatePlacementTransform(
    String nodeName,
    Matrix4 transform,
  ) async {
    if (!mounted) {
      return;
    }

    final bloc = context.read<ArSessionBloc>();
    final placements = bloc.state.placements.where(
      (item) => item.nodeName == nodeName,
    );
    if (placements.isEmpty) {
      return;
    }

    final currentPlacement = placements.first;

    bloc.add(
      ArSessionPlacementUpserted(
        currentPlacement.copyWith(transform: transform.storage.toList()),
      ),
    );
  }

  Future<void> _syncSceneWithState(ArSessionState state) async {
    if (_arObjectManager == null ||
        _sceneOriginAnchor == null ||
        state.status == ArSessionStatus.loading) {
      return;
    }

    final assetById = {for (final asset in state.assets) asset.id: asset};
    for (final placement in state.placements) {
      if (_renderedNodes.containsKey(placement.id)) {
        continue;
      }

      final asset = assetById[placement.assetId];
      if (asset == null) {
        continue;
      }

      final node = ARNode(
        name: placement.nodeName,
        type: NodeType.webGLB,
        uri: asset.modelUri,
        transformation: Matrix4.fromList(placement.transform),
        data: {'assetId': placement.assetId},
      );

      final didAddNode =
          await _arObjectManager!.addNode(
            node,
            planeAnchor: _sceneOriginAnchor!,
          ) ??
          false;
      if (didAddNode) {
        _renderedNodes[placement.id] = node;
      }
    }
  }

  void _onSessionError(String error) {
    if (!mounted) {
      return;
    }

    _showMessage(error);
  }

  Future<void> _onSavePressed(ArSessionState state) async {
    if (!state.isAdmin) {
      return;
    }

    if (!_isOriginCalibrated) {
      _showMessage('Сначала привяжите сцену к физическому QR-коду');
      return;
    }

    context.read<ArSessionBloc>().add(const ArSessionSaveRequested());
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  IconData _assetIcon(ArAssetPreviewIcon placeholder) {
    return switch (placeholder) {
      ArAssetPreviewIcon.cube => Icons.view_in_ar_rounded,
      ArAssetPreviewIcon.globe => Icons.public_rounded,
      ArAssetPreviewIcon.rocket => Icons.rocket_launch_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocConsumer<ArSessionBloc, ArSessionState>(
      listener: (context, state) async {
        if (state.message != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message!)));
          context.read<ArSessionBloc>().add(const ArSessionSnackbarConsumed());
        }

        if (_supportsAr) {
          await _syncSceneWithState(state);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Positioned.fill(
                child: _supportsAr
                    ? ARView(
                        onARViewCreated: _onArViewCreated,
                        planeDetectionConfig:
                            PlaneDetectionConfig.horizontalAndVertical,
                        permissionPromptDescription:
                            'Разрешите доступ к камере для сканирования и AR.',
                        permissionPromptButtonText: 'Разрешить',
                        permissionPromptParentalRestriction:
                            'Доступ к камере ограничен системными настройками.',
                      )
                    : Container(
                        color: isDark
                            ? const Color(0xFF111826)
                            : const Color(0xFFE8EDF5),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              'AR доступен только на Android и iOS устройствах. '
                              'Архитектура и сценарий уже подключены, но для превью нужен реальный девайс.',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.48),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.62),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: PointerInterceptor(
                      child: _ArHeader(
                        title: state.eventTitle.isEmpty
                            ? 'AR-сцена'
                            : state.eventTitle,
                        subtitle: widget.mode == ArSessionMode.admin
                            ? 'Режим администратора'
                            : 'Просмотр сцены мероприятия',
                        planeCount: _detectedPlaneCount,
                        isOriginCalibrated: _isOriginCalibrated,
                      ),
                    ),
                  ),
                ),
              ),
              if (_supportsAr &&
                  state.status != ArSessionStatus.loading &&
                  !_isOriginCalibrated)
                Positioned(
                  left: 16,
                  right: 16,
                  top: 132,
                  child: SafeArea(
                    bottom: false,
                    child: IgnorePointer(
                      child: _OriginHintCard(mode: widget.mode),
                    ),
                  ),
                ),
              if (state.status == ArSessionStatus.loading)
                const Positioned.fill(
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
              Positioned.fill(
                child: PointerInterceptor(
                  intercepting: false,
                  child: _ArBottomSheet(
                    state: state,
                    supportsAr: _supportsAr,
                    iconBuilder: _assetIcon,
                    isOriginCalibrated: _isOriginCalibrated,
                    onSave: () => _onSavePressed(state),
                    onResetOrigin: _resetSceneOrigin,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ArHeader extends StatelessWidget {
  const _ArHeader({
    required this.title,
    required this.subtitle,
    required this.planeCount,
    required this.isOriginCalibrated,
  });

  final String title;
  final String subtitle;
  final int planeCount;
  final bool isOriginCalibrated;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _GlassIconButton(
          onTap: () => context.pop(),
          icon: Icons.arrow_back_rounded,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.72),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    isOriginCalibrated
                        ? 'QR-точка сцены привязана. Найдено плоскостей: $planeCount'
                        : planeCount > 0
                        ? 'Найдено плоскостей: $planeCount. Тапните по месту QR-кода.'
                        : 'Сканируйте поверхность и тапните по месту QR-кода',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.62),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ArBottomSheet extends StatelessWidget {
  const _ArBottomSheet({
    required this.state,
    required this.supportsAr,
    required this.iconBuilder,
    required this.isOriginCalibrated,
    required this.onSave,
    required this.onResetOrigin,
  });

  final ArSessionState state;
  final bool supportsAr;
  final IconData Function(ArAssetPreviewIcon placeholder) iconBuilder;
  final bool isOriginCalibrated;
  final VoidCallback onSave;
  final VoidCallback onResetOrigin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canSave =
        state.isAdmin &&
        supportsAr &&
        isOriginCalibrated &&
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
                    isOriginCalibrated
                        ? state.isAdmin
                              ? 'Сцена привязана к QR. Теперь можно расставлять ассеты'
                              : 'Сцена привязана к QR и готова к просмотру'
                        : 'Сначала привяжите сцену к физическому QR-коду',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    isOriginCalibrated
                        ? state.isAdmin
                              ? 'QR-код работает как единый origin сцены. Все объекты сохраняются в локальных координатах относительно этой точки.'
                              : state.placements.isEmpty
                              ? 'Для этого события пока нет сохраненных объектов. Организатору нужно сначала расставить и сохранить сцену.'
                              : 'Объекты загружаются относительно QR-origin, поэтому после повторной привязки сцена должна восстанавливаться стабильнее.'
                        : 'После входа по QR наведите камеру на место, где этот QR закреплен в реальности, и один раз тапните по поверхности.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.72),
                    ),
                  ),
                  const SizedBox(height: 14),
                  if (state.assets.isNotEmpty)
                    SizedBox(
                      height: 88,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.assets.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final asset = state.assets[index];
                          final isSelected =
                              asset.id == state.selectedAsset?.id;
                          return _AssetChip(
                            label: asset.name,
                            icon: iconBuilder(asset.previewIcon),
                            isSelected: isSelected,
                            onTap: state.isAdmin
                                ? () => context.read<ArSessionBloc>().add(
                                    ArSessionAssetSelected(asset.id),
                                  )
                                : null,
                          );
                        },
                      ),
                    ),
                  if (state.assets.isNotEmpty) const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _MetricBadge(
                          title: 'Код',
                          value: state.eventCode,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _MetricBadge(
                          title: isOriginCalibrated ? 'Объекты' : 'Origin',
                          value: isOriginCalibrated
                              ? '${state.placements.length}'
                              : 'QR',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: supportsAr ? onResetOrigin : null,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(
                          color: Colors.white.withValues(alpha: 0.20),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadii.lg),
                        ),
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: Text(
                        isOriginCalibrated
                            ? 'Привязать к QR заново'
                            : 'Жду привязки к QR',
                      ),
                    ),
                  ),
                  if (state.isAdmin) ...[
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: canSave ? onSave : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          disabledBackgroundColor: AppColors.primaryBlue
                              .withValues(alpha: 0.45),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadii.lg),
                          ),
                          minimumSize: const Size.fromHeight(54),
                        ),
                        child: state.status == ArSessionStatus.saving
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Сохранить сцену'),
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

class _OriginHintCard extends StatelessWidget {
  const _OriginHintCard({required this.mode});

  final ArSessionMode mode;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.38),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            const Icon(
              Icons.center_focus_strong_rounded,
              color: Colors.white,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                mode == ArSessionMode.admin
                    ? 'Наведите камеру на реальный QR-код события и тапните по поверхности в его центре. Это будет origin всей сцены.'
                    : 'Снова найдите тот же QR-код события в реальном мире и тапните по поверхности в его центре, чтобы выровнять сцену.',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  height: 1.35,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AssetChip extends StatelessWidget {
  const _AssetChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final background = isSelected
        ? AppColors.primaryBlue.withValues(alpha: 0.20)
        : Colors.white.withValues(alpha: 0.06);

    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Ink(
        width: 104,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryBlue
                : Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 28),
              const SizedBox(height: 8),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricBadge extends StatelessWidget {
  const _MetricBadge({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.62),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlassIconButton extends StatelessWidget {
  const _GlassIconButton({required this.onTap, required this.icon});

  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: SizedBox(
          width: 48,
          height: 48,
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
