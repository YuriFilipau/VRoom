import 'package:vroom/features/quest_test/domain/entities/quest_test_entity.dart';
import 'package:vroom/features/quest_test/domain/repository/quest_test_repository.dart';

class GetQuestTestUseCase {
  const GetQuestTestUseCase({required QuestTestRepository repository})
    : _repository = repository;

  final QuestTestRepository _repository;

  Future<QuestTestEntity> call(int questId) {
    return _repository.getTest(questId);
  }
}
