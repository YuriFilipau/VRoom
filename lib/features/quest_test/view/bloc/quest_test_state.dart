part of 'quest_test_bloc.dart';

enum QuestTestStatus { initial, loading, ready, submitting, submitted, failure }

@freezed
abstract class QuestTestState with _$QuestTestState {
  const QuestTestState._();

  const factory QuestTestState({
    @Default(QuestTestStatus.initial) QuestTestStatus status,
    @Default(0) int questId,
    QuestTestEntity? test,
    QuestTestResultEntity? latestResult,
    @Default({}) Map<int, List<int>> selectedAnswers,
    String? message,
  }) = _QuestTestState;

  bool get canSubmit {
    final currentTest = test;
    if (currentTest == null || currentTest.questions.isEmpty) {
      return false;
    }
    return currentTest.questions.every(
      (question) => selectedAnswers[question.id]?.isNotEmpty == true,
    );
  }
}
