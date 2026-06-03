part of 'quest_test_bloc.dart';

@freezed
sealed class QuestTestEvent with _$QuestTestEvent {
  const factory QuestTestEvent.loadRequested(int questId) =
      QuestTestLoadRequested;

  const factory QuestTestEvent.optionToggled({
    required int questionId,
    required int optionId,
  }) = QuestTestOptionToggled;

  const factory QuestTestEvent.submitRequested() = QuestTestSubmitRequested;
}
