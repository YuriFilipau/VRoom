import 'dart:convert';
import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_placement_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_event_scene_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_session_mode.dart';
import 'package:vroom/features/ar_session/domain/repository/ar_repository.dart';

class ArRepositoryImpl implements ArRepository {
  ArRepositoryImpl({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  static const _sceneKeyPrefix = 'ar_persistent_scene_v3_';

  @override
  Future<ArEventSceneEntity> loadEventScene({
    required String eventCode,
    required ArSessionMode mode,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));

    final assets = [
      const ArAssetEntity(
        id: 'duck',
        name: 'Duck',
        modelUri:
            'https://github.com/KhronosGroup/glTF-Sample-Models/raw/main/2.0/Duck/glTF-Binary/Duck.glb',
        scale: 0.25,
        previewIcon: ArAssetPreviewIcon.cube,
      ),
      const ArAssetEntity(
        id: 'helmet',
        name: 'Helmet',
        modelUri:
            'https://github.com/KhronosGroup/glTF-Sample-Models/raw/main/2.0/DamagedHelmet/glTF-Binary/DamagedHelmet.glb',
        scale: 0.55,
        previewIcon: ArAssetPreviewIcon.globe,
      ),
      const ArAssetEntity(
        id: 'boombox',
        name: 'BoomBox',
        modelUri:
            'https://github.com/KhronosGroup/glTF-Sample-Models/raw/main/2.0/BoomBox/glTF-Binary/BoomBox.glb',
        scale: 0.60,
        previewIcon: ArAssetPreviewIcon.rocket,
      ),
    ];

    final scenePayload = _readScenePayload(eventCode);
    final placements = _readPlacements(scenePayload);

    return ArEventSceneEntity(
      eventCode: eventCode,
      title: 'AR-сцена: $eventCode',
      assets: assets,
      placements: placements,
      sceneAnchorName: scenePayload['sceneAnchorName'] as String?,
      sceneCloudAnchorId: scenePayload['sceneCloudAnchorId'] as String?,
      sceneAnchorTransform:
          (scenePayload['sceneAnchorTransform'] as List<dynamic>?)
              ?.map((value) => (value as num).toDouble())
              .toList(),
      sceneAnchorTtl: scenePayload['sceneAnchorTtl'] as int?,
    );
  }

  @override
  Future<void> saveEventScene({
    required String eventCode,
    required String? sceneAnchorName,
    required String? sceneCloudAnchorId,
    required List<double>? sceneAnchorTransform,
    required int? sceneAnchorTtl,
    required List<ArAssetPlacementEntity> placements,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final payload = {
      'sceneAnchorName': sceneAnchorName,
      'sceneCloudAnchorId': sceneCloudAnchorId,
      'sceneAnchorTransform': sceneAnchorTransform,
      'sceneAnchorTtl': sceneAnchorTtl,
      'placements': placements.map((placement) => placement.toJson()).toList(),
    };
    await _sharedPreferences.setString(
      '$_sceneKeyPrefix$eventCode',
      jsonEncode(payload),
    );

    developer.log(
      'AR persistent scene save',
      name: 'ArRepository',
      error: {
        'eventCode': eventCode,
        'sceneAnchorName': sceneAnchorName,
        'sceneCloudAnchorId': sceneCloudAnchorId,
        'sceneAnchorTransform': sceneAnchorTransform,
        'sceneAnchorTtl': sceneAnchorTtl,
        'placements': placements
            .map((placement) => placement.toJson())
            .toList(),
      },
    );
  }

  List<ArAssetPlacementEntity> _clonePlacements(
    List<ArAssetPlacementEntity> placements,
  ) {
    return placements
        .map(
          (placement) => placement.copyWith(
            transform: List<double>.from(placement.transform),
            anchorTransform: placement.anchorTransform == null
                ? null
                : List<double>.from(placement.anchorTransform!),
          ),
        )
        .toList();
  }

  Map<String, dynamic> _readScenePayload(String eventCode) {
    final raw = _sharedPreferences.getString('$_sceneKeyPrefix$eventCode');
    if (raw == null || raw.isEmpty) {
      return const {};
    }

    try {
      return Map<String, dynamic>.from(jsonDecode(raw) as Map);
    } catch (_) {
      return const {};
    }
  }

  List<ArAssetPlacementEntity> _readPlacements(Map<String, dynamic> payload) {
    try {
      final decoded = payload['placements'] as List<dynamic>? ?? const [];
      final placements = decoded
          .map(
            (item) => ArAssetPlacementEntity.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList();
      return _clonePlacements(placements);
    } catch (_) {
      return const [];
    }
  }
}
