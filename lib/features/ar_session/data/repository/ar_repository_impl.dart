import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vroom/core/network/api_exception.dart';
import 'package:vroom/core/network/json_utils.dart';
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

  static const _sceneCachePrefix = 'ar_scene_cache_v4_';

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
        final sceneJson = await _fetchOrganizerSceneJson(questId);
        final arcoreToken = await _fetchArcoreToken();

        final arConfigJson = asMap(arConfigResponse.data);
        final assets = await _prepareLocalAssets(
          _parseAssets(
            arConfigJson['assets'] ??
                asMap(arConfigJson['quest'])['assets'] ??
                asMap(arConfigJson['scene'])['assets'],
          ),
        );

        final scene = _parseScene(
          questId: questId,
          sceneJson: sceneJson.isEmpty
              ? asMap(arConfigJson['scene'])
              : sceneJson,
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
      final assets = await _prepareLocalAssets(
        _parseAssets(bundleJson['assets']),
      );
      final scene = _parseScene(
        questId: questId,
        sceneJson: asMap(bundleJson['scene']).isNotEmpty
            ? asMap(bundleJson['scene'])
            : asMap(bundleJson['layout']),
        assets: assets,
        fallbackJson: bundleJson,
      );
      await _cacheScene(scene);
      return scene;
    } on DioException catch (error) {
      final cached = _readCachedScene(questId);
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
      final payload = {
        'sceneId': 'quest_$questId',
        'questId': questId,
        if (latestVersion != null) 'version': latestVersion,
        'rootAnchor': rootAnchor?.toJson(),
        'objects': objects
            .map(
              (object) => {
                'id': object.id,
                'assetId': object.assetId,
                'nodeName': object.nodeName,
                'localTransform': object.localTransform,
              },
            )
            .toList(growable: false),
      };

      final response = await _dio.post<dynamic>(
        '/api/mobile/organizer/quests/$questId/scene',
        data: payload,
      );
      final responseJson = asMap(response.data);
      final arConfigResponse = await _dio.get<dynamic>(
        '/api/mobile/organizer/quests/$questId/ar-config',
      );
      final persistedSceneJson = await _fetchOrganizerSceneJson(questId);
      final arConfigJson = asMap(arConfigResponse.data);
      final assets = await _prepareLocalAssets(
        _parseAssets(
          arConfigJson['assets'] ?? asMap(arConfigJson['quest'])['assets'],
        ),
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

  Future<Map<String, dynamic>> _fetchOrganizerSceneJson(int questId) async {
    final sceneResponse = await _dio.get<dynamic>(
      '/api/mobile/organizer/quests/$questId/scene',
    );
    return asMap(sceneResponse.data);
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
    } on DioException {
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
    final rootAnchorJson = asMap(scene['rootAnchor']);
    final rootAnchor = rootAnchorJson.isEmpty
        ? null
        : ArSceneRootAnchorEntity(
            anchorName: readString(rootAnchorJson['anchorName']) ?? '',
            cloudAnchorId: readString(rootAnchorJson['cloudAnchorId']) ?? '',
            anchorTransform:
                readDoubleList(rootAnchorJson['anchorTransform']) ?? const [],
            ttl: readInt(rootAnchorJson['ttl']) ?? 1,
            platform: readString(rootAnchorJson['platform']),
          );

    final objects = asList(scene['objects'])
        .map((item) {
          final json = Map<String, dynamic>.from(item as Map);
          return ArAssetPlacementEntity(
            id: readString(json['id']) ?? '',
            assetId: readInt(json['assetId']) ?? 0,
            nodeName: readString(json['nodeName']) ?? '',
            localTransform: readDoubleList(json['localTransform']) ?? const [],
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
          false,
      assets: assets,
      objects: objects,
      rootAnchor: rootAnchor,
      arcoreToken: arcoreToken,
    );
  }

  List<ArAssetEntity> _parseAssets(dynamic rawAssets) {
    final assets = asList(rawAssets);
    return assets
        .asMap()
        .entries
        .map((entry) {
          final index = entry.key;
          final json = Map<String, dynamic>.from(entry.value as Map);
          final previewIcon = switch (index % 3) {
            0 => ArAssetPreviewIcon.cube,
            1 => ArAssetPreviewIcon.globe,
            _ => ArAssetPreviewIcon.rocket,
          };

          return ArAssetEntity(
            id: readInt(json['id']) ?? 0,
            name:
                readString(json['title']) ??
                readString(json['name']) ??
                'Asset #${index + 1}',
            modelUri:
                readString(json['model_url']) ??
                readString(json['modelUri']) ??
                readString(json['glb_url']) ??
                readString(json['file_url']) ??
                readString(json['storage_url']) ??
                readString(json['storageUrl']) ??
                readString(json['url']) ??
                '',
            scale:
                readDouble(json['scale']) ??
                readDouble(json['default_scale']) ??
                1,
            previewIcon: previewIcon,
          );
        })
        .where((asset) => asset.modelUri.isNotEmpty)
        .toList(growable: false);
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
      return asset.modelUri;
    }

    final documentsDirectory = await getApplicationDocumentsDirectory();
    final filename = _localAssetFilename(asset);
    final file = File('${documentsDirectory.path}/$filename');
    final existingLength = await file.exists() ? await file.length() : 0;
    if (existingLength > 0) {
      return filename;
    }

    await _dio.download(
      asset.modelUri,
      file.path,
      options: Options(
        responseType: ResponseType.bytes,
        extra: const {'arAssetDownload': true},
      ),
    );

    return filename;
  }

  bool _isLocalModelUri(String uri) {
    final normalized = uri.trim().toLowerCase();
    return normalized.startsWith('ar_asset_') &&
        normalized.endsWith('.glb') &&
        !normalized.contains('/');
  }

  String _localAssetFilename(ArAssetEntity asset) {
    final hash = _stableHash(asset.modelUri);
    return 'ar_asset_${asset.id}_$hash.glb';
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

  ArQuestSceneEntity? _readCachedScene(int questId) {
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
            );
          })
          .toList(growable: false);
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
