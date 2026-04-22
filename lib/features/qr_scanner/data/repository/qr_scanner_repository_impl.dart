import 'package:vroom/features/qr_scanner/domain/repository/qr_scanner_repository.dart';

class QrScannerRepositoryImpl implements QrScannerRepository {
  @override
  Future<String> resolveEventCode(String rawValue) async {
    final value = rawValue.trim();
    await Future<void>.delayed(const Duration(milliseconds: 250));

    if (value.isEmpty) {
      throw const FormatException('QR-код пустой');
    }

    final uri = Uri.tryParse(value);
    if (uri != null) {
      final eventCode = uri.queryParameters['event'];
      if (eventCode != null && eventCode.isNotEmpty) {
        return eventCode;
      }

      final segments = uri.pathSegments.where((segment) => segment.isNotEmpty);
      if (segments.isNotEmpty) {
        return segments.last;
      }
    }

    return value;
  }
}
