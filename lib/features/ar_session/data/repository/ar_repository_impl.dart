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

  static const _placementsKeyPrefix = 'ar_qr_origin_event_placements_v2_';

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

    final placements = _readPlacements(eventCode);

    return ArEventSceneEntity(
      eventCode: eventCode,
      title: 'AR-сцена: $eventCode',
      assets: assets,
      placements: placements,
    );
  }

  @override
  Future<void> saveEventScene({
    required String eventCode,
    required List<ArAssetPlacementEntity> placements,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    await _sharedPreferences.setString(
      '$_placementsKeyPrefix$eventCode',
      jsonEncode(placements.map((placement) => placement.toJson()).toList()),
    );

    developer.log(
      'AR QR-origin layout save',
      name: 'ArRepository',
      error: {
        'eventCode': eventCode,
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

  List<ArAssetPlacementEntity> _readPlacements(String eventCode) {
    final raw = _sharedPreferences.getString('$_placementsKeyPrefix$eventCode');
    if (raw == null || raw.isEmpty) {
      return const [];
    }

    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
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
