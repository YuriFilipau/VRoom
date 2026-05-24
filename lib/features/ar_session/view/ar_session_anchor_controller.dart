part of 'ar_session_screen.dart';

extension _ArSessionAnchorController on _ArSessionViewState {
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
      _refresh(() {
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

    _refresh(() {});
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

    if ((state.rootAnchor?.cloudAnchorId.isNotEmpty ?? false) &&
        !_hasRequestedSceneAnchorDownload) {
      _hasRequestedSceneAnchorDownload = true;
      _isResolvingSceneAnchor = true;
      if (mounted) {
        _refresh(() {});
      }
      await _arAnchorManager!.downloadAnchor(state.rootAnchor!.cloudAnchorId);
      return;
    }

    if ((state.rootAnchor?.anchorTransform.length ?? 0) == 16) {
      final anchor = ARPlaneAnchor(
        transformation: Matrix4.fromList(state.rootAnchor!.anchorTransform),
        name: state.rootAnchor?.anchorName ?? 'scene-root-local',
        cloudanchorid: state.rootAnchor?.cloudAnchorId,
        ttl: state.rootAnchor?.ttl,
      );
      final didAddRoot = await _arAnchorManager!.addAnchor(anchor) ?? false;
      if (didAddRoot) {
        _sceneRootAnchor = anchor;
        _sceneRootTransform = Matrix4.copy(anchor.transformation);
        _isResolvingSceneAnchor = false;
        if (mounted) {
          _refresh(() {});
        }
      }
    }
  }

  Future<void> _resetSceneRootAnchor(ArSessionState state) async {
    await _clearSceneRootAnchor();
    if (!mounted) {
      return;
    }

    _refresh(() {});
    if (state.rootAnchor?.cloudAnchorId.isNotEmpty ?? false) {
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
}
