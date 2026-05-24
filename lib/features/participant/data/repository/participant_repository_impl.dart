import 'package:dio/dio.dart';
import 'package:vroom/core/network/api_exception.dart';
import 'package:vroom/core/network/json_utils.dart';
import 'package:vroom/features/auth/domain/entities/user_achievement_entity.dart';
import 'package:vroom/features/auth/domain/entities/user_activity_entity.dart';
import 'package:vroom/features/participant/domain/entities/participant_event_detail_entity.dart';
import 'package:vroom/features/participant/domain/entities/participant_event_entity.dart';
import 'package:vroom/features/participant/domain/entities/participant_profile_entity.dart';
import 'package:vroom/features/participant/domain/entities/participant_scanned_quest_entity.dart';
import 'package:vroom/features/participant/domain/repository/participant_repository.dart';

class ParticipantRepositoryImpl implements ParticipantRepository {
  ParticipantRepositoryImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<ParticipantProfileEntity> getProfile() async {
    try {
      final profileResponse = await _dio.get<dynamic>('/api/mobile/profile');
      final profileJson = asMap(profileResponse.data);

      final eventsResponse = await _dio.get<dynamic>('/api/mobile/events/my');
      final events = asList(eventsResponse.data);
      final completedQuests =
          readInt(profileJson['completed_quests_count']) ??
          readInt(profileJson['completedQuestsCount']) ??
          events
              .map(
                (item) =>
                    _parseEventSummary(Map<String, dynamic>.from(item as Map)),
              )
              .fold<int>(0, (sum, event) => sum + event.scannedQuestsCount);

      return ParticipantProfileEntity(
        id: readInt(profileJson['id']) ?? 0,
        login: readString(profileJson['login']) ?? '',
        firstName:
            readString(profileJson['first_name']) ??
            readString(profileJson['firstName']) ??
            '',
        lastName:
            readString(profileJson['last_name']) ??
            readString(profileJson['lastName']) ??
            '',
        isStaff:
            readBool(profileJson['is_staff']) ??
            readBool(profileJson['isStaff']) ??
            false,
        achievements: _parseAchievements(profileJson['achievements']),
        recentActivities: _parseActivities(
          profileJson['recent_activities'] ?? profileJson['recentActivities'],
        ),
        joinedEventsCount: events.length,
        completedQuestsCount: completedQuests,
      );
    } on DioException catch (error) {
      throw _mapDioException(
        error,
        fallbackMessage: 'Не удалось загрузить профиль',
      );
    }
  }

  @override
  Future<List<ParticipantEventEntity>> getMyEvents() async {
    try {
      final response = await _dio.get<dynamic>('/api/mobile/events/my');
      return asList(response.data)
          .map(
            (item) =>
                _parseEventSummary(Map<String, dynamic>.from(item as Map)),
          )
          .toList(growable: false);
    } on DioException catch (error) {
      throw _mapDioException(
        error,
        fallbackMessage: 'Не удалось загрузить список мероприятий',
      );
    }
  }

  @override
  Future<ParticipantEventDetailEntity> getEventDetail(int eventId) async {
    try {
      final response = await _dio.get<dynamic>('/api/mobile/events/$eventId');
      final json = asMap(response.data);
      final scannedQuests =
          (json['scanned_quests'] as List<dynamic>? ?? const <dynamic>[])
              .map(
                (item) =>
                    _parseScannedQuest(Map<String, dynamic>.from(item as Map)),
              )
              .toList(growable: false);

      return ParticipantEventDetailEntity(
        id: readInt(json['id']) ?? eventId,
        title: readString(json['title']) ?? 'Мероприятие #$eventId',
        description:
            readString(json['description']) ??
            readString(json['short_description']) ??
            'Описание мероприятия пока не заполнено.',
        imageUrl:
            readString(json['image_url']) ??
            readString(json['cover_url']) ??
            _fallbackImage(scannedQuests.length),
        progressPercent:
            readInt(json['progress_percent']) ??
            readInt(json['progressPercent']) ??
            _progressFromCounts(
              scannedQuests.length,
              readInt(json['total_quests']) ??
                  readInt(json['quests_count']) ??
                  scannedQuests.length,
            ),
        certificateAvailable:
            readBool(json['certificate_available']) ??
            readBool(json['has_certificate']) ??
            false,
        scannedQuests: scannedQuests,
      );
    } on DioException catch (error) {
      throw _mapDioException(
        error,
        fallbackMessage: 'Не удалось загрузить мероприятие',
      );
    }
  }

  ParticipantEventEntity _parseEventSummary(Map<String, dynamic> json) {
    final scannedQuests =
        readInt(json['scanned_quests_count']) ??
        readInt(json['scannedQuestsCount']) ??
        (json['scanned_quests'] as List<dynamic>?)?.length ??
        0;
    final totalQuests =
        readInt(json['total_quests']) ??
        readInt(json['quests_count']) ??
        readInt(json['totalQuests']) ??
        scannedQuests;

    return ParticipantEventEntity(
      id: readInt(json['id']) ?? 0,
      title: readString(json['title']) ?? 'Мероприятие',
      description:
          readString(json['description']) ??
          readString(json['status']) ??
          'Подробности появятся после загрузки.',
      imageUrl:
          readString(json['image_url']) ??
          readString(json['cover_url']) ??
          _fallbackImage(readInt(json['id']) ?? 0),
      progressPercent:
          readInt(json['progress_percent']) ??
          readInt(json['progressPercent']) ??
          _progressFromCounts(scannedQuests, totalQuests),
      certificateAvailable:
          readBool(json['certificate_available']) ??
          readBool(json['has_certificate']) ??
          false,
      statusLabel:
          readString(json['status_label']) ??
          readString(json['status']) ??
          'Активно',
      scannedQuestsCount: scannedQuests,
      totalQuestsCount: totalQuests,
    );
  }

  ParticipantScannedQuestEntity _parseScannedQuest(Map<String, dynamic> json) {
    return ParticipantScannedQuestEntity(
      id: readInt(json['id']) ?? 0,
      title: readString(json['title']) ?? readString(json['name']) ?? 'Квест',
      progressPercent:
          readInt(json['progress_percent']) ??
          readInt(json['progressPercent']) ??
          100,
      statusLabel:
          readString(json['status_label']) ??
          readString(json['status']) ??
          'Сканирован',
    );
  }

  List<UserAchievementEntity> _parseAchievements(dynamic raw) {
    return asList(raw)
        .map((item) {
          final json = Map<String, dynamic>.from(item as Map);
          return UserAchievementEntity(
            id: readInt(json['id']) ?? 0,
            title:
                readString(json['title']) ??
                readString(json['name']) ??
                'Достижение',
            iconKey: readString(json['icon_key']) ?? 'trophy',
            isUnlocked:
                readBool(json['is_unlocked']) ??
                readBool(json['isUnlocked']) ??
                true,
          );
        })
        .toList(growable: false);
  }

  List<UserActivityEntity> _parseActivities(dynamic raw) {
    return asList(raw)
        .map((item) {
          final json = Map<String, dynamic>.from(item as Map);
          return UserActivityEntity(
            id: readInt(json['id']) ?? 0,
            title:
                readString(json['title']) ??
                readString(json['description']) ??
                'Активность',
            timeLabel:
                readString(json['time_label']) ??
                readString(json['created_at']) ??
                'только что',
          );
        })
        .toList(growable: false);
  }

  int _progressFromCounts(int scanned, int total) {
    if (total <= 0) {
      return 0;
    }
    return ((scanned / total) * 100).round().clamp(0, 100);
  }

  String _fallbackImage(int seed) {
    final urls = [
      'https://images.unsplash.com/photo-1516321497487-e288fb19713f',
      'https://images.unsplash.com/photo-1522202176988-66273c2fd55f',
      'https://images.unsplash.com/photo-1519389950473-47ba0277781c',
    ];
    return urls[seed.abs() % urls.length];
  }

  ApiException _mapDioException(
    DioException error, {
    required String fallbackMessage,
  }) {
    final responseData = error.response?.data;
    final json = asMap(responseData);
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
