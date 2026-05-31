import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vroom/core/network/api_exception.dart';
import 'package:vroom/features/qr_scanner/domain/usecases/process_qr_code_usecase.dart';

part 'qr_scanner_bloc.freezed.dart';
part 'qr_scanner_event.dart';
part 'qr_scanner_state.dart';

class QrScannerBloc extends Bloc<QrScannerEvent, QrScannerState> {
  QrScannerBloc({required ProcessQrCodeUseCase processQrCodeUseCase})
    : _processQrCodeUseCase = processQrCodeUseCase,
      super(const QrScannerState()) {
    on<QrScannerDetected>(_onDetected);
    on<QrScannerReset>(_onReset);
  }

  final ProcessQrCodeUseCase _processQrCodeUseCase;

  Future<void> _onDetected(
    QrScannerDetected event,
    Emitter<QrScannerState> emit,
  ) async {
    if (state.status != QrScannerStatus.idle) {
      return;
    }

    emit(state.copyWith(status: QrScannerStatus.resolving, errorMessage: null));

    try {
      final result = await _processQrCodeUseCase(event.rawValue);
      emit(
        state.copyWith(
          status: QrScannerStatus.success,
          questId: result.questId,
          eventId: result.eventId,
          scanSessionId: result.scanSessionId,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          status: QrScannerStatus.failure,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: QrScannerStatus.failure,
          errorMessage: 'Не удалось обработать QR-код',
        ),
      );
    }
  }

  void _onReset(QrScannerReset event, Emitter<QrScannerState> emit) {
    emit(
      state.copyWith(
        status: QrScannerStatus.idle,
        questId: null,
        eventId: null,
        scanSessionId: null,
        errorMessage: null,
      ),
    );
  }
}
