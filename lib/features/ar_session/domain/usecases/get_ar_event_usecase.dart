import 'package:vroom/features/ar_session/domain/entities/ar_event_scene_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_session_mode.dart';
import 'package:vroom/features/ar_session/domain/repository/ar_repository.dart';

class GetArEventUseCase {
  const GetArEventUseCase({required ArRepository repository})
    : _repository = repository;

  final ArRepository _repository;

  Future<ArEventSceneEntity> call({
    required String eventCode,
    required ArSessionMode mode,
  }) {
    return _repository.loadEventScene(eventCode: eventCode, mode: mode);
  }
}
