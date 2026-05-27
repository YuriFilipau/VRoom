import 'package:dio/dio.dart';
import 'package:vroom/core/network/api_exception.dart';
import 'package:vroom/core/network/json_utils.dart';
import 'package:vroom/features/organizer/domain/entities/organizer_event_entity.dart';
import 'package:vroom/features/organizer/domain/entities/organizer_quest_entity.dart';
import 'package:vroom/features/organizer/domain/repository/organizer_repository.dart';

class OrganizerRepositoryImpl implements OrganizerRepository {
  OrganizerRepositoryImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<List<OrganizerEventEntity>> getEvents() async {
    try {
      final response = await _dio.get<dynamic>('/api/mobile/organizer/events');
      return asList(response.data)
          .map((item) => _parseEvent(Map<String, dynamic>.from(item as Map)))
          .toList(growable: false);
    } on DioException catch (error) {
      throw _mapDioException(
        error,
        fallbackMessage: 'Не удалось загрузить мероприятия organizer',
      );
    }
  }

  @override
  Future<List<OrganizerQuestEntity>> getQuests(int eventId) async {
    try {
      final response = await _dio.get<dynamic>(
        '/api/mobile/organizer/events/$eventId/quests',
      );
      return asList(response.data)
          .map((item) => _parseQuest(Map<String, dynamic>.from(item as Map)))
          .toList(growable: false);
    } on DioException catch (error) {
      throw _mapDioException(
        error,
        fallbackMessage: 'Не удалось загрузить квесты мероприятия',
      );
    }
  }

  OrganizerEventEntity _parseEvent(Map<String, dynamic> json) {
    return OrganizerEventEntity(
      id: readInt(json['id']) ?? 0,
      title: readString(json['title']) ?? 'Мероприятие',
      subtitle:
          readString(json['location']) ??
          readString(json['subtitle']) ??
          readString(json['starts_at']) ??
          'Organizer event',
      questCount:
          readInt(json['quests_count']) ?? readInt(json['quest_count']) ?? 0,
    );
  }

  OrganizerQuestEntity _parseQuest(Map<String, dynamic> json) {
    return OrganizerQuestEntity(
      id: readInt(json['id']) ?? 0,
      title: readString(json['title']) ?? readString(json['name']) ?? 'Квест',
      assetCount:
          readInt(json['assets_count']) ??
          (json['assets'] as List<dynamic>?)?.length ??
          0,
      hasScene:
          readBool(json['has_layout']) ??
          readBool(json['hasLayout']) ??
          readBool(json['has_scene']) ??
          readBool(json['hasScene']) ??
          false,
    );
  }

  ApiException _mapDioException(
    DioException error, {
    required String fallbackMessage,
  }) {
    final json = asMap(error.response?.data);
    return ApiException(
      message:
          readString(json['detail']) ??
          readString(json['message']) ??
          fallbackMessage,
      code: readString(json['code']),
      statusCode: error.response?.statusCode,
    );
  }
}
