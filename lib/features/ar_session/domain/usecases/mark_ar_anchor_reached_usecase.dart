import 'package:vroom/features/ar_session/domain/entities/ar_anchor_reach_result_entity.dart';
import 'package:vroom/features/ar_session/domain/repository/ar_repository.dart';

class MarkArAnchorReachedUseCase {
  const MarkArAnchorReachedUseCase({required ArRepository repository})
    : _repository = repository;

  final ArRepository _repository;

  Future<ArAnchorReachResultEntity> call({
    required int questId,
    required String anchorId,
    String? sessionId,
  }) {
    return _repository.markAnchorReached(
      questId: questId,
      anchorId: anchorId,
      sessionId: sessionId,
    );
  }
}
