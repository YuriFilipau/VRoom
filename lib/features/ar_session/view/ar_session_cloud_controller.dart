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

    final cloudAnchorId = anchor.cloudanchorid?.trim();
    if (cloudAnchorId != null && cloudAnchorId.isNotEmpty) {
      _unavailableSceneCloudAnchorIds.remove(cloudAnchorId);
    }
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
    _pendingSceneCloudAnchorId = null;
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

  void _onSessionError(String message) {
    if (!mounted) {
      return;
    }

    if (kDebugMode) {
      debugPrint('AR session error: $message');
    }

    final wasCloudAnchorFlow =
        _isResolvingSceneAnchor || _isUploadingSceneAnchor;
    final wasCloudAnchorDownload = _isResolvingSceneAnchor;
    final failedCloudAnchorId =
        _pendingSceneCloudAnchorId ??
        context.read<ArSessionBloc>().state.rootAnchor?.cloudAnchorId.trim();
    final isCloudAnchorIdNotFound = _isCloudAnchorIdNotFoundError(message);
    if (wasCloudAnchorFlow) {
      _refresh(() {
        _isResolvingSceneAnchor = false;
        _isUploadingSceneAnchor = false;
        _saveAfterSceneAnchorUpload = false;
      });
    }
    _pendingSceneCloudAnchorId = null;

    if (wasCloudAnchorDownload && isCloudAnchorIdNotFound) {
      if (failedCloudAnchorId != null && failedCloudAnchorId.isNotEmpty) {
        _unavailableSceneCloudAnchorIds.add(failedCloudAnchorId);
      }
      unawaited(_fallbackToStoredSceneAnchorAfterCloudFailure());
      return;
    }

    final renderableDetails =
        kDebugMode && message.trim().startsWith('Unable to load renderable')
        ? '\n${message.trim()}'
        : '';
    _showMessage(
      wasCloudAnchorFlow
          ? _cloudAnchorRuntimeFailureMessage(message)
          : 'Не удалось продолжить AR-сессию. Попробуйте ещё раз.$renderableDetails',
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
        _showMessage(_cloudAnchorUploadFailureMessage());
      }
      return;
    }

    context.read<ArSessionBloc>().add(const ArSessionSaveRequested());
  }

  String _cloudAnchorUploadFailureMessage() {
    return 'Не удалось создать облачную точку. Медленно поводите камерой вокруг точки сцены и повторите сохранение.';
  }

  bool _isCloudAnchorIdNotFoundError(String message) {
    final normalized = message.toLowerCase();
    return normalized.contains('rawvalue: -6') ||
        normalized.contains('cloudidnotfound') ||
        normalized.contains('cloud anchor id not found') ||
        normalized.contains('cloud id not found');
  }

  String _cloudAnchorRuntimeFailureMessage(String message) {
    final normalized = message.toLowerCase();
    if (_isCloudAnchorIdNotFoundError(message)) {
      return 'Cloud Anchor не найден. Если сцена не восстановится автоматически, пересоздайте начальную точку и сохраните сцену.';
    }
    if (normalized.contains('not authorized') ||
        normalized.contains('not_authorized') ||
        normalized.contains('unauthorized') ||
        normalized.contains('permission') ||
        normalized.contains('rawvalue: -2')) {
      return 'Cloud Anchor не авторизован. Проверьте настройки Google Cloud и ключи ARCore/Cloud Anchors.';
    }
    if (normalized.contains('network') ||
        normalized.contains('internet') ||
        normalized.contains('unavailable') ||
        normalized.contains('rawvalue: -3') ||
        normalized.contains('rawvalue: -10')) {
      return 'Не удалось подключить облачную AR-сцену. Проверьте интернет и повторите попытку.';
    }
    return 'Не удалось подключить облачную AR-сцену. Попробуйте ещё раз.';
  }

  void _showMessage(String message) {
    final normalizedMessage = message.trim();
    if (!mounted || normalizedMessage.isEmpty) {
      return;
    }

    final now = DateTime.now();
    final wasRecentlyShown =
        _lastSnackBarMessage == normalizedMessage &&
        _lastSnackBarShownAt != null &&
        now.difference(_lastSnackBarShownAt!) < const Duration(seconds: 4);
    if (_activeSnackBarMessage == normalizedMessage || wasRecentlyShown) {
      return;
    }

    _activeSnackBarMessage = normalizedMessage;
    _lastSnackBarMessage = normalizedMessage;
    _lastSnackBarShownAt = now;

    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    unawaited(
      messenger
          .showSnackBar(SnackBar(content: Text(normalizedMessage)))
          .closed
          .then((_) {
            if (!mounted || _activeSnackBarMessage != normalizedMessage) {
              return;
            }
            _activeSnackBarMessage = null;
          }),
    );
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
