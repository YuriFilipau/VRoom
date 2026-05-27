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
    final token = _extractQrToken(rawValue);
    if (token == null) {
      throw const ApiException(
        message: 'QR-код не распознан. Попробуйте отсканировать его ещё раз.',
        code: 'qr_invalid',
      );
    }

    final resolveJson = await _resolveQr(token);
    final questId =
        _extractQuestId(resolveJson) ??
        (throw const ApiException(
          message: 'QR не привязан к квесту',
          code: 'qr_not_found',
        ));
    final eventId = _extractEventId(resolveJson);
    final sessionId = await _startAndPingScan(token: token);
    await _dio.get<dynamic>('/api/quests/$questId/bundle');

    return QrScanResultEntity(
      questId: questId,
      eventId: eventId,
      scanSessionId: sessionId,
    );
  }

  String? _extractQrToken(String rawValue) {
    final value = rawValue.trim();
    if (value.isEmpty) {
      return null;
    }

    final parts = value.split(':');
    if (parts.length == 3 && parts.first == 'vr-quest-quest') {
      final token = parts.last.trim();
      return _isUuid(token) ? token : null;
    }

    return _isUuid(value) ? value : null;
  }

  bool _isUuid(String value) {
    return RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
    ).hasMatch(value.trim());
  }

  Future<Map<String, dynamic>> _resolveQr(String token) async {
    final payload = {'qr_token': token};

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
      fallbackMessage: 'QR-код не найден или больше не активен',
      code: 'qr_not_found',
    );
  }

  Future<String?> _startAndPingScan({required String token}) async {
    try {
      final startResponse = await _dio.post<dynamic>(
        '/api/scan/start',
        data: {'token': token},
      );
      final startJson = asMap(startResponse.data);
      final rawSessionId =
          startJson['session_id'] ?? startJson['sessionId'] ?? startJson['id'];
      final sessionId = readString(rawSessionId);

      if (sessionId != null) {
        await _dio.post<dynamic>(
          '/api/scan/ping',
          data: {'session_id': readInt(rawSessionId) ?? sessionId},
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
