part of 'qr_scanner_bloc.dart';

enum QrScannerStatus { idle, resolving, success, failure }

@freezed
abstract class QrScannerState with _$QrScannerState {
  const factory QrScannerState({
    @Default(QrScannerStatus.idle) QrScannerStatus status,
    int? questId,
    int? eventId,
    String? scanSessionId,
    String? errorMessage,
  }) = _QrScannerState;
}
