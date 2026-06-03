import 'dart:async';
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
import 'package:vroom/core/network/json_utils.dart';
import 'package:vroom/core/dependencies/get_it.dart' as di;
import 'package:vroom/core/router/app_routes.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_anchor_reach_result_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_placement_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_session_mode.dart';
import 'package:vroom/features/ar_session/view/bloc/ar_session_bloc.dart';
import 'package:vroom/features/ar_session/view/components/ar_placement_helpers.dart';
import 'package:vroom/features/ar_session/view/components/ar_session_overlays.dart';

part 'ar_session_anchor_controller.dart';
part 'ar_session_anchor_action_dialogs.dart';
part 'ar_session_cloud_controller.dart';
part 'ar_session_object_controller.dart';

class ArSessionScreen extends StatelessWidget {
  const ArSessionScreen({
    super.key,
    required this.questId,
    required this.mode,
    this.scanSessionId,
  });

  final int questId;
  final ArSessionMode mode;
  final String? scanSessionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          di.locator<ArSessionBloc>()
            ..add(ArSessionLoadRequested(questId: questId, mode: mode)),
      child: _ArSessionView(mode: mode, scanSessionId: scanSessionId),
    );
  }
}

class _ArSessionView extends StatefulWidget {
  const _ArSessionView({required this.mode, this.scanSessionId});

  final ArSessionMode mode;
  final String? scanSessionId;

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
  String? _pendingSceneCloudAnchorId;
  final Set<String> _unavailableSceneCloudAnchorIds = {};
  String? _pendingActionAnchorRole;
  String? _activeSnackBarMessage;
  String? _lastSnackBarMessage;
  DateTime? _lastSnackBarShownAt;
  final Set<String> _completedInteractivePlacementIds = {};
  int _detectedPlaneCount = 0;

  bool get _supportsAr => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  bool get _hasSceneRootAnchor => _sceneRootAnchor != null;

  void _refresh(VoidCallback update) {
    if (!mounted) {
      return;
    }
    setState(update);
  }

  @override
  void dispose() {
    _arSessionManager?.dispose();
    super.dispose();
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

        final anchorReachResult = state.anchorReachResult;
        if (anchorReachResult != null) {
          context.read<ArSessionBloc>().add(
            const ArSessionAnchorReachResultConsumed(),
          );
          await _handleAnchorReachResult(anchorReachResult);
        }

        if (_supportsAr) {
          await _ensureSceneRootAnchor(state);
          await _syncSceneWithState(state);
        }
      },
      builder: (context, state) {
        final interactivePlacements = _trackableInteractivePlacements(state);
        final interactiveTotal = interactivePlacements.length;
        final interactiveCompleted = interactivePlacements
            .where(
              (placement) =>
                  _completedInteractivePlacementIds.contains(placement.id),
            )
            .length;

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
                      child: ArHeader(
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
                      child: OriginHintCard(
                        mode: widget.mode,
                        isResolvingSceneAnchor: _isResolvingSceneAnchor,
                        hasPersistentAnchor:
                            (state.rootAnchor?.cloudAnchorId.isNotEmpty ??
                            false),
                      ),
                    ),
                  ),
                ),
              if (_supportsAr &&
                  state.isAdmin &&
                  _pendingActionAnchorRole != null)
                Positioned(
                  left: 16,
                  right: 16,
                  top: 132,
                  child: SafeArea(
                    bottom: false,
                    child: ActionAnchorPlacementHintCard(
                      role: _pendingActionAnchorRole!,
                      onCancel: _cancelActionAnchorPlacement,
                    ),
                  ),
                ),
              if (state.status == ArSessionStatus.loading)
                const Positioned.fill(
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
              if (state.selectedPlacement != null && state.isAdmin)
                Positioned(
                  left: 16,
                  right: 88,
                  bottom: 18,
                  child: SafeArea(
                    top: false,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: ArSelectedObjectControls(state: state),
                    ),
                  ),
                ),
              if (!state.isAdmin && interactiveTotal > 0 && _hasSceneRootAnchor)
                Positioned(
                  left: 16,
                  right: 88,
                  bottom: 18,
                  child: SafeArea(
                    top: false,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: _ArInteractionProgressPill(
                        completed: interactiveCompleted,
                        total: interactiveTotal,
                      ),
                    ),
                  ),
                ),
              Positioned(
                right: 18,
                bottom: 18,
                child: SafeArea(
                  top: false,
                  child: ArSettingsButton(
                    supportsAr: _supportsAr,
                    iconBuilder: _assetIcon,
                    hasSceneRootAnchor: _hasSceneRootAnchor,
                    isResolvingSceneAnchor: _isResolvingSceneAnchor,
                    isUploadingSceneAnchor: _isUploadingSceneAnchor,
                    onSave: () => _onSavePressed(state),
                    onResetSceneAnchor: () => _resetSceneRootAnchor(state),
                    onPlaceTestAnchor: () =>
                        _beginActionAnchorPlacement('test_anchor'),
                    onOpenTest: () => context.push(
                      '${AppRoutes.questTest.path}/${state.questId}/test',
                    ),
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

class _ArInteractionProgressPill extends StatelessWidget {
  const _ArInteractionProgressPill({
    required this.completed,
    required this.total,
  });

  final int completed;
  final int total;

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.62),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.flag_circle_outlined,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Найдено $completed/$total',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
