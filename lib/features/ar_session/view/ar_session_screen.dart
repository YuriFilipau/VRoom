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
  ARPlaneAnchor? _sceneRootAnchor;
  Matrix4? _sceneRootTransform;
  bool _isPlacingNode = false;
  bool _isResolvingSceneAnchor = false;
  bool _isUploadingSceneAnchor = false;
  bool _saveAfterSceneAnchorUpload = false;
  bool _hasRequestedSceneAnchorDownload = false;
  int _detectedPlaneCount = 0;

  bool get _supportsAr => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  bool get _hasSceneRootAnchor => _sceneRootAnchor != null;

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
    await anchorManager.initGoogleCloudAnchorMode();

    sessionManager.onPlaneOrPointTap = _onPlaneOrPointTapped;
    objectManager.onPanEnd = _onPanEnded;
    objectManager.onRotationEnd = _onRotationEnded;
    objectManager.onNodeTap = _onNodeTapped;
    anchorManager.onAnchorUploaded = _onAnchorUploaded;
    anchorManager.onAnchorDownloaded = _onAnchorDownloaded;

    if (!mounted) {
      return;
    }

    final state = context.read<ArSessionBloc>().state;
    await _ensureSceneRootAnchor(state);
    await _syncSceneWithState(state);
  }

  ARHitTestResult? _extractPlaneHit(List<ARHitTestResult> results) {
    for (final result in results) {
      if (result.type == ARHitTestResultType.plane) {
        return result;
      }
    }
    return results.isEmpty ? null : results.first;
  }

  Future<Matrix4?> _resolveSceneRootTransform() async {
    final anchor = _sceneRootAnchor;
    if (anchor == null) {
      return null;
    }

    final resolvedTransform = await _arSessionManager?.getPose(anchor);
    if (resolvedTransform != null) {
      _sceneRootTransform = Matrix4.copy(resolvedTransform);
      return _sceneRootTransform;
    }

    return _sceneRootTransform == null
        ? null
        : Matrix4.copy(_sceneRootTransform!);
  }

  Future<Matrix4?> _buildLocalTransform(Matrix4 worldTransform) async {
    final originTransform = await _resolveSceneRootTransform();
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

  Future<void> _clearSceneRootAnchor() async {
    final currentRoot = _sceneRootAnchor;
    if (currentRoot != null) {
      _arAnchorManager?.removeAnchor(currentRoot);
    }

    _sceneRootAnchor = null;
    _sceneRootTransform = null;
    _hasRequestedSceneAnchorDownload = false;
    _renderedNodes.clear();
  }

  Future<void> _setSceneRootAnchor(
    Matrix4 worldTransform, {
    required bool showFeedback,
  }) async {
    if (_arAnchorManager == null) {
      return;
    }
    final bloc = context.read<ArSessionBloc>();

    await _clearSceneRootAnchor();

    final anchor = ARPlaneAnchor(
      transformation: worldTransform,
      name: 'scene-root-${DateTime.now().millisecondsSinceEpoch}',
      ttl: 1,
    );
    final didAddRoot = await _arAnchorManager!.addAnchor(anchor) ?? false;
    if (!didAddRoot) {
      _showMessage('Не удалось создать корневой anchor сцены');
      return;
    }

    _sceneRootAnchor = anchor;
    _sceneRootTransform = Matrix4.copy(worldTransform);
    bloc.add(
      ArSessionSceneAnchorUpdated(
        anchorName: anchor.name,
        anchorTransform: anchor.transformation.storage.toList(),
        ttl: anchor.ttl,
        clearCloudAnchorId: true,
      ),
    );

    if (!mounted) {
      return;
    }

    setState(() {});
    await _syncSceneWithState(context.read<ArSessionBloc>().state);

    if (showFeedback) {
      _showMessage(
        widget.mode == ArSessionMode.admin
            ? 'Корневой anchor создан в точке QR. Теперь можно расставлять объекты.'
            : 'Anchor сцены восстановлен. Загружаю сохраненные объекты.',
      );
    }
  }

  Matrix4? _matrixFromSerializedAnchor(Map<String, dynamic> serializedAnchor) {
    final rawTransformation = serializedAnchor['transformation'];
    if (rawTransformation is! List) {
      return null;
    }

    final values = rawTransformation
        .map((value) => (value as num).toDouble())
        .toList();
    if (values.length != 16) {
      return null;
    }

    return Matrix4.fromList(values);
  }

  Future<void> _ensureSceneRootAnchor(ArSessionState state) async {
    if (_arAnchorManager == null || state.status == ArSessionStatus.loading) {
      return;
    }

    if (_sceneRootAnchor != null) {
      return;
    }

    if (state.sceneCloudAnchorId != null &&
        state.sceneCloudAnchorId!.isNotEmpty &&
        !_hasRequestedSceneAnchorDownload) {
      _hasRequestedSceneAnchorDownload = true;
      _isResolvingSceneAnchor = true;
      if (mounted) {
        setState(() {});
      }
      await _arAnchorManager!.downloadAnchor(state.sceneCloudAnchorId!);
      return;
    }

    if (state.sceneAnchorTransform != null) {
      final anchor = ARPlaneAnchor(
        transformation: Matrix4.fromList(state.sceneAnchorTransform!),
        name: state.sceneAnchorName ?? 'scene-root-local',
        cloudanchorid: state.sceneCloudAnchorId,
        ttl: state.sceneAnchorTtl,
      );
      final didAddRoot = await _arAnchorManager!.addAnchor(anchor) ?? false;
      if (didAddRoot) {
        _sceneRootAnchor = anchor;
        _sceneRootTransform = Matrix4.copy(anchor.transformation);
        _isResolvingSceneAnchor = false;
        if (mounted) {
          setState(() {});
        }
      }
    }
  }

  Future<void> _resetSceneRootAnchor(ArSessionState state) async {
    await _clearSceneRootAnchor();
    if (!mounted) {
      return;
    }

    setState(() {});
    if (state.sceneCloudAnchorId != null &&
        state.sceneCloudAnchorId!.isNotEmpty) {
      await _ensureSceneRootAnchor(state);
      _showMessage(
        'Повторно пытаюсь разрешить persistent anchor сцены. Наведите камеру на зону QR и окружение вокруг нее.',
      );
      return;
    }

    _showMessage(
      'Наведите камеру на место, где расположен QR-код, и тапните по поверхности, чтобы создать корневой anchor сцены.',
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

    if (widget.mode != ArSessionMode.admin) {
      if (!_hasSceneRootAnchor) {
        _showMessage(
          'Сцена еще не разрешила persistent anchor. Наведите камеру на зону QR и дождитесь привязки.',
        );
      }
      return;
    }

    if (!_hasSceneRootAnchor) {
      await _setSceneRootAnchor(
        Matrix4.fromList(planeHit.worldTransform.storage),
        showFeedback: true,
      );
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
    if (localTransform == null || _sceneRootAnchor == null) {
      _isPlacingNode = false;
      _showMessage('Сначала создайте и сохраните корневой anchor сцены');
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
        await _arObjectManager!.addNode(node, planeAnchor: _sceneRootAnchor!) ??
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
          anchorName: _sceneRootAnchor!.name,
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
        _sceneRootAnchor == null ||
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
            planeAnchor: _sceneRootAnchor!,
          ) ??
          false;
      if (didAddNode) {
        _renderedNodes[placement.id] = node;
      }
    }
  }

  void _onAnchorUploaded(ARAnchor anchor) {
    if (!mounted || anchor is! ARPlaneAnchor) {
      return;
    }

    final state = context.read<ArSessionBloc>().state;
    if (state.sceneAnchorName != anchor.name) {
      return;
    }

    context.read<ArSessionBloc>().add(
      ArSessionSceneAnchorUpdated(
        anchorName: anchor.name,
        cloudAnchorId: anchor.cloudanchorid,
        anchorTransform: anchor.transformation.storage.toList(),
        ttl: anchor.ttl,
      ),
    );

    _isUploadingSceneAnchor = false;
    if (_saveAfterSceneAnchorUpload) {
      _saveAfterSceneAnchorUpload = false;
      context.read<ArSessionBloc>().add(const ArSessionSaveRequested());
    }

    if (mounted) {
      setState(() {});
    }
  }

  ARAnchor _onAnchorDownloaded(Map<String, dynamic> serializedAnchor) {
    final state = context.read<ArSessionBloc>().state;
    final resolvedTransform = _matrixFromSerializedAnchor(serializedAnchor);
    final anchor = ARPlaneAnchor(
      transformation:
          resolvedTransform ??
          (state.sceneAnchorTransform == null
              ? Matrix4.identity()
              : Matrix4.fromList(state.sceneAnchorTransform!)),
      name:
          serializedAnchor['name']?.toString() ??
          state.sceneAnchorName ??
          'scene-root-resolved',
      cloudanchorid: state.sceneCloudAnchorId,
      ttl: state.sceneAnchorTtl,
    );

    _sceneRootAnchor = anchor;
    _sceneRootTransform = Matrix4.copy(anchor.transformation);
    _isResolvingSceneAnchor = false;
    context.read<ArSessionBloc>().add(
      ArSessionSceneAnchorUpdated(
        anchorName: anchor.name,
        cloudAnchorId: state.sceneCloudAnchorId,
        anchorTransform: anchor.transformation.storage.toList(),
        ttl: state.sceneAnchorTtl,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) {
        return;
      }
      setState(() {});
      await _syncSceneWithState(context.read<ArSessionBloc>().state);
    });

    return anchor;
  }

  void _onSessionError(String error) {
    if (!mounted) {
      return;
    }

    if (_isResolvingSceneAnchor || _isUploadingSceneAnchor) {
      setState(() {
        _isResolvingSceneAnchor = false;
        _isUploadingSceneAnchor = false;
        _saveAfterSceneAnchorUpload = false;
      });
    }

    _showMessage(error);
  }

  Future<void> _onSavePressed(ArSessionState state) async {
    if (!state.isAdmin) {
      return;
    }

    if (!_hasSceneRootAnchor) {
      _showMessage('Сначала создайте корневой anchor сцены в точке QR-кода');
      return;
    }

    if ((state.sceneCloudAnchorId == null ||
            state.sceneCloudAnchorId!.isEmpty) &&
        _sceneRootAnchor != null) {
      _isUploadingSceneAnchor = true;
      _saveAfterSceneAnchorUpload = true;
      if (mounted) {
        setState(() {});
      }
      final didStartUpload =
          await _arAnchorManager?.uploadAnchor(_sceneRootAnchor!) ?? false;
      if (!didStartUpload) {
        _isUploadingSceneAnchor = false;
        _saveAfterSceneAnchorUpload = false;
        if (mounted) {
          setState(() {});
        }
        _showMessage('Не удалось запустить upload persistent anchor');
      }
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
          await _ensureSceneRootAnchor(state);
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
                        hasSceneRootAnchor: _hasSceneRootAnchor,
                      ),
                    ),
                  ),
                ),
              ),
              if (_supportsAr &&
                  state.status != ArSessionStatus.loading &&
                  !_hasSceneRootAnchor)
                Positioned(
                  left: 16,
                  right: 16,
                  top: 132,
                  child: SafeArea(
                    bottom: false,
                    child: IgnorePointer(
                      child: _OriginHintCard(
                        mode: widget.mode,
                        isResolvingSceneAnchor: _isResolvingSceneAnchor,
                        hasPersistentAnchor:
                            (state.sceneCloudAnchorId?.isNotEmpty ?? false),
                      ),
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
                    hasSceneRootAnchor: _hasSceneRootAnchor,
                    isResolvingSceneAnchor: _isResolvingSceneAnchor,
                    isUploadingSceneAnchor: _isUploadingSceneAnchor,
                    onSave: () => _onSavePressed(state),
                    onResetSceneAnchor: () => _resetSceneRootAnchor(state),
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
    required this.hasSceneRootAnchor,
  });

  final String title;
  final String subtitle;
  final int planeCount;
  final bool hasSceneRootAnchor;

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
                    hasSceneRootAnchor
                        ? 'Persistent anchor сцены активен. Найдено плоскостей: $planeCount'
                        : planeCount > 0
                        ? 'Найдено плоскостей: $planeCount. Ищу корневой anchor сцены.'
                        : 'Сканируйте окружение вокруг QR до успешной привязки',
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
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: supportsAr ? onResetSceneAnchor : null,
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
                        hasSceneRootAnchor
                            ? 'Повторно разрешить anchor'
                            : state.isAdmin
                            ? 'Создать root anchor'
                            : 'Повторить поиск anchor',
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
                        child:
                            state.status == ArSessionStatus.saving ||
                                isUploadingSceneAnchor
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                state.sceneCloudAnchorId?.isNotEmpty ?? false
                                    ? 'Сохранить сцену'
                                    : 'Создать persistent anchor и сохранить',
                              ),
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
  const _OriginHintCard({
    required this.mode,
    required this.isResolvingSceneAnchor,
    required this.hasPersistentAnchor,
  });

  final ArSessionMode mode;
  final bool isResolvingSceneAnchor;
  final bool hasPersistentAnchor;

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
                isResolvingSceneAnchor
                    ? 'Ищу persistent anchor сцены. Медленно наведите камеру на QR-зону и окружение, где админ сохранял сцену.'
                    : mode == ArSessionMode.admin
                    ? 'Наведите камеру на реальный QR-код события и тапните по поверхности в его центре. Это создаст root anchor всей сцены.'
                    : hasPersistentAnchor
                    ? 'У сцены есть persistent anchor. Если объекты не появились, медленно осмотрите зону QR, пока relocalization не завершится.'
                    : 'У сцены пока нет persistent anchor. Сначала администратор должен сохранить сцену.',
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
