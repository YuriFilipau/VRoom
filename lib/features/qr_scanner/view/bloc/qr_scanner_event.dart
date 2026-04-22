part of 'qr_scanner_bloc.dart';

sealed class QrScannerEvent {
  const QrScannerEvent();
}

final class QrScannerDetected extends QrScannerEvent {
  const QrScannerDetected(this.rawValue);

  final String rawValue;
}

final class QrScannerReset extends QrScannerEvent {
  const QrScannerReset();
}
