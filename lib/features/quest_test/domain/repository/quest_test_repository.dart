import 'package:vroom/features/quest_test/domain/entities/quest_test_entity.dart';

abstract interface class QuestTestRepository {
  Future<QuestTestEntity> getTest(int questId);

  Future<QuestTestResultEntity?> getLatestResult(int questId);

  Future<QuestTestResultEntity> submitTest({
    required int questId,
    required List<QuestTestAnswerEntity> answers,
  });
}
