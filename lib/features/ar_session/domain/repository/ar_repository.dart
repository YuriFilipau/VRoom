import 'package:vroom/features/ar_session/domain/entities/ar_asset_placement_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_event_scene_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_session_mode.dart';

abstract interface class ArRepository {
  Future<ArEventSceneEntity> loadEventScene({
    required String eventCode,
    required ArSessionMode mode,
  });

  Future<void> saveEventScene({
    required String eventCode,
    required String? sceneAnchorName,
    required String? sceneCloudAnchorId,
    required List<double>? sceneAnchorTransform,
    required int? sceneAnchorTtl,
    required List<ArAssetPlacementEntity> placements,
  });
}
