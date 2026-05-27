import 'package:vroom/features/quest_test/domain/entities/quest_test_entity.dart';
import 'package:vroom/features/quest_test/domain/repository/quest_test_repository.dart';

class SubmitQuestTestUseCase {
  const SubmitQuestTestUseCase({required QuestTestRepository repository})
    : _repository = repository;

  final QuestTestRepository _repository;

  Future<QuestTestResultEntity> call({
    required int questId,
    required List<QuestTestAnswerEntity> answers,
  }) {
    return _repository.submitTest(questId: questId, answers: answers);
  }
}
