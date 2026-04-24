import 'package:vroom/features/ar_session/domain/entities/ar_asset_placement_entity.dart';
import 'package:vroom/features/ar_session/domain/repository/ar_repository.dart';

class SaveArLayoutUseCase {
  const SaveArLayoutUseCase({required ArRepository repository})
    : _repository = repository;

  final ArRepository _repository;

  Future<void> call({
    required String eventCode,
    required String? sceneAnchorName,
    required String? sceneCloudAnchorId,
    required List<double>? sceneAnchorTransform,
    required int? sceneAnchorTtl,
    required List<ArAssetPlacementEntity> placements,
  }) {
    return _repository.saveEventScene(
      eventCode: eventCode,
      sceneAnchorName: sceneAnchorName,
      sceneCloudAnchorId: sceneCloudAnchorId,
      sceneAnchorTransform: sceneAnchorTransform,
      sceneAnchorTtl: sceneAnchorTtl,
      placements: placements,
    );
  }
}
