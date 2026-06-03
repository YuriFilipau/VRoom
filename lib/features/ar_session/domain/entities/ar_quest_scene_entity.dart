import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_placement_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_scene_root_anchor_entity.dart';

part 'ar_quest_scene_entity.freezed.dart';

@freezed
abstract class ArQuestSceneEntity with _$ArQuestSceneEntity {
  const factory ArQuestSceneEntity({
    required String sceneId,
    required int questId,
    required int eventId,
    required String title,
    required int? version,
    required String? updatedAt,
    required int? createdBy,
    required bool isPublished,
    required bool hasTest,
    required List<ArAssetEntity> assets,
    required List<ArAssetPlacementEntity> objects,
    ArSceneRootAnchorEntity? rootAnchor,
    String? arcoreToken,
  }) = _ArQuestSceneEntity;
}
