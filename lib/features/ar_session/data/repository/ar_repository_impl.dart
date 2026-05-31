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

  static const _sceneCachePrefix = 'ar_scene_cache_v4_';
  static const _iosGlbCacheVersion = 'ios_v2';

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
          _parseAssets(
            arConfigJson['assets'] ??
                asMap(arConfigJson['quest'])['assets'] ??
                asMap(arConfigJson['scene'])['assets'],
          ),
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
      final assets = await _prepareLocalAssets(
        _parseAssets(bundleJson['assets']),
      );
      final scene = _parseScene(
        questId: questId,
        sceneJson: layoutJson.isNotEmpty
            ? _sceneJsonFromLayout(layoutJson, fallbackQuestId: questId)
            : asMap(bundleJson['scene']).isNotEmpty
            ? asMap(bundleJson['scene'])
            : asMap(bundleJson['layout']),
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

  @override
  Future<ArAnchorReachResultEntity> markAnchorReached({
    required int questId,
    required String anchorId,
    String? sessionId,
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
          false,
      questCompleted:
          readBool(json['quest_completed']) ??
          readBool(json['questCompleted']) ??
          false,
      created: readBool(json['created']) ?? false,
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

    final anchorPayload = asMap(layoutJson['anchor_payload']);
    final rootAnchor = <String, dynamic>{
      'anchorName': readString(anchorPayload['anchorName']) ?? '',
      'cloudAnchorId': readString(anchorPayload['cloudAnchorId']) ?? '',
      'anchorTransform':
          readDoubleList(anchorPayload['transformation']) ??
          readDoubleList(anchorPayload['anchorTransform']) ??
          const <double>[],
      'ttl': readInt(anchorPayload['ttl']) ?? 1,
      'platform': readString(anchorPayload['platform']),
    };

    final objects = asList(layoutJson['items'])
        .map((item) {
          final json = Map<String, dynamic>.from(item as Map);
          final meta = asMap(json['meta']);
          final transform = asMap(json['transform']);
          return {
            'id':
                readString(meta['id']) ??
                readString(json['id']) ??
                'placement_${readInt(json['asset_id']) ?? 0}',
            'assetId':
                readInt(json['asset_id']) ??
                readInt(json['assetId']) ??
                readInt(asMap(json['asset'])['id']) ??
                0,
            'nodeName':
                readString(meta['nodeName']) ??
                readString(meta['node_name']) ??
                readString(json['nodeName']) ??
                '',
            'localTransform':
                readDoubleList(transform['transformation']) ??
                readDoubleList(json['localTransform']) ??
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
            meta: asMap(json['meta']),
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

  List<ArAssetEntity> _parseAssets(dynamic rawAssets) {
    final assets = asList(rawAssets);
    return assets
        .asMap()
        .entries
        .map<ArAssetEntity?>((entry) {
          final index = entry.key;
          final json = Map<String, dynamic>.from(entry.value as Map);
          final meta = asMap(json['meta']);
          final rawModelUri =
              readString(json['model_url']) ??
              readString(json['modelUri']) ??
              readString(json['glb_url']) ??
              readString(json['file_url']) ??
              readString(json['storage_url']) ??
              readString(json['storageUrl']) ??
              readString(json['url']) ??
              '';
          final modelUri = rawModelUri.trim();
          if (!_isModelAsset(json, modelUri)) {
            return null;
          }

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
    final platformSuffix = Platform.isIOS ? '_$_iosGlbCacheVersion' : '';
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
