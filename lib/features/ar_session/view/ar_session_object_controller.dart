part of 'ar_session_screen.dart';

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
          localTransform: node.transform.storage.toList(),
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
        currentPlacement.copyWith(localTransform: transform.storage.toList()),
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
        type: _nodeTypeForModelUri(asset.modelUri),
        uri: asset.modelUri,
        transformation: Matrix4.fromList(placement.localTransform),
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
}
