import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vroom/features/qr_scanner/domain/usecases/resolve_qr_event_code_usecase.dart';

part 'qr_scanner_event.dart';
part 'qr_scanner_state.dart';

class QrScannerBloc extends Bloc<QrScannerEvent, QrScannerState> {
  QrScannerBloc({required ResolveQrEventCodeUseCase resolveQrEventCodeUseCase})
    : _resolveQrEventCodeUseCase = resolveQrEventCodeUseCase,
      super(const QrScannerState()) {
    on<QrScannerDetected>(_onDetected);
    on<QrScannerReset>(_onReset);
  }

  final ResolveQrEventCodeUseCase _resolveQrEventCodeUseCase;

  Future<void> _onDetected(
    QrScannerDetected event,
    Emitter<QrScannerState> emit,
  ) async {
    if (state.status == QrScannerStatus.resolving ||
        state.status == QrScannerStatus.success) {
      return;
    }

    emit(
      state.copyWith(
        status: QrScannerStatus.resolving,
        clearErrorMessage: true,
      ),
    );

    try {
      final eventCode = await _resolveQrEventCodeUseCase(event.rawValue);
      emit(
        state.copyWith(status: QrScannerStatus.success, eventCode: eventCode),
      );
    } on FormatException catch (error) {
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
          errorMessage: 'Не удалось распознать QR-код',
        ),
      );
    }
  }

  void _onReset(QrScannerReset event, Emitter<QrScannerState> emit) {
    emit(
      state.copyWith(
        status: QrScannerStatus.idle,
        clearEventCode: true,
        clearErrorMessage: true,
      ),
    );
  }
}
