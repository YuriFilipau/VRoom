import 'package:vroom/features/ar_session/domain/entities/ar_asset_placement_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_quest_scene_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_scene_root_anchor_entity.dart';
import 'package:vroom/features/ar_session/domain/repository/ar_repository.dart';

class SaveArLayoutUseCase {
  const SaveArLayoutUseCase({required ArRepository repository})
    : _repository = repository;

  final ArRepository _repository;

  Future<ArQuestSceneEntity> call({
    required int questId,
    required int? version,
    required ArSceneRootAnchorEntity? rootAnchor,
    required List<ArAssetPlacementEntity> objects,
  }) {
    return _repository.saveScene(
      questId: questId,
      version: version,
      rootAnchor: rootAnchor,
      objects: objects,
    );
  }
}
