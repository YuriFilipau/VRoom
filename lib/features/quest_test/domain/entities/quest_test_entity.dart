import 'package:freezed_annotation/freezed_annotation.dart';

part 'quest_test_entity.freezed.dart';

@freezed
abstract class QuestTestEntity with _$QuestTestEntity {
  const factory QuestTestEntity({
    required int id,
    required int questId,
    required String title,
    required String description,
    required int passingScore,
    required int maxScore,
    required int maxAttempts,
    required int cooldownSeconds,
    required bool shuffleQuestions,
    required bool shuffleOptions,
    required List<QuestTestQuestionEntity> questions,
  }) = _QuestTestEntity;
}

@freezed
abstract class QuestTestQuestionEntity with _$QuestTestQuestionEntity {
  const factory QuestTestQuestionEntity({
    required int id,
    required QuestTestQuestionType type,
    required String text,
    required int points,
    required int orderIndex,
    required List<QuestTestOptionEntity> options,
  }) = _QuestTestQuestionEntity;
}

@freezed
abstract class QuestTestOptionEntity with _$QuestTestOptionEntity {
  const factory QuestTestOptionEntity({
    required int id,
    required String text,
    required int orderIndex,
  }) = _QuestTestOptionEntity;
}

@freezed
abstract class QuestTestAnswerEntity with _$QuestTestAnswerEntity {
  const factory QuestTestAnswerEntity({
    required int questionId,
    required List<int> optionIds,
  }) = _QuestTestAnswerEntity;
}

@freezed
abstract class QuestTestResultEntity with _$QuestTestResultEntity {
  const factory QuestTestResultEntity({
    required int id,
    required int score,
    required bool isPassed,
    required String createdAt,
  }) = _QuestTestResultEntity;
}

enum QuestTestQuestionType { single, multiple }
