part of 'ar_session_screen.dart';

const _actionAnchorMarkerAssetPath = 'assets/models/ar_test_anchor_marker.glb';
const _finishAnchorMarkerAssetPath =
    'assets/models/ar_finish_anchor_marker.glb';
const _actionAnchorMarkerScale = 1.0;

extension _ArSessionObjectController on _ArSessionViewState {
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
          'Сцена ещё ищет начальную точку. Наведите камеру на зону QR и дождитесь привязки.',
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
    final pendingActionAnchorRole = _pendingActionAnchorRole;
    if (pendingActionAnchorRole != null) {
      await _placeActionAnchorAtHit(
        role: pendingActionAnchorRole,
        state: state,
        hit: planeHit,
      );
      return;
    }

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
      _showMessage('Сначала создайте и сохраните начальную точку сцены');
      return;
    }

    final node = ARNode(
      name: placementId,
      type: _nodeTypeForModelUri(selectedAsset.modelUri),
      uri: selectedAsset.modelUri,
      transformation: _transformWithScale(localTransform, selectedAsset.scale),
      data: {'assetId': selectedAsset.id},
    );

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
          localTransform: _transformWithScale(
            node.transform,
            1,
          ).storage.toList(),
          meta: {'scale': selectedAsset.scale},
        ),
      ),
    );

    _isPlacingNode = false;
  }

  void _beginActionAnchorPlacement(String role) {
    if (widget.mode != ArSessionMode.admin) {
      return;
    }

    if (!_hasSceneRootAnchor) {
      _showMessage('Сначала создайте начальную точку сцены');
      return;
    }

    final hasAnchor = context.read<ArSessionBloc>().state.placements.any(
      (placement) => placement.role == role || placement.id == role,
    );
    if (!hasAnchor) {
      _showMessage('Эта контрольная точка ещё не создана в сцене');
      return;
    }

    _refresh(() {
      _pendingActionAnchorRole = role;
    });
    _showMessage('Тапните по поверхности, чтобы поставить контрольную точку');
  }

  void _cancelActionAnchorPlacement() {
    if (_pendingActionAnchorRole == null) {
      return;
    }

    _refresh(() {
      _pendingActionAnchorRole = null;
    });
  }

  Future<void> _placeActionAnchorAtHit({
    required String role,
    required ArSessionState state,
    required ARHitTestResult hit,
  }) async {
    final bloc = context.read<ArSessionBloc>();
    final placement = state.placements
        .where((item) => item.role == role || item.id == role)
        .firstOrNull;
    if (placement == null) {
      _cancelActionAnchorPlacement();
      _showMessage('Контрольная точка не найдена в сцене');
      return;
    }

    final localTransform = await _buildLocalTransform(
      Matrix4.fromList(hit.worldTransform.storage),
    );
    if (localTransform == null) {
      _showMessage('Не удалось определить позицию контрольной точки');
      return;
    }

    final scale = arPlacementScale(placement);
    bloc.add(
      ArSessionPlacementUpserted(
        placement.copyWith(
          localTransform: _transformWithScale(
            localTransform,
            1,
          ).storage.toList(),
          meta: {...placement.meta, 'scale': scale},
        ),
      ),
    );

    _refresh(() {
      _pendingActionAnchorRole = null;
    });
    _showMessage(
      role == 'test_anchor'
          ? 'Точка начала теста поставлена'
          : 'Контрольная точка поставлена',
    );
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

    final nodeName = nodeNames.first;
    final state = context.read<ArSessionBloc>().state;
    final placement = state.placements
        .where((item) => item.nodeName == nodeName || item.id == nodeName)
        .firstOrNull;
    if (placement == null) {
      _showMessage('Выбран объект: $nodeName');
      return;
    }

    if (widget.mode == ArSessionMode.user && placement.isActionAnchor) {
      _showMessage(
        placement.isTestAnchor
            ? 'Проверяем точку начала теста...'
            : 'Проверяем точку завершения квеста...',
      );
      context.read<ArSessionBloc>().add(
        ArSessionAnchorReached(
          anchorId: placement.role ?? placement.id,
          sessionId: widget.scanSessionId,
        ),
      );
      return;
    }

    if (widget.mode == ArSessionMode.admin) {
      context.read<ArSessionBloc>().add(
        ArSessionPlacementSelected(placement.id),
      );
    }

    final title = placement.meta['title']?.toString();
    _showMessage('Выбран объект: ${title ?? nodeName}');
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
        currentPlacement.copyWith(
          localTransform: _transformWithScale(transform, 1).storage.toList(),
        ),
      ),
    );
  }

  Future<void> _syncSceneWithState(ArSessionState state) async {
    if (_arObjectManager == null ||
        _sceneRootAnchor == null ||
        state.status == ArSessionStatus.loading) {
      return;
    }

    final activePlacementIds = state.placements.map((item) => item.id).toSet();
    for (final entry in _renderedNodes.entries.toList()) {
      if (!activePlacementIds.contains(entry.key)) {
        _arObjectManager!.removeNode(entry.value);
        _renderedNodes.remove(entry.key);
      }
    }

    final assetById = {for (final asset in state.assets) asset.id: asset};
    for (final placement in state.placements) {
      final transform = _matrixFromPlacement(placement);
      final placementScale = arPlacementScale(placement);
      final renderTransform = _transformWithScale(
        transform,
        placement.isActionAnchor ? _actionAnchorMarkerScale : placementScale,
      );
      final renderedNode = _renderedNodes[placement.id];
      if (renderedNode != null) {
        renderedNode.transform = renderTransform;
        continue;
      }

      final asset = assetById[placement.assetId];
      if (!placement.isActionAnchor && asset == null) {
        continue;
      }

      final node = placement.isActionAnchor
          ? ARNode(
              name: placement.nodeName,
              type: NodeType.localGLTF2,
              uri: placement.isFinishAnchor
                  ? _finishAnchorMarkerAssetPath
                  : _actionAnchorMarkerAssetPath,
              transformation: renderTransform,
              data: {'anchorRole': placement.role ?? placement.id},
            )
          : ARNode(
              name: placement.nodeName,
              type: _nodeTypeForModelUri(asset!.modelUri),
              uri: asset.modelUri,
              transformation: renderTransform,
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

  Matrix4 _matrixFromPlacement(ArAssetPlacementEntity placement) {
    final transform = placement.localTransform.length == 16
        ? Matrix4.fromList(placement.localTransform)
        : Matrix4.identity();
    return _transformWithScale(transform, 1);
  }

  Matrix4 _transformWithScale(Matrix4 transform, double scale) {
    final translation = Vector3.zero();
    final rotation = Quaternion.identity();
    transform.decompose(translation, rotation, Vector3.zero());
    return Matrix4.compose(translation, rotation, Vector3.all(scale));
  }
}
