import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_placement_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_session_mode.dart';
import 'package:vroom/features/ar_session/domain/usecases/get_ar_event_usecase.dart';
import 'package:vroom/features/ar_session/domain/usecases/save_ar_layout_usecase.dart';

part 'ar_session_event.dart';
part 'ar_session_state.dart';

class ArSessionBloc extends Bloc<ArSessionEvent, ArSessionState> {
  ArSessionBloc({
    required GetArEventUseCase getArEventUseCase,
    required SaveArLayoutUseCase saveArLayoutUseCase,
  }) : _getArEventUseCase = getArEventUseCase,
       _saveArLayoutUseCase = saveArLayoutUseCase,
       super(const ArSessionState()) {
    on<ArSessionLoadRequested>(_onLoadRequested);
    on<ArSessionAssetSelected>(_onAssetSelected);
    on<ArSessionPlacementUpserted>(_onPlacementUpserted);
    on<ArSessionSaveRequested>(_onSaveRequested);
    on<ArSessionSnackbarConsumed>(_onSnackbarConsumed);
  }

  final GetArEventUseCase _getArEventUseCase;
  final SaveArLayoutUseCase _saveArLayoutUseCase;

  Future<void> _onLoadRequested(
    ArSessionLoadRequested event,
    Emitter<ArSessionState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ArSessionStatus.loading,
        eventCode: event.eventCode,
        mode: event.mode,
        clearMessage: true,
      ),
    );

    try {
      final scene = await _getArEventUseCase(
        eventCode: event.eventCode,
        mode: event.mode,
      );

      emit(
        state.copyWith(
          status: ArSessionStatus.ready,
          mode: event.mode,
          eventCode: scene.eventCode,
          eventTitle: scene.title,
          assets: scene.assets,
          placements: scene.placements,
          selectedAssetId: scene.assets.isEmpty ? null : scene.assets.first.id,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ArSessionStatus.failure,
          message: 'Не удалось загрузить AR-сцену',
        ),
      );
    }
  }

  void _onAssetSelected(
    ArSessionAssetSelected event,
    Emitter<ArSessionState> emit,
  ) {
    emit(state.copyWith(selectedAssetId: event.assetId, clearMessage: true));
  }

  void _onPlacementUpserted(
    ArSessionPlacementUpserted event,
    Emitter<ArSessionState> emit,
  ) {
    final nextPlacements = [...state.placements];
    final index = nextPlacements.indexWhere(
      (placement) => placement.id == event.placement.id,
    );

    if (index == -1) {
      nextPlacements.add(event.placement);
    } else {
      nextPlacements[index] = event.placement;
    }

    emit(
      state.copyWith(
        status: ArSessionStatus.ready,
        placements: nextPlacements,
        clearMessage: true,
      ),
    );
  }

  Future<void> _onSaveRequested(
    ArSessionSaveRequested event,
    Emitter<ArSessionState> emit,
  ) async {
    emit(state.copyWith(status: ArSessionStatus.saving, clearMessage: true));

    try {
      await _saveArLayoutUseCase(
        eventCode: state.eventCode,
        placements: state.placements,
      );

      emit(
        state.copyWith(
          status: ArSessionStatus.saved,
          message: 'Сцена сохранена. Заглушка отправила данные в консоль.',
        ),
      );
      emit(state.copyWith(status: ArSessionStatus.ready, clearMessage: true));
    } catch (_) {
      emit(
        state.copyWith(
          status: ArSessionStatus.failure,
          message: 'Не удалось сохранить сцену',
        ),
      );
    }
  }

  void _onSnackbarConsumed(
    ArSessionSnackbarConsumed event,
    Emitter<ArSessionState> emit,
  ) {
    emit(state.copyWith(clearMessage: true));
  }
}
