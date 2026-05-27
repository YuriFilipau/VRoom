import 'package:vroom/features/quest_test/domain/entities/quest_test_entity.dart';
import 'package:vroom/features/quest_test/domain/repository/quest_test_repository.dart';

class GetLatestQuestTestResultUseCase {
  const GetLatestQuestTestResultUseCase({
    required QuestTestRepository repository,
  }) : _repository = repository;

  final QuestTestRepository _repository;

  Future<QuestTestResultEntity?> call(int questId) {
    return _repository.getLatestResult(questId);
  }
}
