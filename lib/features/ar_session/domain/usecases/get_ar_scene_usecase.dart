import 'package:vroom/features/ar_session/domain/entities/ar_quest_scene_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_session_mode.dart';
import 'package:vroom/features/ar_session/domain/repository/ar_repository.dart';

class GetArSceneUseCase {
  const GetArSceneUseCase({required ArRepository repository})
    : _repository = repository;

  final ArRepository _repository;

  Future<ArQuestSceneEntity> call({
    required int questId,
    required ArSessionMode mode,
  }) {
    return _repository.loadScene(questId: questId, mode: mode);
  }
}
