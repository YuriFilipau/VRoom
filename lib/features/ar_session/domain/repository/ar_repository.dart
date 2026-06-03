import 'package:vroom/features/ar_session/domain/entities/ar_anchor_reach_result_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_placement_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_quest_scene_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_scene_root_anchor_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_session_mode.dart';

abstract interface class ArRepository {
  Future<ArQuestSceneEntity> loadScene({
    required int questId,
    required ArSessionMode mode,
  });

  Future<ArQuestSceneEntity> saveScene({
    required int questId,
    required int? version,
    required ArSceneRootAnchorEntity? rootAnchor,
    required List<ArAssetPlacementEntity> objects,
  });

  Future<ArAnchorReachResultEntity> markAnchorReached({
    required int questId,
    required String anchorId,
    String? sessionId,
    String? interactionType,
    int? answerIndex,
  });
}
