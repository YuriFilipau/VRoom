part of 'qr_scanner_bloc.dart';

enum QrScannerStatus { idle, resolving, success, failure }

final class QrScannerState extends Equatable {
  const QrScannerState({
    this.status = QrScannerStatus.idle,
    this.eventCode,
    this.errorMessage,
  });

  final QrScannerStatus status;
  final String? eventCode;
  final String? errorMessage;

  QrScannerState copyWith({
    QrScannerStatus? status,
    String? eventCode,
    String? errorMessage,
    bool clearEventCode = false,
    bool clearErrorMessage = false,
  }) {
    return QrScannerState(
      status: status ?? this.status,
      eventCode: clearEventCode ? null : eventCode ?? this.eventCode,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, eventCode, errorMessage];
}
