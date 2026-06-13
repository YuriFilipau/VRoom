import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vroom/core/network/api_exception.dart';
import 'package:vroom/core/network/json_utils.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_anchor_reach_result_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_placement_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_quest_scene_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_scene_root_anchor_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_session_mode.dart';
import 'package:vroom/features/ar_session/domain/repository/ar_repository.dart';

class ArRepositoryImpl implements ArRepository {
  ArRepositoryImpl({
    required Dio dio,
    required SharedPreferences sharedPreferences,
  }) : _dio = dio,
       _sharedPreferences = sharedPreferences;

  final Dio _dio;
  final SharedPreferences _sharedPreferences;

  static const _sceneCachePrefix = 'ar_scene_cache_v6_';
  static const _glbCacheVersion = 'v3';
  static const _iosGlbCacheVersion = 'ios_v3';

  @override
  Future<ArQuestSceneEntity> loadScene({
    required int questId,
    required ArSessionMode mode,
  }) async {
    try {
      if (mode == ArSessionMode.admin) {
        final arConfigResponse = await _dio.get<dynamic>(
          '/api/mobile/organizer/quests/$questId/ar-config',
        );
        final arConfigJson = asMap(arConfigResponse.data);
        final sceneJson = await _fetchOrganizerSceneJson(questId);
        final latestLayoutSceneJson = _sceneJsonFromLayout(
          asMap(arConfigJson['latest_layout'] ?? arConfigJson['latestLayout']),
          fallbackQuestId: questId,
        );
        final arcoreToken = await _fetchArcoreToken();

        final assets = await _prepareLocalAssets(
          _parseAssetsFromConfig(arConfigJson),
        );

        final scene = _parseScene(
          questId: questId,
          sceneJson: sceneJson.isNotEmpty
              ? sceneJson
              : latestLayoutSceneJson.isNotEmpty
              ? latestLayoutSceneJson
              : asMap(arConfigJson['scene']),
          assets: assets,
          fallbackJson: arConfigJson,
          arcoreToken: arcoreToken,
        );
        await _cacheScene(scene);
        return scene;
      }

      final bundleResponse = await _dio.get<dynamic>(
        '/api/quests/$questId/bundle',
      );
      final bundleJson = asMap(bundleResponse.data);
      final layoutJson = await _fetchParticipantLayoutJson(questId);
      final sceneJson = layoutJson.isNotEmpty
          ? _sceneJsonFromLayout(layoutJson, fallbackQuestId: questId)
          : asMap(bundleJson['scene']).isNotEmpty
          ? asMap(bundleJson['scene'])
          : asMap(bundleJson['layout']);
      final assets = await _prepareLocalAssets(
        _parseAssetsFromConfig(bundleJson, layoutJson: layoutJson),
      );
      final scene = _parseScene(
        questId: questId,
        sceneJson: sceneJson,
        assets: assets,
        fallbackJson: bundleJson,
      );
      await _cacheScene(scene);
      return scene;
    } on DioException catch (error) {
      final cached = await _readCachedScene(questId);
      if (cached != null) {
        return cached;
      }
      throw _mapDioException(
        error,
        fallbackMessage: 'Не удалось загрузить AR-сцену квеста',
      );
    }
  }

  @override
  Future<ArQuestSceneEntity> saveScene({
    required int questId,
    required int? version,
    required ArSceneRootAnchorEntity? rootAnchor,
    required List<ArAssetPlacementEntity> objects,
  }) async {
    try {
      final latestSceneJson = await _fetchOrganizerSceneJson(questId);
      final latestVersion = readInt(latestSceneJson['version']) ?? version;
      final arConfigResponse = await _dio.get<dynamic>(
        '/api/mobile/organizer/quests/$questId/ar-config',
      );
      final arConfigJson = asMap(arConfigResponse.data);
      final questJson = asMap(arConfigJson['quest']);
      final payload = {
        'sceneId': 'quest_$questId',
        'questId': questId,
        'eventId':
            readInt(latestSceneJson['eventId']) ??
            readInt(latestSceneJson['event_id']) ??
            readInt(questJson['event_id']) ??
            readInt(arConfigJson['event_id']) ??
            0,
        'title':
            readString(latestSceneJson['title']) ??
            readString(questJson['title']) ??
            'AR-сцена квеста',
        if (latestVersion != null) 'version': latestVersion,
        'isPublished':
            readBool(latestSceneJson['isPublished']) ??
            readBool(latestSceneJson['is_published']) ??
            (readString(questJson['status']) == 'published'),
        'rootAnchor': rootAnchor?.toJson(),
        'objects': objects
            .map(
              (object) => {
                'id': object.id,
                'assetId': object.assetId,
                'nodeName': object.nodeName,
                'localTransform': object.localTransform,
                if (object.meta.isNotEmpty) 'meta': object.meta,
              },
            )
            .toList(growable: false),
      };

      final response = await _dio.post<dynamic>(
        '/api/mobile/organizer/quests/$questId/scene',
        data: payload,
      );
      final responseJson = asMap(response.data);
      final persistedSceneJson = await _fetchOrganizerSceneJson(questId);
      final assets = await _prepareLocalAssets(
        _parseAssetsFromConfig(arConfigJson),
      );
      final savedScene = _parseScene(
        questId: questId,
        sceneJson: persistedSceneJson.isEmpty
            ? (responseJson.isEmpty ? payload : responseJson)
            : persistedSceneJson,
        assets: assets,
        fallbackJson: arConfigJson,
        arcoreToken: await _fetchArcoreToken(),
      );
      await _cacheScene(savedScene);
      return savedScene;
    } on DioException catch (error) {
      throw _mapDioException(
        error,
        fallbackMessage: 'Не удалось сохранить AR-сцену',
      );
    }
  }

  @override
  Future<ArAnchorReachResultEntity> markAnchorReached({
    required int questId,
    required String anchorId,
    String? sessionId,
    String? interactionType,
    int? answerIndex,
  }) async {
    try {
      final rawSessionId = sessionId == null
          ? null
          : readInt(sessionId) ?? sessionId;
      final response = await _dio.post<dynamic>(
        '/api/quests/$questId/anchor/reached',
        data: {
          'anchor_id': anchorId,
          if (rawSessionId != null) 'session_id': rawSessionId,
          if (interactionType != null && interactionType.trim().isNotEmpty)
            'interaction_type': interactionType.trim(),
          if (answerIndex != null) 'answer_index': answerIndex,
        },
      );
      return _parseAnchorReachResult(questId, anchorId, response.data);
    } on DioException catch (error) {
      throw _mapDioException(
        error,
        fallbackMessage: 'Не удалось зафиксировать контрольную точку',
      );
    }
  }

  ArAnchorReachResultEntity _parseAnchorReachResult(
    int fallbackQuestId,
    String fallbackAnchorId,
    dynamic raw,
  ) {
    final json = asMap(raw);
    final progress = asMap(json['progress']);
    return ArAnchorReachResultEntity(
      questId:
          readInt(json['quest_id']) ??
          readInt(json['questId']) ??
          fallbackQuestId,
      anchorId:
          readString(json['anchor_id']) ??
          readString(json['anchorId']) ??
          fallbackAnchorId,
      anchorRole:
          readString(json['anchor_role']) ??
          readString(json['anchorRole']) ??
          fallbackAnchorId,
      testUnlocked:
          readBool(json['test_unlocked']) ??
          readBool(json['testUnlocked']) ??
          readBool(progress['test_unlocked']) ??
          readBool(progress['testUnlocked']) ??
          false,
      questCompleted:
          readBool(json['quest_completed']) ??
          readBool(json['questCompleted']) ??
          readBool(progress['quest_completed']) ??
          readBool(progress['questCompleted']) ??
          false,
      created: readBool(json['created']) ?? false,
      progressCompleted:
          readInt(progress['completed']) ??
          readInt(progress['completed_count']) ??
          readInt(progress['completedCount']) ??
          readInt(json['progress_completed']) ??
          readInt(json['progressCompleted']),
      progressTotal:
          readInt(progress['total']) ??
          readInt(progress['required_total']) ??
          readInt(progress['requiredTotal']) ??
          readInt(json['progress_total']) ??
          readInt(json['progressTotal']),
      requiredTestAnchorId:
          readString(json['required_test_anchor_id']) ??
          readString(json['requiredTestAnchorId']),
      finishAnchorId:
          readString(json['finish_anchor_id']) ??
          readString(json['finishAnchorId']),
      nextAction: asMap(json['next_action'] ?? json['nextAction']),
    );
  }

  Future<Map<String, dynamic>> _fetchOrganizerSceneJson(int questId) async {
    final sceneResponse = await _dio.get<dynamic>(
      '/api/mobile/organizer/quests/$questId/scene',
    );
    return asMap(sceneResponse.data);
  }

  Future<Map<String, dynamic>> _fetchParticipantLayoutJson(int questId) async {
    try {
      final layoutResponse = await _dio.get<dynamic>(
        '/api/quests/$questId/layout/latest',
      );
      return asMap(layoutResponse.data);
    } on DioException catch (error) {
      if (error.response?.statusCode == 404) {
        return const <String, dynamic>{};
      }
      rethrow;
    }
  }

  Map<String, dynamic> _sceneJsonFromLayout(
    Map<String, dynamic> layoutJson, {
    required int fallbackQuestId,
  }) {
    if (layoutJson.isEmpty) {
      return const <String, dynamic>{};
    }

    final anchorPayload = asMap(
      layoutJson['anchor_payload'] ??
          layoutJson['anchorPayload'] ??
          layoutJson['root_anchor'] ??
          layoutJson['rootAnchor'],
    );
    final rootAnchor = <String, dynamic>{
      'anchorName':
          readString(anchorPayload['anchorName']) ??
          readString(anchorPayload['anchor_name']) ??
          '',
      'cloudAnchorId':
          readString(anchorPayload['cloudAnchorId']) ??
          readString(anchorPayload['cloud_anchor_id']) ??
          '',
      'anchorTransform':
          readDoubleList(anchorPayload['transformation']) ??
          readDoubleList(anchorPayload['anchorTransform']) ??
          readDoubleList(anchorPayload['anchor_transform']) ??
          const <double>[],
      'ttl': readInt(anchorPayload['ttl']) ?? 1,
      'platform': readString(anchorPayload['platform']),
    };

    final objects = asList(layoutJson['items'])
        .whereType<Map>()
        .map((item) {
          final json = Map<String, dynamic>.from(item);
          final meta = _placementMetaFromJson(json);
          final transform = asMap(json['transform']);
          final assetId =
              readInt(json['asset_id']) ??
              readInt(json['assetId']) ??
              readInt(asMap(json['asset'])['id']) ??
              0;
          final placementId =
              readString(meta['id']) ??
              readString(json['id']) ??
              'placement_$assetId';
          final nodeName =
              readString(meta['nodeName']) ??
              readString(meta['node_name']) ??
              readString(json['nodeName']) ??
              readString(json['node_name']) ??
              placementId;
          return {
            'id': placementId,
            'assetId': assetId,
            'nodeName': nodeName,
            'localTransform':
                readDoubleList(transform['transformation']) ??
                readDoubleList(json['localTransform']) ??
                readDoubleList(json['local_transform']) ??
                const <double>[],
            'meta': meta,
          };
        })
        .toList(growable: false);

    final resolvedQuestId = readInt(layoutJson['quest_id']) ?? fallbackQuestId;
    return {
      'sceneId': 'quest_$resolvedQuestId',
      'questId': resolvedQuestId,
      'version': readInt(layoutJson['version']),
      'updatedAt': readString(layoutJson['created_at']),
      'createdBy': readInt(layoutJson['created_by_id']),
      'rootAnchor': rootAnchor,
      'objects': objects,
    };
  }

  Future<String?> _fetchArcoreToken() async {
    if (kIsWeb || !Platform.isAndroid) {
      return null;
    }

    try {
      final response = await _dio.post<dynamic>('/api/mobile/arcore/token');
      final json = asMap(response.data);
      return readString(json['token']) ??
          readString(json['access_token']) ??
          readString(json['arcore_token']);
    } on DioException catch (error) {
      if (error.response?.statusCode == 503) {
        throw const ApiException(
          message:
              'Не удалось подключить облачную AR-сцену. Проверьте, что телефон находится в корректной сети, и попробуйте ещё раз.',
          statusCode: 503,
        );
      }
      return null;
    }
  }

  ArQuestSceneEntity _parseScene({
    required int questId,
    required Map<String, dynamic> sceneJson,
    required List<ArAssetEntity> assets,
    required Map<String, dynamic> fallbackJson,
    String? arcoreToken,
  }) {
    final scene = sceneJson.isEmpty ? fallbackJson : sceneJson;
    final rootAnchorJson = asMap(scene['rootAnchor'] ?? scene['root_anchor']);
    final rootAnchor = rootAnchorJson.isEmpty
        ? null
        : ArSceneRootAnchorEntity(
            anchorName:
                readString(rootAnchorJson['anchorName']) ??
                readString(rootAnchorJson['anchor_name']) ??
                '',
            cloudAnchorId:
                readString(rootAnchorJson['cloudAnchorId']) ??
                readString(rootAnchorJson['cloud_anchor_id']) ??
                '',
            anchorTransform:
                readDoubleList(rootAnchorJson['anchorTransform']) ??
                readDoubleList(rootAnchorJson['anchor_transform']) ??
                readDoubleList(rootAnchorJson['transformation']) ??
                const [],
            ttl: readInt(rootAnchorJson['ttl']) ?? 1,
            platform: readString(rootAnchorJson['platform']),
          );

    final objects = asList(scene['objects'] ?? scene['items'])
        .whereType<Map>()
        .map((item) {
          final json = Map<String, dynamic>.from(item);
          final meta = _placementMetaFromJson(json);
          final transform = asMap(json['transform']);
          final assetId =
              readInt(json['assetId']) ??
              readInt(json['asset_id']) ??
              readInt(asMap(json['asset'])['id']) ??
              0;
          final placementId =
              readString(json['id']) ??
              readString(meta['id']) ??
              'placement_$assetId';
          return ArAssetPlacementEntity(
            id: placementId,
            assetId: assetId,
            nodeName:
                readString(json['nodeName']) ??
                readString(json['node_name']) ??
                readString(meta['nodeName']) ??
                readString(meta['node_name']) ??
                placementId,
            localTransform:
                readDoubleList(json['localTransform']) ??
                readDoubleList(json['local_transform']) ??
                readDoubleList(transform['transformation']) ??
                const [],
            meta: meta,
          );
        })
        .toList(growable: false);

    final questJson = asMap(fallbackJson['quest']);
    return ArQuestSceneEntity(
      sceneId: readString(scene['sceneId']) ?? 'quest_$questId',
      questId: readInt(scene['questId']) ?? questId,
      eventId:
          readInt(scene['eventId']) ??
          readInt(fallbackJson['eventId']) ??
          readInt(questJson['event_id']) ??
          0,
      title:
          readString(scene['title']) ??
          readString(questJson['title']) ??
          'AR-сцена квеста',
      version: readInt(scene['version']),
      updatedAt: readString(scene['updatedAt']),
      createdBy: readInt(scene['createdBy']),
      isPublished:
          readBool(scene['isPublished']) ??
          readBool(scene['is_published']) ??
          readBool(questJson['is_active']) ??
          false,
      hasTest:
          readBool(scene['hasTest']) ??
          readBool(scene['has_test']) ??
          (asMap(questJson['knowledge_test']).isNotEmpty ||
              readBool(asMap(questJson['composition'])['test']) == true),
      assets: assets,
      objects: objects,
      rootAnchor: rootAnchor,
      arcoreToken: arcoreToken,
    );
  }

  List<ArAssetEntity> _parseAssetsFromConfig(
    Map<String, dynamic> json, {
    Map<String, dynamic>? layoutJson,
  }) {
    final rawAssets = <dynamic>[
      json['assets'],
      json['ar_assets'],
      json['arAssets'],
      json['quest_assets'],
      json['questAssets'],
      json['materials'],
      json['digital_materials'],
      json['digitalMaterials'],
      asMap(json['quest'])['assets'],
      asMap(json['quest'])['ar_assets'],
      asMap(json['quest'])['arAssets'],
      asMap(json['quest'])['materials'],
      asMap(json['quest'])['digital_materials'],
      asMap(json['quest'])['digitalMaterials'],
      asMap(json['scene'])['assets'],
      asMap(json['scene'])['ar_assets'],
      asMap(json['scene'])['arAssets'],
      asMap(json['layout'])['assets'],
      asMap(json['latest_layout'] ?? json['latestLayout'])['assets'],
      asMap(json['ar_config'] ?? json['arConfig'])['assets'],
      asMap(json['bundle'])['assets'],
      if (layoutJson != null) layoutJson['assets'],
    ];

    for (final item in asList(layoutJson?['items'])) {
      final map = asMap(item);
      if (map.isNotEmpty) {
        rawAssets.add(map['asset']);
      }
    }
    for (final item in asList(json['items'])) {
      final map = asMap(item);
      if (map.isNotEmpty) {
        rawAssets.add(map['asset']);
      }
    }
    for (final item in asList(asMap(json['layout'])['items'])) {
      final map = asMap(item);
      if (map.isNotEmpty) {
        rawAssets.add(map['asset']);
      }
    }
    for (final item in asList(asMap(json['scene'])['objects'])) {
      final map = asMap(item);
      if (map.isNotEmpty) {
        rawAssets.add(map['asset']);
      }
    }

    final deduped = <String, ArAssetEntity>{};
    for (final rawAsset in rawAssets) {
      final parsed = _parseAssets(rawAsset);
      for (final asset in parsed) {
        final key = asset.id == 0
            ? 'uri:${asset.modelUri}'
            : 'id:${asset.id}:${asset.modelUri}';
        deduped[key] = asset;
      }
    }
    return deduped.values.toList(growable: false);
  }

  List<ArAssetEntity> _parseAssets(dynamic rawAssets) {
    final assets = rawAssets is Map ? [rawAssets] : asList(rawAssets);
    return assets
        .asMap()
        .entries
        .map<ArAssetEntity?>((entry) {
          final index = entry.key;
          final json = asMap(entry.value);
          if (json.isEmpty) {
            return null;
          }
          final meta = asMap(json['meta']);
          final fileJson = asMap(json['file'] ?? json['storage']);
          final rawModelUri = _bestModelUri(json, fileJson);
          final modelUri = rawModelUri.trim();
          if (!_isModelAsset(json, modelUri)) {
            return null;
          }

          final previewIcon = switch (index % 3) {
            0 => ArAssetPreviewIcon.cube,
            1 => ArAssetPreviewIcon.globe,
            _ => ArAssetPreviewIcon.rocket,
          };

          final displayName = _assetDisplayName(json, meta, index);
          return ArAssetEntity(
            id: readInt(json['id']) ?? 0,
            name: displayName,
            modelUri: modelUri,
            scale:
                readDouble(json['scale']) ??
                readDouble(json['default_scale']) ??
                1,
            previewIcon: previewIcon,
            previewUrl:
                readString(json['preview_url']) ??
                readString(json['thumbnail_url']) ??
                readString(json['image_url']) ??
                readString(json['cover_url']) ??
                readString(meta['preview_url']) ??
                readString(meta['thumbnail_url']),
          );
        })
        .whereType<ArAssetEntity>()
        .where((asset) => asset.modelUri.isNotEmpty)
        .toList(growable: false);
  }

  String _assetDisplayName(
    Map<String, dynamic> json,
    Map<String, dynamic> meta,
    int index,
  ) {
    for (final value in [
      json['title'],
      json['display_name'],
      json['displayName'],
      json['label'],
      meta['title'],
      meta['display_name'],
      meta['displayName'],
      meta['name'],
      meta['label'],
      json['name'],
    ]) {
      final name = readString(value)?.trim();
      if (name != null && name.isNotEmpty && !_looksLikeModelFilename(name)) {
        return name;
      }
    }
    return 'Модель ${index + 1}';
  }

  bool _looksLikeModelFilename(String value) {
    final normalized = value.trim().toLowerCase();
    return normalized.endsWith('.glb') ||
        normalized.endsWith('.gltf') ||
        normalized.contains('.glb?') ||
        normalized.contains('.gltf?') ||
        normalized.startsWith('ar_asset_');
  }

  bool _isModelAsset(Map<String, dynamic> json, String modelUri) {
    final type =
        (readString(json['type']) ?? readString(json['asset_type']) ?? '')
            .toLowerCase();
    if (type.isNotEmpty) {
      return type == 'model';
    }

    final normalized = modelUri.trim().toLowerCase();
    return normalized.endsWith('.glb') ||
        normalized.endsWith('.gltf') ||
        normalized.contains('.glb?') ||
        normalized.contains('.gltf?');
  }

  Map<String, dynamic> _placementMetaFromJson(Map<String, dynamic> json) {
    final meta = {...asMap(json['meta'])};
    for (final key in const [
      'role',
      'anchor_role',
      'anchorRole',
      'interaction_type',
      'interactionType',
      'type',
      'title',
      'description',
      'text',
      'body',
      'hint',
      'question',
      'options',
      'correct_index',
      'correctIndex',
      'correct_answer',
      'correctAnswer',
      'action_type',
      'actionType',
      'scale',
      'isTestAnchor',
      'is_test_anchor',
      'isFinishAnchor',
      'is_finish_anchor',
    ]) {
      if (!meta.containsKey(key) && json.containsKey(key)) {
        meta[key] = json[key];
      }
    }

    for (final key in const [
      'action',
      'interaction',
      'interactive',
      'payload',
    ]) {
      final payload = asMap(json[key]);
      if (!meta.containsKey(key) && payload.isNotEmpty) {
        meta[key] = payload;
      }
    }

    return meta;
  }

  String _bestModelUri(
    Map<String, dynamic> json,
    Map<String, dynamic> fileJson,
  ) {
    final downloadableUri = _firstDownloadableModelUri([
      json['model_url'],
      json['modelUrl'],
      json['glb_url'],
      json['glbUrl'],
      json['file_url'],
      json['fileUrl'],
      fileJson['url'],
      fileJson['download_url'],
      fileJson['downloadUrl'],
      json['storage_url'],
      json['storageUrl'],
      json['download_url'],
      json['downloadUrl'],
      json['url'],
    ]);
    final modelUri =
        readString(json['modelUri']) ?? readString(json['model_uri']);
    if (downloadableUri != null) {
      return downloadableUri;
    }
    if (modelUri != null && !_isLocalModelUri(modelUri)) {
      return modelUri.trim();
    }
    return modelUri?.trim() ?? '';
  }

  String? _firstDownloadableModelUri(Iterable<dynamic> values) {
    for (final value in values) {
      final uri = readString(value)?.trim();
      if (uri != null && uri.isNotEmpty && !_isLocalModelUri(uri)) {
        return uri;
      }
    }
    return null;
  }

  Future<List<ArAssetEntity>> _prepareLocalAssets(
    List<ArAssetEntity> assets,
  ) async {
    if (assets.isEmpty || kIsWeb) {
      return assets;
    }

    final localAssets = <ArAssetEntity>[];
    for (final asset in assets) {
      final localModelUri = await _ensureLocalGlb(asset);
      localAssets.add(asset.copyWith(modelUri: localModelUri));
    }
    return localAssets;
  }

  Future<String> _ensureLocalGlb(ArAssetEntity asset) async {
    if (_isLocalModelUri(asset.modelUri)) {
      final file = await _localModelFile(asset.modelUri);
      if (await _isValidGlbFile(file)) {
        final wasSanitized = await _makeGlbSceneKitCompatible(file);
        if (!await _isValidGlbFile(file)) {
          await _deleteIfExists(file);
          throw ApiException(
            message:
                'Локальная AR-модель "${asset.name}" повреждена. Откройте сцену при доступном интернете, чтобы скачать её заново.',
            code: 'ar_invalid_cached_model',
          );
        }
        await _debugLogLocalGlb(
          asset,
          file,
          source: 'local',
          wasSanitized: wasSanitized,
        );
        return _localModelUriForPlatform(file);
      }
      await _deleteIfExists(file);
      throw ApiException(
        message:
            'Локальная AR-модель "${asset.name}" повреждена. Откройте сцену при доступном интернете, чтобы скачать её заново.',
        code: 'ar_invalid_cached_model',
      );
    }

    final filename = _localAssetFilename(asset);
    final file = await _localModelFile(filename);
    if (await file.exists()) {
      if (await _isValidGlbFile(file)) {
        final wasSanitized = await _makeGlbSceneKitCompatible(file);
        if (!await _isValidGlbFile(file)) {
          await _deleteIfExists(file);
          throw ApiException(
            message:
                'Локальная AR-модель "${asset.name}" повреждена. Откройте сцену при доступном интернете, чтобы скачать её заново.',
            code: 'ar_invalid_cached_model',
          );
        }
        await _debugLogLocalGlb(
          asset,
          file,
          source: 'cache',
          wasSanitized: wasSanitized,
        );
        return _localModelUriForPlatform(file);
      }
      await _deleteIfExists(file);
    }

    final tempFile = File('${file.path}.download');
    await _deleteIfExists(tempFile);

    try {
      await _dio.download(
        asset.modelUri,
        tempFile.path,
        options: Options(
          responseType: ResponseType.bytes,
          extra: const {'arAssetDownload': true},
        ),
      );
    } on DioException catch (error) {
      await _deleteIfExists(tempFile);
      throw ApiException(
        message: 'Не удалось скачать AR-модель "${asset.name}"',
        code: 'ar_asset_download_failed',
        statusCode: error.response?.statusCode,
      );
    }

    if (!await _isValidGlbFile(tempFile)) {
      await _deleteIfExists(tempFile);
      throw ApiException(
        message:
            'AR-модель "${asset.name}" не является корректным GLB-файлом. Проверьте ассет в админке и загрузите файл формата .glb.',
        code: 'ar_invalid_glb',
      );
    }
    final wasSanitized = await _makeGlbSceneKitCompatible(tempFile);
    if (!await _isValidGlbFile(tempFile)) {
      await _deleteIfExists(tempFile);
      throw ApiException(
        message:
            'AR-модель "${asset.name}" была повреждена при подготовке для iOS. Проверьте GLB-файл в админке.',
        code: 'ar_invalid_prepared_glb',
      );
    }

    await tempFile.rename(file.path);
    await _debugLogLocalGlb(
      asset,
      file,
      source: 'download',
      wasSanitized: wasSanitized,
    );
    return _localModelUriForPlatform(file);
  }

  Future<File> _localModelFile(String filenameOrPath) async {
    if (filenameOrPath.startsWith('/')) {
      return File(filenameOrPath);
    }

    final documentsDirectory = await getApplicationDocumentsDirectory();
    return File('${documentsDirectory.path}/$filenameOrPath');
  }

  String _localModelUriForPlatform(File file) {
    if (Platform.isAndroid) {
      return file.path;
    }
    return file.uri.pathSegments.last;
  }

  Future<bool> _isValidGlbFile(File file) async {
    if (!await file.exists()) {
      return false;
    }

    final length = await file.length();
    if (length < 12) {
      return false;
    }

    final randomAccessFile = await file.open();
    try {
      final header = await randomAccessFile.read(12);
      if (header.length < 12) {
        return false;
      }

      final hasMagic =
          header[0] == 0x67 &&
          header[1] == 0x6C &&
          header[2] == 0x54 &&
          header[3] == 0x46;
      final version = _readUint32LittleEndian(header, 4);
      final declaredLength = _readUint32LittleEndian(header, 8);

      return hasMagic && version == 2 && declaredLength == length;
    } finally {
      await randomAccessFile.close();
    }
  }

  Future<bool> _makeGlbSceneKitCompatible(File file) async {
    if (!Platform.isIOS) {
      return false;
    }

    final sanitized = _sanitizeGlbForSceneKit(await file.readAsBytes());
    if (sanitized == null) {
      return false;
    }

    await file.writeAsBytes(sanitized, flush: true);
    return true;
  }

  Future<void> _debugLogLocalGlb(
    ArAssetEntity asset,
    File file, {
    required String source,
    required bool wasSanitized,
  }) async {
    if (!kDebugMode) {
      return;
    }

    final fileName = file.uri.pathSegments.last;
    final length = await file.length();
    debugPrint(
      'AR GLB ready [$source]: '
      '${asset.name} (#${asset.id}) -> $fileName, '
      'path=${file.path}, bytes=$length, iOSSanitized=$wasSanitized',
    );
  }

  Uint8List? _sanitizeGlbForSceneKit(Uint8List bytes) {
    const jsonChunkType = 0x4E4F534A;
    if (bytes.length < 20) {
      return null;
    }

    final magic = String.fromCharCodes(bytes.sublist(0, 4));
    final version = _readUint32LittleEndian(bytes, 4);
    if (magic != 'glTF' || version != 2) {
      return null;
    }

    final jsonLength = _readUint32LittleEndian(bytes, 12);
    final chunkType = _readUint32LittleEndian(bytes, 16);
    final jsonStart = 20;
    final jsonEnd = jsonStart + jsonLength;
    if (chunkType != jsonChunkType || jsonEnd > bytes.length) {
      return null;
    }

    final gltf = Map<String, dynamic>.from(
      jsonDecode(utf8.decode(bytes.sublist(jsonStart, jsonEnd)).trimRight())
          as Map,
    );
    var changed = false;
    for (final mesh in asList(gltf['meshes'])) {
      final meshJson = asMap(mesh);
      for (final primitive in asList(meshJson['primitives'])) {
        final primitiveJson = asMap(primitive);
        final attributes = primitiveJson['attributes'];
        if (attributes is! Map) {
          continue;
        }

        final colorAttributeKeys = attributes.keys
            .where((key) => key.toString().startsWith('COLOR_'))
            .toList(growable: false);
        if (colorAttributeKeys.isEmpty) {
          continue;
        }

        for (final key in colorAttributeKeys) {
          attributes.remove(key);
        }
        changed = true;
      }
    }

    if (!changed) {
      return null;
    }

    final jsonBytes = Uint8List.fromList(utf8.encode(jsonEncode(gltf)));
    final paddedJsonLength = _paddedLength(jsonBytes.length);
    final paddedJson = Uint8List(paddedJsonLength)..setAll(0, jsonBytes);
    for (var index = jsonBytes.length; index < paddedJson.length; index++) {
      paddedJson[index] = 0x20;
    }

    final remainingChunks = bytes.sublist(jsonEnd);
    final totalLength = 12 + 8 + paddedJson.length + remainingChunks.length;
    final output = BytesBuilder(copy: false)
      ..add(_glbHeader(totalLength))
      ..add(_uint32LittleEndian(paddedJson.length))
      ..add(_uint32LittleEndian(jsonChunkType))
      ..add(paddedJson)
      ..add(remainingChunks);

    return output.toBytes();
  }

  int _paddedLength(int length) {
    return (length + 3) & ~3;
  }

  Uint8List _glbHeader(int length) {
    final header = Uint8List(12);
    header.setAll(0, utf8.encode('glTF'));
    header.setAll(4, _uint32LittleEndian(2));
    header.setAll(8, _uint32LittleEndian(length));
    return header;
  }

  Uint8List _uint32LittleEndian(int value) {
    return Uint8List(4)
      ..[0] = value & 0xff
      ..[1] = (value >> 8) & 0xff
      ..[2] = (value >> 16) & 0xff
      ..[3] = (value >> 24) & 0xff;
  }

  int _readUint32LittleEndian(List<int> bytes, int offset) {
    return bytes[offset] |
        (bytes[offset + 1] << 8) |
        (bytes[offset + 2] << 16) |
        (bytes[offset + 3] << 24);
  }

  Future<void> _deleteIfExists(File file) async {
    if (await file.exists()) {
      await file.delete();
    }
  }

  bool _isLocalModelUri(String uri) {
    final normalized = uri.trim().toLowerCase();
    final isAppFolderFilename =
        normalized.startsWith('ar_asset_') &&
        normalized.endsWith('.glb') &&
        !normalized.contains('/');
    final isAbsoluteFilePath =
        normalized.startsWith('/') && normalized.endsWith('.glb');

    return isAppFolderFilename || isAbsoluteFilePath;
  }

  String _localAssetFilename(ArAssetEntity asset) {
    final hash = _stableHash(asset.modelUri);
    final platformSuffix = Platform.isIOS
        ? '_$_iosGlbCacheVersion'
        : '_$_glbCacheVersion';
    return 'ar_asset_${asset.id}_$hash$platformSuffix.glb';
  }

  String _stableHash(String value) {
    var hash = 0x811c9dc5;
    for (final codeUnit in value.codeUnits) {
      hash ^= codeUnit;
      hash = (hash * 0x01000193) & 0xffffffff;
    }
    return hash.toRadixString(16).padLeft(8, '0');
  }

  Future<void> _cacheScene(ArQuestSceneEntity scene) async {
    final payload = {
      'sceneId': scene.sceneId,
      'questId': scene.questId,
      'eventId': scene.eventId,
      'title': scene.title,
      'version': scene.version,
      'updatedAt': scene.updatedAt,
      'createdBy': scene.createdBy,
      'isPublished': scene.isPublished,
      'hasTest': scene.hasTest,
      'arcoreToken': scene.arcoreToken,
      'rootAnchor': scene.rootAnchor?.toJson(),
      'assets': scene.assets
          .map(
            (asset) => {
              'id': asset.id,
              'name': asset.name,
              'modelUri': asset.modelUri,
              'scale': asset.scale,
              'previewIcon': asset.previewIcon.name,
              'previewUrl': asset.previewUrl,
            },
          )
          .toList(growable: false),
      'objects': scene.objects
          .map((object) => object.toJson())
          .toList(growable: false),
    };
    await _sharedPreferences.setString(
      '$_sceneCachePrefix${scene.questId}',
      jsonEncode(payload),
    );
  }

  Future<ArQuestSceneEntity?> _readCachedScene(int questId) async {
    final raw = _sharedPreferences.getString('$_sceneCachePrefix$questId');
    if (raw == null || raw.isEmpty) {
      return null;
    }

    try {
      final json = Map<String, dynamic>.from(jsonDecode(raw) as Map);
      final assets = asList(json['assets'])
          .map((item) {
            final map = Map<String, dynamic>.from(item as Map);
            final previewIcon = ArAssetPreviewIcon.values.byName(
              readString(map['previewIcon']) ?? ArAssetPreviewIcon.cube.name,
            );
            return ArAssetEntity(
              id: readInt(map['id']) ?? 0,
              name: readString(map['name']) ?? '',
              modelUri: readString(map['modelUri']) ?? '',
              scale: readDouble(map['scale']) ?? 1,
              previewIcon: previewIcon,
              previewUrl: readString(map['previewUrl']),
            );
          })
          .toList(growable: false);
      for (final asset in assets) {
        if (!_isLocalModelUri(asset.modelUri)) {
          continue;
        }

        final file = await _localModelFile(asset.modelUri);
        if (!await _isValidGlbFile(file)) {
          await _deleteIfExists(file);
          return null;
        }
        await _makeGlbSceneKitCompatible(file);
      }

      return _parseScene(
        questId: questId,
        sceneJson: json,
        assets: assets,
        fallbackJson: json,
        arcoreToken: readString(json['arcoreToken']),
      );
    } catch (_) {
      return null;
    }
  }

  ApiException _mapDioException(
    DioException error, {
    required String fallbackMessage,
  }) {
    final json = asMap(error.response?.data);
    final code = readString(json['code']);
    if (code == 'scene_version_conflict') {
      return const ApiException(
        message: 'На сервере уже есть более новая версия сцены.',
        code: 'scene_version_conflict',
        statusCode: 409,
      );
    }
    if (code == 'scene_invalid_assets' || code == 'layout_invalid_assets') {
      return ApiException(
        message:
            'Сцена содержит ассеты, которые не принадлежат выбранному квесту.',
        code: code,
        statusCode: error.response?.statusCode,
      );
    }
    if (code == 'anchor_not_found') {
      return ApiException(
        message: 'Контрольная точка не найдена в актуальной AR-сцене.',
        code: code,
        statusCode: error.response?.statusCode,
      );
    }
    if (code == 'anchor_session_invalid') {
      return ApiException(
        message: 'Сессия квеста истекла. Откройте квест по QR-коду ещё раз.',
        code: code,
        statusCode: error.response?.statusCode,
      );
    }
    if (code == 'test_locked_by_anchor') {
      return ApiException(
        message:
            'Тест станет доступен после прохождения контрольной точки в AR-сцене.',
        code: code,
        statusCode: error.response?.statusCode,
      );
    }
    if (code == 'test_anchor_not_configured') {
      return ApiException(
        message: 'Квест настроен некорректно. Обратитесь к организатору.',
        code: code,
        statusCode: error.response?.statusCode,
      );
    }
    if (code == 'interactive_answer_invalid') {
      return ApiException(
        message: 'Ответ неверный. Попробуйте ещё раз.',
        code: code,
        statusCode: error.response?.statusCode,
      );
    }

    return ApiException(
      message:
          readString(json['detail']) ??
          readString(json['message']) ??
          fallbackMessage,
      code: code,
      statusCode: error.response?.statusCode,
    );
  }
}
