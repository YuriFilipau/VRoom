import 'package:dio/dio.dart';
import 'package:vroom/core/network/api_exception.dart';
import 'package:vroom/core/network/json_utils.dart';
import 'package:vroom/features/qr_scanner/domain/entities/qr_scan_result_entity.dart';
import 'package:vroom/features/qr_scanner/domain/repository/qr_scanner_repository.dart';

class QrScannerRepositoryImpl implements QrScannerRepository {
  QrScannerRepositoryImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<QrScanResultEntity> processQr(String rawValue) async {
    final token = rawValue.trim();
    if (token.isEmpty) {
      throw const ApiException(message: 'QR-код пустой', code: 'qr_empty');
    }

    final resolveJson = await _resolveQr(token);
    final questId =
        _extractQuestId(resolveJson) ??
        (throw const ApiException(
          message: 'QR не привязан к квесту',
          code: 'qr_not_found',
        ));
    final eventId = _extractEventId(resolveJson);
    final sessionId = await _startAndPingScan(token: token, questId: questId);
    await _dio.get<dynamic>('/api/quests/$questId/bundle');

    return QrScanResultEntity(
      questId: questId,
      eventId: eventId,
      scanSessionId: sessionId,
    );
  }

  Future<Map<String, dynamic>> _resolveQr(String token) async {
    final payload = {
      'token': token,
      'qr': token,
      'qr_token': token,
      'raw': token,
    };

    final endpoints = ['/api/qr/resolve', '/api/quests/qr/resolve'];

    DioException? lastError;
    for (final endpoint in endpoints) {
      try {
        final response = await _dio.post<dynamic>(endpoint, data: payload);
        return asMap(response.data);
      } on DioException catch (error) {
        lastError = error;
        final statusCode = error.response?.statusCode;
        if (statusCode != 404) {
          throw _mapQrException(error);
        }
      }
    }

    throw _mapQrException(
      lastError,
      fallbackMessage: 'QR endpoint не найден на backend',
      code: 'qr_not_found',
    );
  }

  Future<String?> _startAndPingScan({
    required String token,
    required int questId,
  }) async {
    try {
      final startResponse = await _dio.post<dynamic>(
        '/api/scan/start',
        data: {
          'token': token,
          'qr_token': token,
          'quest_id': questId,
          'questId': questId,
        },
      );
      final startJson = asMap(startResponse.data);
      final sessionId =
          readString(startJson['session_id']) ??
          readString(startJson['sessionId']) ??
          readString(startJson['id']);

      if (sessionId != null) {
        await _dio.post<dynamic>(
          '/api/scan/ping',
          data: {
            'session_id': sessionId,
            'sessionId': sessionId,
            'quest_id': questId,
            'questId': questId,
          },
        );
      }

      return sessionId;
    } on DioException catch (error) {
      final json = asMap(error.response?.data);
      final code = readString(json['code']);
      if (code == 'scan_start_throttled') {
        throw const ApiException(
          message:
              'Сканирование запускается слишком часто. Попробуйте чуть позже.',
          code: 'scan_start_throttled',
        );
      }
      throw _mapQrException(
        error,
        fallbackMessage: 'Не удалось запустить сканирование квеста',
      );
    }
  }

  int? _extractQuestId(Map<String, dynamic> json) {
    return readInt(json['quest_id']) ??
        readInt(json['questId']) ??
        readInt(asMap(json['quest'])['id']) ??
        readInt(asMap(json['bundle'])['quest_id']) ??
        readInt(asMap(json['bundle'])['questId']);
  }

  int? _extractEventId(Map<String, dynamic> json) {
    return readInt(json['event_id']) ??
        readInt(json['eventId']) ??
        readInt(asMap(json['event'])['id']);
  }

  ApiException _mapQrException(
    DioException? error, {
    String? fallbackMessage,
    String? code,
  }) {
    final json = asMap(error?.response?.data);
    final resolvedCode = readString(json['code']) ?? code;
    if (resolvedCode == 'qr_not_found') {
      return const ApiException(
        message: 'QR-код не найден или больше не активен',
        code: 'qr_not_found',
      );
    }

    return ApiException(
      message:
          readString(json['detail']) ??
          readString(json['message']) ??
          fallbackMessage ??
          'Не удалось обработать QR-код',
      code: resolvedCode,
      statusCode: error?.response?.statusCode,
    );
  }
}
