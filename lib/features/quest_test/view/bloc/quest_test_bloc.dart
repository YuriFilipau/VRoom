import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vroom/core/network/api_exception.dart';
import 'package:vroom/features/quest_test/domain/entities/quest_test_entity.dart';
import 'package:vroom/features/quest_test/domain/usecases/get_latest_quest_test_result_usecase.dart';
import 'package:vroom/features/quest_test/domain/usecases/get_quest_test_usecase.dart';
import 'package:vroom/features/quest_test/domain/usecases/submit_quest_test_usecase.dart';

part 'quest_test_bloc.freezed.dart';
part 'quest_test_event.dart';
part 'quest_test_state.dart';

class QuestTestBloc extends Bloc<QuestTestEvent, QuestTestState> {
  QuestTestBloc({
    required GetQuestTestUseCase getQuestTestUseCase,
    required GetLatestQuestTestResultUseCase getLatestResultUseCase,
    required SubmitQuestTestUseCase submitQuestTestUseCase,
  }) : _getQuestTestUseCase = getQuestTestUseCase,
       _getLatestResultUseCase = getLatestResultUseCase,
       _submitQuestTestUseCase = submitQuestTestUseCase,
       super(const QuestTestState()) {
    on<QuestTestLoadRequested>(_onLoadRequested);
    on<QuestTestOptionToggled>(_onOptionToggled);
    on<QuestTestSubmitRequested>(_onSubmitRequested);
  }

  final GetQuestTestUseCase _getQuestTestUseCase;
  final GetLatestQuestTestResultUseCase _getLatestResultUseCase;
  final SubmitQuestTestUseCase _submitQuestTestUseCase;

  Future<void> _onLoadRequested(
    QuestTestLoadRequested event,
    Emitter<QuestTestState> emit,
  ) async {
    emit(state.copyWith(status: QuestTestStatus.loading, message: null));
    try {
      final test = await _getQuestTestUseCase(event.questId);
      final latestResult = await _getLatestResultUseCase(event.questId);
      emit(
        state.copyWith(
          status: QuestTestStatus.ready,
          questId: event.questId,
          test: test,
          latestResult: latestResult,
          selectedAnswers: const {},
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(status: QuestTestStatus.failure, message: error.message),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: QuestTestStatus.failure,
          message: 'Не удалось загрузить тест. Попробуйте ещё раз.',
        ),
      );
    }
  }

  void _onOptionToggled(
    QuestTestOptionToggled event,
    Emitter<QuestTestState> emit,
  ) {
    final test = state.test;
    if (test == null) {
      return;
    }

    final question = test.questions.firstWhere(
      (item) => item.id == event.questionId,
    );
    final nextAnswers = Map<int, List<int>>.from(state.selectedAnswers);

    if (question.type == QuestTestQuestionType.single) {
      nextAnswers[event.questionId] = [event.optionId];
    } else {
      final current = [...nextAnswers[event.questionId] ?? const <int>[]];
      if (current.contains(event.optionId)) {
        current.remove(event.optionId);
      } else {
        current.add(event.optionId);
      }
      nextAnswers[event.questionId] = current;
    }

    emit(state.copyWith(selectedAnswers: nextAnswers, message: null));
  }

  Future<void> _onSubmitRequested(
    QuestTestSubmitRequested event,
    Emitter<QuestTestState> emit,
  ) async {
    final test = state.test;
    if (test == null) {
      return;
    }

    final answers = test.questions
        .map(
          (question) => QuestTestAnswerEntity(
            questionId: question.id,
            optionIds: state.selectedAnswers[question.id] ?? const <int>[],
          ),
        )
        .where((answer) => answer.optionIds.isNotEmpty)
        .toList(growable: false);

    if (answers.length != test.questions.length) {
      emit(
        state.copyWith(
          message: 'Ответьте на все вопросы перед отправкой теста.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: QuestTestStatus.submitting, message: null));
    try {
      final result = await _submitQuestTestUseCase(
        questId: state.questId,
        answers: answers,
      );
      emit(
        state.copyWith(
          status: QuestTestStatus.submitted,
          latestResult: result,
          message: result.isPassed
              ? 'Тест пройден. Результат сохранён.'
              : 'Тест завершён. Можно попробовать ещё раз, если попытки доступны.',
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(status: QuestTestStatus.ready, message: error.message),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: QuestTestStatus.ready,
          message: 'Не удалось отправить тест. Попробуйте ещё раз.',
        ),
      );
    }
  }
}
