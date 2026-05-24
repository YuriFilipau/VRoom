part of 'qr_scanner_bloc.dart';

@freezed
class QrScannerEvent with _$QrScannerEvent {
  const factory QrScannerEvent.detected(String rawValue) = QrScannerDetected;

  const factory QrScannerEvent.reset() = QrScannerReset;
}
