import 'package:dio/dio.dart';
import 'package:vroom/core/network/api_exception.dart';
import 'package:vroom/core/network/json_utils.dart';
import 'package:vroom/features/quest_test/domain/entities/quest_test_entity.dart';
import 'package:vroom/features/quest_test/domain/repository/quest_test_repository.dart';

class QuestTestRepositoryImpl implements QuestTestRepository {
  QuestTestRepositoryImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<QuestTestEntity> getTest(int questId) async {
    try {
      final response = await _dio.get<dynamic>('/api/quests/$questId/test');
      return _parseTest(questId, response.data);
    } on DioException catch (error) {
      throw _mapTestException(error);
    }
  }

  @override
  Future<QuestTestResultEntity?> getLatestResult(int questId) async {
    try {
      final response = await _dio.get<dynamic>(
        '/api/quests/$questId/test/result/latest',
      );
      return _parseResult(response.data);
    } on DioException catch (error) {
      final code = readString(asMap(error.response?.data)['code']);
      if (error.response?.statusCode == 404 ||
          code == 'test_result_not_found') {
        return null;
      }
      throw _mapTestException(error);
    }
  }

  @override
  Future<QuestTestResultEntity> submitTest({
    required int questId,
    required List<QuestTestAnswerEntity> answers,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        '/api/quests/$questId/test/submit',
        data: {'answers': answers.map(_answerToJson).toList(growable: false)},
      );
      return _parseResult(response.data);
    } on DioException catch (error) {
      throw _mapTestException(error);
    }
  }

  QuestTestEntity _parseTest(int questId, dynamic raw) {
    final json = asMap(raw);
    return QuestTestEntity(
      id: readInt(json['id']) ?? 0,
      questId: readInt(json['quest_id']) ?? questId,
      title: readString(json['title']) ?? 'Тест квеста',
      description: readString(json['description']) ?? '',
      passingScore: readInt(json['passing_score']) ?? 0,
      maxScore: readInt(json['max_score']) ?? 100,
      maxAttempts: readInt(json['max_attempts']) ?? 1,
      cooldownSeconds: readInt(json['cooldown_seconds']) ?? 0,
      shuffleQuestions: readBool(json['shuffle_questions']) ?? false,
      shuffleOptions: readBool(json['shuffle_options']) ?? false,
      questions: asList(json['questions'])
          .map((item) => _parseQuestion(Map<String, dynamic>.from(item as Map)))
          .toList(growable: false),
    );
  }

  QuestTestQuestionEntity _parseQuestion(Map<String, dynamic> json) {
    final rawType = readString(json['question_type']) ?? 'single';
    final type = rawType == 'multi' || rawType == 'multiple'
        ? QuestTestQuestionType.multiple
        : QuestTestQuestionType.single;

    return QuestTestQuestionEntity(
      id: readInt(json['id']) ?? 0,
      type: type,
      text: readString(json['text']) ?? '',
      points: readInt(json['points']) ?? 1,
      orderIndex: readInt(json['order_index']) ?? 0,
      options: asList(json['options'])
          .map((item) => _parseOption(Map<String, dynamic>.from(item as Map)))
          .toList(growable: false),
    );
  }

  QuestTestOptionEntity _parseOption(Map<String, dynamic> json) {
    return QuestTestOptionEntity(
      id: readInt(json['id']) ?? 0,
      text: readString(json['text']) ?? '',
      orderIndex: readInt(json['order_index']) ?? 0,
    );
  }

  Map<String, dynamic> _answerToJson(QuestTestAnswerEntity answer) {
    return {
      'question_id': answer.questionId,
      'answer': answer.optionIds.length == 1
          ? answer.optionIds.first
          : answer.optionIds,
    };
  }

  QuestTestResultEntity _parseResult(dynamic raw) {
    final json = asMap(raw);
    return QuestTestResultEntity(
      id: readInt(json['id']) ?? 0,
      score: readInt(json['score']) ?? 0,
      isPassed:
          readBool(json['is_passed']) ?? readBool(json['isPassed']) ?? false,
      createdAt: readString(json['created_at']) ?? '',
    );
  }

  ApiException _mapTestException(DioException error) {
    final json = asMap(error.response?.data);
    final code = readString(json['code']);
    final message = switch (code) {
      'test_locked_by_anchor' =>
        'Тест станет доступен после прохождения контрольной точки в AR-сцене.',
      'test_anchor_not_configured' =>
        'Квест настроен некорректно. Обратитесь к организатору.',
      'test_not_found' => 'Тест для этого квеста недоступен.',
      'test_attempts_exceeded' => 'Лимит попыток исчерпан.',
      'test_cooldown_active' =>
        'Перед следующей попыткой нужно немного подождать.',
      'test_result_not_found' => 'Результат теста пока отсутствует.',
      _ when error.response?.statusCode == 403 =>
        'Тест станет доступен после прохождения контрольной точки в AR-сцене.',
      _ when error.response?.statusCode == 409 =>
        'Квест настроен некорректно. Обратитесь к организатору.',
      _ when error.response?.statusCode == 404 =>
        'Тест для этого квеста недоступен.',
      _ => 'Не удалось загрузить тест. Попробуйте ещё раз.',
    };
    return ApiException(
      message: message,
      code: code,
      statusCode: error.response?.statusCode,
    );
  }
}
