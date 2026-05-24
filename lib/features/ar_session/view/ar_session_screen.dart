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
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;
import 'package:vroom/core/dependencies/get_it.dart' as di;
import 'package:vroom/features/ar_session/domain/entities/ar_asset_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_placement_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_session_mode.dart';
import 'package:vroom/features/ar_session/view/bloc/ar_session_bloc.dart';
import 'package:vroom/features/ar_session/view/components/ar_session_overlays.dart';

part 'ar_session_anchor_controller.dart';
part 'ar_session_cloud_controller.dart';
part 'ar_session_object_controller.dart';

class ArSessionScreen extends StatelessWidget {
  const ArSessionScreen({super.key, required this.questId, required this.mode});

  final int questId;
  final ArSessionMode mode;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          di.locator<ArSessionBloc>()
            ..add(ArSessionLoadRequested(questId: questId, mode: mode)),
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
              if (state.status == ArSessionStatus.loading)
                const Positioned.fill(
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
              Positioned.fill(
                child: PointerInterceptor(
                  intercepting: false,
                  child: ArBottomSheet(
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
