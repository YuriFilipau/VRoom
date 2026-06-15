part of 'ar_session_screen.dart';

const _actionAnchorMarkerAssetPath = 'assets/models/ar_test_anchor_marker.glb';
const _finishAnchorMarkerAssetPath =
    'assets/models/ar_finish_anchor_marker.glb';

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
      transformation: _transformWithScale(
        localTransform,
        selectedAsset.scale * selectedAsset.normalizationScale,
      ),
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

    await _stabilizeNodeTransform(
      node,
      _transformWithScale(
        localTransform,
        selectedAsset.scale * selectedAsset.normalizationScale,
      ),
    );
    _renderedNodes[placementId] = node;
    bloc.add(
      ArSessionPlacementUpserted(
        ArAssetPlacementEntity(
          id: placementId,
          assetId: selectedAsset.id,
          nodeName: placementId,
          localTransform: _transformWithScale(
            localTransform,
            selectedAsset.scale,
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

    _refresh(() {
      _pendingActionAnchorRole = role;
    });
    _showMessage(
      role == 'test_anchor'
          ? 'Тапните по поверхности, чтобы поставить точку начала теста'
          : 'Тапните по поверхности, чтобы поставить точку окончания квеста',
    );
  }

  void _cancelActionAnchorPlacement() {
    if (_pendingActionAnchorRole == null) {
      return;
    }

    _refresh(() {
      _pendingActionAnchorRole = null;
    });
  }

  ArAssetPlacementEntity? _placeholderActionAnchor({
    required String role,
    required ArSessionState state,
  }) {
    final assetId = state.assets.firstOrNull?.id ?? 0;
    return switch (role) {
      'test_anchor' => ArAssetPlacementEntity(
        id: 'test_anchor',
        assetId: assetId,
        nodeName: 'test_anchor',
        localTransform: arDefaultActionAnchorTransform,
        meta: const {
          'id': 'test_anchor',
          'role': 'test_anchor',
          'title': 'Точка начала теста',
          'action': {
            'type': 'unlock_test',
            'label': 'Начать тест',
            'presentation': 'world_button',
          },
        },
      ),
      'finish_anchor' => ArAssetPlacementEntity(
        id: 'finish_anchor',
        assetId: assetId,
        nodeName: 'finish_anchor',
        localTransform: arDefaultActionAnchorTransform,
        meta: const {
          'id': 'finish_anchor',
          'role': 'finish_anchor',
          'title': 'Точка окончания квеста',
          'action': {
            'type': 'complete_quest',
            'label': 'Завершить квест',
            'presentation': 'fullscreen_dialog',
          },
        },
      ),
      _ => null,
    };
  }

  Future<void> _placeActionAnchorAtHit({
    required String role,
    required ArSessionState state,
    required ARHitTestResult hit,
  }) async {
    final bloc = context.read<ArSessionBloc>();
    final placement = state.placements
        .where((item) => _matchesActionAnchorRole(item, role))
        .firstOrNull;
    final targetPlacement =
        placement ?? _placeholderActionAnchor(role: role, state: state);
    if (targetPlacement == null) {
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

    final scale = arPlacementScale(targetPlacement);
    bloc.add(
      ArSessionPlacementUpserted(
        targetPlacement.copyWith(
          localTransform: _transformWithScale(
            localTransform,
            scale,
          ).storage.toList(),
          meta: {...targetPlacement.meta, 'scale': scale},
        ),
      ),
    );

    _refresh(() {
      _pendingActionAnchorRole = null;
    });
    _showMessage(
      role == 'test_anchor'
          ? 'Точка начала теста поставлена'
          : 'Точка окончания квеста поставлена',
    );
  }

  Future<void> _onPanEnded(String nodeName, Matrix4 transform) async {
    await _updatePlacementTransform(nodeName, transform);
  }

  Future<void> _onRotationEnded(String nodeName, Matrix4 transform) async {
    await _updatePlacementTransform(nodeName, transform);
  }

  void _onNodeTapped(List<String> nodeNames) {
    unawaited(_handleNodeTapped(nodeNames));
  }

  Future<void> _handleNodeTapped(List<String> nodeNames) async {
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

    if (widget.mode == ArSessionMode.user &&
        _isUserInteractivePlacement(placement)) {
      await _showInteractivePlacement(placement);
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
          anchorId: placement.id,
          sessionId: widget.scanSessionId,
          interactionType: _actionAnchorRole(placement),
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

  void _onPanStarted(String nodeName) {
    _selectPlacementByNodeName(nodeName);
  }

  void _onPanChanged(String nodeName) {}

  void _onRotationStarted(String nodeName) {
    _selectPlacementByNodeName(nodeName);
  }

  void _onRotationChanged(String nodeName) {}

  void _selectPlacementByNodeName(String nodeName) {
    if (!mounted || widget.mode != ArSessionMode.admin) {
      return;
    }

    final placement = context
        .read<ArSessionBloc>()
        .state
        .placements
        .where((item) => item.nodeName == nodeName || item.id == nodeName)
        .firstOrNull;
    if (placement == null) {
      return;
    }

    context.read<ArSessionBloc>().add(ArSessionPlacementSelected(placement.id));
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
      (item) => item.nodeName == nodeName || item.id == nodeName,
    );
    if (placements.isEmpty) {
      return;
    }

    final currentPlacement = placements.first;

    bloc.add(
      ArSessionPlacementUpserted(
        currentPlacement.copyWith(
          localTransform: _transformWithScale(
            transform,
            arPlacementScale(currentPlacement),
          ).storage.toList(),
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
    final activeNodeNames = state.placements
        .map((item) => item.nodeName)
        .toSet();
    final hasFinishAnchor = state.placements.any((item) => item.isFinishAnchor);
    final hasTestAnchor = state.placements.any((item) => item.isTestAnchor);
    for (final entry in _renderedNodes.entries.toList()) {
      final node = entry.value;
      final nodeRole = node.data?['anchorRole']?.toString();
      final isStaleFinishAnchor =
          !hasFinishAnchor &&
          (entry.key == 'finish_anchor' ||
              node.name == 'finish_anchor' ||
              nodeRole == 'finish_anchor');
      final isStaleTestAnchor =
          !hasTestAnchor &&
          (entry.key == 'test_anchor' ||
              node.name == 'test_anchor' ||
              nodeRole == 'test_anchor');
      if (!activePlacementIds.contains(entry.key) ||
          !activeNodeNames.contains(node.name) ||
          isStaleFinishAnchor ||
          isStaleTestAnchor) {
        await _removeRenderedNode(entry.key, node);
      }
    }

    final assetById = {for (final asset in state.assets) asset.id: asset};
    for (final placement in state.placements) {
      final asset = assetById[placement.assetId];
      final renderTransform = _renderTransformForPlacement(placement, asset);
      final renderedNode = _renderedNodes[placement.id];
      if (placement.isActionAnchor &&
          arPlacementHasDefaultActionTransform(placement)) {
        if (renderedNode != null) {
          await _removeRenderedNode(placement.id, renderedNode);
        }
        continue;
      }
      if (renderedNode != null) {
        await _stabilizeNodeTransform(renderedNode, renderTransform);
        continue;
      }

      if (!placement.isActionAnchor && asset == null) {
        if (kDebugMode) {
          debugPrint(
            'AR placement skipped: missing asset #${placement.assetId} '
            'for ${placement.id}',
          );
        }
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
              data: {'anchorRole': _actionAnchorRole(placement)},
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
        await _stabilizeNodeTransform(node, renderTransform);
        _renderedNodes[placement.id] = node;
      }
    }
  }

  Future<void> _removeRenderedNode(String key, ARNode node) async {
    node.transform = Matrix4.compose(
      Vector3(0, -1000, 0),
      Quaternion.identity(),
      Vector3.zero(),
    );
    await Future<void>.delayed(const Duration(milliseconds: 16));
    _arObjectManager!.removeNode(node);
    _renderedNodes.remove(key);
  }

  bool _matchesActionAnchorRole(ArAssetPlacementEntity placement, String role) {
    return switch (role) {
      'test_anchor' => placement.isTestAnchor,
      'finish_anchor' => placement.isFinishAnchor,
      _ => placement.role == role || placement.id == role,
    };
  }

  String _actionAnchorRole(ArAssetPlacementEntity placement) {
    if (placement.isTestAnchor) {
      return 'test_anchor';
    }
    if (placement.isFinishAnchor) {
      return 'finish_anchor';
    }
    return placement.role ?? placement.id;
  }

  Matrix4 _matrixFromPlacement(ArAssetPlacementEntity placement) {
    return placement.localTransform.length == 16
        ? Matrix4.fromList(placement.localTransform)
        : Matrix4.identity();
  }

  Matrix4 _renderTransformForPlacement(
    ArAssetPlacementEntity placement,
    ArAssetEntity? asset,
  ) {
    final transform = _matrixFromPlacement(placement);
    final desiredScale = arPlacementRenderScale(placement, asset);
    final currentScale = Vector3.zero();
    transform.decompose(Vector3.zero(), Quaternion.identity(), currentScale);
    if ((currentScale.x - desiredScale).abs() < 0.001 &&
        (currentScale.y - desiredScale).abs() < 0.001 &&
        (currentScale.z - desiredScale).abs() < 0.001) {
      return transform;
    }
    return _transformWithScale(transform, desiredScale);
  }

  Matrix4 _transformWithScale(Matrix4 transform, double scale) {
    final translation = Vector3.zero();
    final rotation = Quaternion.identity();
    transform.decompose(translation, rotation, Vector3.zero());
    return Matrix4.compose(translation, rotation, Vector3.all(scale));
  }

  Future<void> _stabilizeNodeTransform(ARNode node, Matrix4 transform) async {
    node.transform = transform;
    await Future<void>.delayed(const Duration(milliseconds: 16));
    node.transform = transform;
  }

  List<ArAssetPlacementEntity> _trackableInteractivePlacements(
    ArSessionState state,
  ) {
    return state.placements
        .where(_isTrackableInteractivePlacement)
        .toList(growable: false);
  }

  bool _isTrackableInteractivePlacement(ArAssetPlacementEntity placement) {
    return switch (_interactionTypeForPlacement(placement)) {
      'mini_question' || 'collectable' => true,
      _ => false,
    };
  }

  bool _isUserInteractivePlacement(ArAssetPlacementEntity placement) {
    return switch (_interactionTypeForPlacement(placement)) {
      'hint' || 'mini_question' || 'collectable' => true,
      _ => false,
    };
  }

  String? _interactionTypeForPlacement(ArAssetPlacementEntity placement) {
    final meta = placement.meta;
    final action = _interactionPayload(placement);
    final rawType =
        _readInteractionString(meta['interaction_type']) ??
        _readInteractionString(meta['interactionType']) ??
        _readInteractionString(meta['type']) ??
        _readInteractionString(action['interaction_type']) ??
        _readInteractionString(action['interactionType']) ??
        _readInteractionString(action['type']) ??
        placement.role;
    final normalized = rawType?.trim().toLowerCase();
    return switch (normalized) {
      'information' || 'info' || 'card' || 'information_card' => 'hint',
      'question' ||
      'quiz' ||
      'mini-question' ||
      'miniquestion' => 'mini_question',
      'collect' || 'collection' || 'collectible' => 'collectable',
      'test' || 'test-anchor' => 'test_anchor',
      'finish' || 'finish-anchor' => 'finish_anchor',
      _ => normalized,
    };
  }

  Map<String, dynamic> _interactionPayload(ArAssetPlacementEntity placement) {
    final meta = placement.meta;
    return asMap(
      meta['interaction'] ??
          meta['interactive'] ??
          meta['action'] ??
          meta['payload'],
    );
  }

  Future<void> _showInteractivePlacement(
    ArAssetPlacementEntity placement,
  ) async {
    final interactionType = _interactionTypeForPlacement(placement);
    if (interactionType == null) {
      return;
    }

    final state = context.read<ArSessionBloc>().state;
    final asset = state.assetForPlacement(placement);
    final payload = _interactionPayload(placement);
    final title = _interactionTitle(placement, asset, payload);

    if (interactionType == 'mini_question') {
      final selectedOption = await _showMiniQuestionSheet(
        placement: placement,
        title: title,
        payload: payload,
      );
      if (selectedOption != null) {
        _recordInteractivePlacement(
          placement,
          interactionType: interactionType,
          answerIndex: selectedOption.answerIndex,
        );
      }
      return;
    }

    final body = _interactionBody(placement, asset, payload);
    final primaryLabel = switch (interactionType) {
      'collectable' => 'Собрать',
      'hint' => 'Понятно',
      _ => 'Готово',
    };
    final completed = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => ArInteractionSheet(
        icon: _interactionIcon(interactionType),
        title: title,
        body: body,
        primaryLabel: primaryLabel,
        onPrimaryPressed: () => Navigator.of(sheetContext).pop(true),
      ),
    );
    if (completed == true && _isRequiredInteractionType(interactionType)) {
      _recordInteractivePlacement(placement, interactionType: interactionType);
    }
  }

  Future<ArMiniQuestionOption?> _showMiniQuestionSheet({
    required ArAssetPlacementEntity placement,
    required String title,
    required Map<String, dynamic> payload,
  }) {
    final question =
        _readInteractionString(payload['question']) ??
        _readInteractionString(placement.meta['question']) ??
        _interactionBody(placement, null, payload);
    final options = _miniQuestionOptions(placement, payload);
    if (options.isEmpty) {
      return showModalBottomSheet<ArMiniQuestionOption>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (sheetContext) => ArInteractionSheet(
          icon: Icons.quiz_outlined,
          title: title,
          body: question,
          primaryLabel: 'Готово',
          onPrimaryPressed: () => Navigator.of(
            sheetContext,
          ).pop(const ArMiniQuestionOption(label: '', isCorrect: true)),
        ),
      );
    }

    return showModalBottomSheet<ArMiniQuestionOption>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => ArMiniQuestionSheet(
        title: title,
        question: question,
        options: options,
        onOptionSelected: (option) => Navigator.of(sheetContext).pop(option),
      ),
    );
  }

  List<ArMiniQuestionOption> _miniQuestionOptions(
    ArAssetPlacementEntity placement,
    Map<String, dynamic> payload,
  ) {
    final rawOptions = asList(payload['options']).isNotEmpty
        ? asList(payload['options'])
        : asList(placement.meta['options']);
    final correctIndex =
        readInt(payload['correct_index']) ??
        readInt(payload['correctIndex']) ??
        readInt(placement.meta['correct_index']) ??
        readInt(placement.meta['correctIndex']);
    final correctAnswer =
        _readInteractionString(payload['correct_answer']) ??
        _readInteractionString(payload['correctAnswer']) ??
        _readInteractionString(placement.meta['correct_answer']) ??
        _readInteractionString(placement.meta['correctAnswer']);

    return rawOptions
        .asMap()
        .entries
        .map((entry) {
          final index = entry.key;
          final rawOption = entry.value;
          final json = asMap(rawOption);
          final label =
              _readInteractionString(json['label']) ??
              _readInteractionString(json['title']) ??
              _readInteractionString(json['text']) ??
              _readInteractionString(json['value']) ??
              _readInteractionString(rawOption) ??
              'Вариант ${index + 1}';
          final optionKey =
              _readInteractionString(json['key']) ??
              _readInteractionString(json['id']) ??
              _readInteractionString(json['value']) ??
              label;
          final isCorrect =
              readBool(json['is_correct']) ??
              readBool(json['isCorrect']) ??
              readBool(json['correct']) ??
              (correctIndex == null ? null : correctIndex == index) ??
              (correctAnswer == null
                  ? null
                  : correctAnswer.trim().toLowerCase() ==
                            optionKey.trim().toLowerCase() ||
                        correctAnswer.trim().toLowerCase() ==
                            label.trim().toLowerCase()) ??
              false;
          return ArMiniQuestionOption(
            label: label,
            isCorrect: isCorrect,
            answerIndex: index,
          );
        })
        .toList(growable: false);
  }

  void _recordInteractivePlacement(
    ArAssetPlacementEntity placement, {
    required String interactionType,
    int? answerIndex,
  }) {
    if (!mounted ||
        widget.mode == ArSessionMode.admin ||
        !_isRequiredInteractionType(interactionType)) {
      return;
    }

    context.read<ArSessionBloc>().add(
      ArSessionAnchorReached(
        anchorId: placement.id,
        sessionId: widget.scanSessionId,
        interactionType: interactionType,
        answerIndex: answerIndex,
      ),
    );
  }

  bool _isRequiredInteractionType(String interactionType) {
    return switch (interactionType) {
      'mini_question' || 'collectable' => true,
      _ => false,
    };
  }

  void _applyAnchorReachProgress(ArAnchorReachResultEntity result) {
    if (!mounted || result.anchorId.isEmpty) {
      return;
    }

    _refresh(() {
      _completedInteractivePlacementIds.add(result.anchorId);
    });
  }

  String _interactionTitle(
    ArAssetPlacementEntity placement,
    ArAssetEntity? asset,
    Map<String, dynamic> payload,
  ) {
    return _readInteractionTitle(payload['title']) ??
        _readInteractionTitle(placement.meta['title']) ??
        arPlacementTitle(placement, asset);
  }

  String _interactionBody(
    ArAssetPlacementEntity placement,
    ArAssetEntity? asset,
    Map<String, dynamic> payload,
  ) {
    return _readInteractionString(payload['description']) ??
        _readInteractionString(payload['text']) ??
        _readInteractionString(payload['body']) ??
        _readInteractionString(payload['content']) ??
        _readInteractionString(payload['hint']) ??
        _readInteractionString(placement.meta['description']) ??
        _readInteractionString(placement.meta['text']) ??
        _readInteractionString(placement.meta['body']) ??
        _readInteractionString(placement.meta['content']) ??
        _readInteractionString(placement.meta['hint']) ??
        arPlacementTitle(placement, asset);
  }

  String? _readInteractionTitle(dynamic raw) {
    final value = _readInteractionString(raw);
    if (value == null || _looksLikeModelFilename(value)) {
      return null;
    }
    return value;
  }

  String? _readInteractionString(dynamic raw) {
    if (raw is Map || raw is List) {
      return null;
    }
    return readString(raw);
  }

  bool _looksLikeModelFilename(String value) {
    final normalized = value.trim().toLowerCase();
    return normalized.endsWith('.glb') ||
        normalized.endsWith('.gltf') ||
        normalized.contains('.glb?') ||
        normalized.contains('.gltf?') ||
        normalized.startsWith('ar_asset_');
  }

  IconData _interactionIcon(String interactionType) {
    return switch (interactionType) {
      'hint' => Icons.lightbulb_outline,
      'mini_question' => Icons.quiz_outlined,
      'collectable' => Icons.add_task_outlined,
      _ => Icons.info_outline,
    };
  }
}
