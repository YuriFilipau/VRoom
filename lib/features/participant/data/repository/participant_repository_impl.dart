import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vroom/core/network/api_exception.dart';
import 'package:vroom/core/network/json_utils.dart';
import 'package:vroom/features/auth/domain/entities/user_achievement_entity.dart';
import 'package:vroom/features/auth/domain/entities/user_activity_entity.dart';
import 'package:vroom/features/participant/domain/entities/participant_certificate_entity.dart';
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
      return await _loadProfile();
    } on DioException catch (error) {
      throw _mapDioException(
        error,
        fallbackMessage: 'Не удалось загрузить профиль',
      );
    }
  }

  @override
  Future<ParticipantProfileEntity> updateProfile({
    String? firstName,
    String? lastName,
    String? school,
    String? schoolClass,
    int? schoolClassNumber,
    String? schoolClassLetter,
    MultipartFile? avatar,
  }) async {
    try {
      final data = <String, dynamic>{
        if (firstName != null) 'first_name': firstName.trim(),
        if (lastName != null) 'last_name': lastName.trim(),
        if (school != null) 'school': school.trim(),
        if (schoolClass != null) 'school_class': schoolClass.trim(),
        if (schoolClassNumber != null) 'school_class_number': schoolClassNumber,
        if (schoolClassLetter != null)
          'school_class_letter': schoolClassLetter.trim().toUpperCase(),
      };

      final requestData = avatar == null
          ? data
          : FormData.fromMap({...data, 'avatar': avatar});
      final response = await _sendProfileUpdate(requestData);
      final json = asMap(response.data);
      return _looksLikeProfile(json)
          ? await _parseProfileResponse(json)
          : await _loadProfile();
    } on DioException catch (error) {
      throw _mapDioException(
        error,
        fallbackMessage: 'Не удалось обновить профиль',
      );
    }
  }

  @override
  Future<ParticipantProfileEntity> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        '/api/mobile/profile/password',
        data: {
          'current_password': currentPassword,
          'new_password': newPassword,
        },
      );
      final json = asMap(response.data);
      return _looksLikeProfile(json)
          ? await _parseProfileResponse(json)
          : await _loadProfile();
    } on DioException catch (error) {
      throw _mapDioException(
        error,
        fallbackMessage: 'Не удалось изменить пароль',
      );
    }
  }

  Future<Response<dynamic>> _sendProfileUpdate(dynamic requestData) async {
    try {
      return await _dio.patch<dynamic>(
        '/api/mobile/profile',
        data: requestData,
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == 405) {
        return await _dio.put<dynamic>(
          '/api/mobile/profile',
          data: requestData,
        );
      }
      rethrow;
    }
  }

  Future<ParticipantProfileEntity> _loadProfile() async {
    final profileResponse = await _dio.get<dynamic>('/api/mobile/profile');
    return _parseProfileResponse(asMap(profileResponse.data));
  }

  Future<ParticipantProfileEntity> _parseProfileResponse(
    Map<String, dynamic> profileJson,
  ) async {
    final events = await _profileEvents(profileJson);
    return _parseProfile(profileJson, events: events);
  }

  Future<List<dynamic>> _profileEvents(Map<String, dynamic> profileJson) async {
    final profileEvents = asList(profileJson['events']);
    if (profileEvents.isNotEmpty) {
      return profileEvents;
    }
    return asList((await _dio.get<dynamic>('/api/mobile/events/my')).data);
  }

  ParticipantProfileEntity _parseProfile(
    Map<String, dynamic> profileJson, {
    required List<dynamic> events,
  }) {
    final completedQuests =
        readInt(profileJson['completed_quests_count']) ??
        readInt(profileJson['completedQuestsCount']) ??
        events
            .map(
              (item) =>
                  _parseEventSummary(Map<String, dynamic>.from(item as Map)),
            )
            .fold<int>(0, (sum, event) => sum + event.completedQuestsCount);

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
      school: readString(profileJson['school']),
      schoolClass:
          readString(profileJson['school_class']) ??
          readString(profileJson['schoolClass']),
      schoolClassNumber:
          readInt(profileJson['school_class_number']) ??
          readInt(profileJson['schoolClassNumber']),
      schoolClassLetter:
          readString(profileJson['school_class_letter']) ??
          readString(profileJson['schoolClassLetter']),
      avatarUrl:
          readString(profileJson['avatar_url']) ??
          readString(profileJson['avatarUrl']),
      achievements: _parseAchievements(profileJson['achievements']),
      recentActivities: _parseActivities(
        profileJson['recent_activities'] ?? profileJson['recentActivities'],
      ),
      joinedEventsCount: events.length,
      completedQuestsCount: completedQuests,
    );
  }

  bool _looksLikeProfile(Map<String, dynamic> json) {
    return json.containsKey('id') ||
        json.containsKey('login') ||
        json.containsKey('first_name') ||
        json.containsKey('firstName');
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
            readString(json['cover_image_url']) ??
            readString(json['cover_image']) ??
            readString(json['image_url']) ??
            readString(json['cover_url']) ??
            _fallbackImage(scannedQuests.length),
        progressPercent:
            readInt(asMap(json['summary'])['progress_percent']) ??
            readInt(json['progress_percent']) ??
            readInt(json['progressPercent']) ??
            _progressFromCounts(
              scannedQuests.length,
              readInt(json['total_quests']) ??
                  readInt(json['quests_count']) ??
                  scannedQuests.length,
            ),
        certificate: _parseCertificateStatus(
          eventId,
          json['certificate'] ??
              {
                'available': json['certificate_available'],
                'issued': json['certificate_issued'],
                'artifact_url': json['artifact_url'],
              },
        ),
        scannedQuests: scannedQuests,
      );
    } on DioException catch (error) {
      throw _mapDioException(
        error,
        fallbackMessage: 'Не удалось загрузить мероприятие',
      );
    }
  }

  @override
  Future<ParticipantCertificateEntity> issueCertificate(int eventId) async {
    try {
      final response = await _dio.post<dynamic>(
        '/api/events/$eventId/certificate/issue',
      );
      return _parseIssuedCertificate(eventId, response.data);
    } on DioException catch (error) {
      throw _mapDioException(
        error,
        fallbackMessage: 'Не удалось получить сертификат',
      );
    }
  }

  @override
  Future<ParticipantCertificateEntity> getCertificate(int eventId) async {
    try {
      final response = await _dio.get<dynamic>(
        '/api/events/$eventId/certificate',
      );
      return _parseIssuedCertificate(eventId, response.data);
    } on DioException catch (error) {
      throw _mapDioException(
        error,
        fallbackMessage: 'Не удалось открыть сертификат',
      );
    }
  }

  @override
  Future<String> downloadCertificatePdf(int eventId) async {
    try {
      final response = await _dio.get<List<int>>(
        '/api/events/$eventId/certificate/download',
        options: Options(responseType: ResponseType.bytes),
      );
      final bytes = response.data;
      if (bytes == null || bytes.isEmpty) {
        throw ApiException(
          message: 'Сертификат пустой или недоступен.',
          statusCode: response.statusCode,
        );
      }

      final fileName = _extractFilename(
            response.headers.value('content-disposition'),
          ) ??
          'certificate_event_$eventId.pdf';
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}${Platform.pathSeparator}$fileName');
      await file.writeAsBytes(bytes, flush: true);
      return file.path;
    } on DioException catch (error) {
      throw _mapDioException(
        error,
        fallbackMessage: 'Не удалось скачать сертификат',
      );
    } on ApiException {
      rethrow;
    } catch (_) {
      throw const ApiException(message: 'Не удалось скачать сертификат');
    }
  }

  ParticipantEventEntity _parseEventSummary(Map<String, dynamic> json) {
    final scannedQuests =
        readInt(json['scanned_quests_count']) ??
        readInt(json['scannedQuestsCount']) ??
        (json['scanned_quests'] as List<dynamic>?)?.length ??
        0;
    final completedQuests =
        readInt(json['completed_quests_count']) ??
        readInt(json['completedQuestsCount']) ??
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
          readString(json['cover_image_url']) ??
          readString(json['cover_image']) ??
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
      certificateIssued:
          readBool(json['certificate_issued']) ??
          readBool(json['certificateIssued']) ??
          false,
      statusLabel:
          readString(json['status_label']) ??
          readString(json['status']) ??
          'Активно',
      scannedQuestsCount: scannedQuests,
      completedQuestsCount: completedQuests,
      totalQuestsCount: totalQuests,
    );
  }

  String? _extractFilename(String? contentDisposition) {
    final header = contentDisposition?.trim();
    if (header == null || header.isEmpty) {
      return null;
    }
    final utfMatch = RegExp(r"filename\*=UTF-8''([^;]+)", caseSensitive: false)
        .firstMatch(header);
    if (utfMatch != null) {
      return Uri.decodeComponent(utfMatch.group(1)!);
    }
    final plainMatch = RegExp(r'filename="?([^\";]+)"?', caseSensitive: false)
        .firstMatch(header);
    return plainMatch?.group(1);
  }

  ParticipantScannedQuestEntity _parseScannedQuest(Map<String, dynamic> json) {
    return ParticipantScannedQuestEntity(
      id: readInt(json['id']) ?? 0,
      title: readString(json['title']) ?? readString(json['name']) ?? 'Квест',
      imageUrl:
          readString(json['cover_image_url']) ??
          readString(json['cover_image']) ??
          readString(json['image_url']) ??
          readString(json['cover_url']) ??
          '',
      progressPercent:
          readInt(json['progress_percent']) ??
          readInt(json['progressPercent']) ??
          100,
      statusLabel:
          readString(json['status_label']) ??
          readString(json['status']) ??
          'Сканирован',
      hasTest: readBool(json['has_test']) ?? readBool(json['hasTest']) ?? false,
      testCompleted:
          readBool(json['test_completed']) ??
          readBool(json['testCompleted']) ??
          false,
      testPassed:
          readBool(json['test_passed']) ??
          readBool(json['testPassed']) ??
          false,
      score: readInt(json['score']),
      passingScore:
          readInt(json['passing_score']) ?? readInt(json['passingScore']),
    );
  }

  ParticipantCertificateEntity _parseCertificateStatus(
    int eventId,
    dynamic raw,
  ) {
    final json = asMap(raw);
    return ParticipantCertificateEntity(
      eventId: eventId,
      available:
          readBool(json['available']) ??
          readBool(json['certificate_available']) ??
          false,
      issued:
          readBool(json['issued']) ??
          readBool(json['certificate_issued']) ??
          false,
      requirementMode: readString(json['requirement_mode']) ?? '',
      scoreThreshold: readInt(json['score_threshold']),
      certificateNumber: readString(json['certificate_number']),
      issuedAt: readString(json['issued_at']),
      artifactUrl: readString(json['artifact_url']),
      renderedContent: readString(json['rendered_content']),
    );
  }

  ParticipantCertificateEntity _parseIssuedCertificate(
    int eventId,
    dynamic raw,
  ) {
    final json = asMap(raw);
    return ParticipantCertificateEntity(
      eventId: readInt(json['event_id']) ?? eventId,
      available: true,
      issued: true,
      requirementMode: '',
      scoreThreshold: null,
      certificateNumber: readString(json['certificate_number']),
      issuedAt: readString(json['issued_at']),
      artifactUrl: readString(json['artifact_url']),
      renderedContent: readString(json['rendered_content']),
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
