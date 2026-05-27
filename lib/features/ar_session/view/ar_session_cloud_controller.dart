part of 'ar_session_screen.dart';

extension _ArSessionCloudController on _ArSessionViewState {
  void _onAnchorUploaded(ARAnchor anchor) {
    if (!mounted || anchor is! ARPlaneAnchor) {
      return;
    }

    final state = context.read<ArSessionBloc>().state;
    if (state.rootAnchor?.anchorName != anchor.name) {
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
      _refresh(() {});
    }
  }

  ARAnchor _onAnchorDownloaded(Map<String, dynamic> serializedAnchor) {
    final state = context.read<ArSessionBloc>().state;
    final resolvedTransform = _matrixFromSerializedAnchor(serializedAnchor);
    final anchor = ARPlaneAnchor(
      transformation:
          resolvedTransform ??
          ((state.rootAnchor?.anchorTransform.length ?? 0) != 16
              ? Matrix4.identity()
              : Matrix4.fromList(state.rootAnchor!.anchorTransform)),
      name:
          serializedAnchor['name']?.toString() ??
          state.rootAnchor?.anchorName ??
          'scene-root-resolved',
      cloudanchorid: state.rootAnchor?.cloudAnchorId,
      ttl: state.rootAnchor?.ttl,
    );

    _sceneRootAnchor = anchor;
    _sceneRootTransform = Matrix4.copy(anchor.transformation);
    _isResolvingSceneAnchor = false;
    context.read<ArSessionBloc>().add(
      ArSessionSceneAnchorUpdated(
        anchorName: anchor.name,
        cloudAnchorId: state.rootAnchor?.cloudAnchorId,
        anchorTransform: anchor.transformation.storage.toList(),
        ttl: state.rootAnchor?.ttl,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) {
        return;
      }
      _refresh(() {});
      await _syncSceneWithState(context.read<ArSessionBloc>().state);
    });

    return anchor;
  }

  void _onSessionError(String _) {
    if (!mounted) {
      return;
    }

    final wasCloudAnchorFlow =
        _isResolvingSceneAnchor || _isUploadingSceneAnchor;
    if (wasCloudAnchorFlow) {
      _refresh(() {
        _isResolvingSceneAnchor = false;
        _isUploadingSceneAnchor = false;
        _saveAfterSceneAnchorUpload = false;
      });
    }

    _showMessage(
      wasCloudAnchorFlow
          ? 'Не удалось подключить облачную AR-сцену. Проверьте, что телефон находится в корректной сети, и попробуйте ещё раз.'
          : 'Не удалось продолжить AR-сессию. Попробуйте ещё раз.',
    );
  }

  Future<void> _onSavePressed(ArSessionState state) async {
    if (!state.isAdmin) {
      return;
    }

    if (!_hasSceneRootAnchor) {
      _showMessage('Сначала создайте корневой anchor сцены в точке QR-кода');
      return;
    }

    if (!(state.rootAnchor?.cloudAnchorId.isNotEmpty ?? false) &&
        _sceneRootAnchor != null) {
      _isUploadingSceneAnchor = true;
      _saveAfterSceneAnchorUpload = true;
      if (mounted) {
        _refresh(() {});
      }
      final didStartUpload =
          await _arAnchorManager?.uploadAnchor(_sceneRootAnchor!) ?? false;
      if (!didStartUpload) {
        _isUploadingSceneAnchor = false;
        _saveAfterSceneAnchorUpload = false;
        if (mounted) {
          _refresh(() {});
        }
        _showMessage(
          'Не удалось подключить облачную AR-сцену. Проверьте, что телефон находится в корректной сети, и попробуйте ещё раз.',
        );
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

  NodeType _nodeTypeForModelUri(String modelUri) {
    final normalized = modelUri.trim().toLowerCase();
    if (normalized.startsWith('http://') || normalized.startsWith('https://')) {
      return NodeType.webGLB;
    }
    return NodeType.fileSystemAppFolderGLB;
  }
}
