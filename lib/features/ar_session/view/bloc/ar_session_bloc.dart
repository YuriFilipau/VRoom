import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vroom/core/network/api_exception.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_placement_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_scene_root_anchor_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_session_mode.dart';
import 'package:vroom/features/ar_session/domain/usecases/get_ar_scene_usecase.dart';
import 'package:vroom/features/ar_session/domain/usecases/save_ar_layout_usecase.dart';

part 'ar_session_bloc.freezed.dart';
part 'ar_session_event.dart';
part 'ar_session_state.dart';

class ArSessionBloc extends Bloc<ArSessionEvent, ArSessionState> {
  ArSessionBloc({
    required GetArSceneUseCase getArSceneUseCase,
    required SaveArLayoutUseCase saveArLayoutUseCase,
  }) : _getArSceneUseCase = getArSceneUseCase,
       _saveArLayoutUseCase = saveArLayoutUseCase,
       super(const ArSessionState()) {
    on<ArSessionLoadRequested>(_onLoadRequested);
    on<ArSessionAssetSelected>(_onAssetSelected);
    on<ArSessionPlacementUpserted>(_onPlacementUpserted);
    on<ArSessionSceneAnchorUpdated>(_onSceneAnchorUpdated);
    on<ArSessionSaveRequested>(_onSaveRequested);
    on<ArSessionSnackbarConsumed>(_onSnackbarConsumed);
  }

  final GetArSceneUseCase _getArSceneUseCase;
  final SaveArLayoutUseCase _saveArLayoutUseCase;

  Future<void> _onLoadRequested(
    ArSessionLoadRequested event,
    Emitter<ArSessionState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ArSessionStatus.loading,
        questId: event.questId,
        mode: event.mode,
        message: null,
      ),
    );

    try {
      final scene = await _getArSceneUseCase(
        questId: event.questId,
        mode: event.mode,
      );

      emit(
        state.copyWith(
          status: ArSessionStatus.ready,
          mode: event.mode,
          sceneId: scene.sceneId,
          questId: scene.questId,
          eventId: scene.eventId,
          eventTitle: scene.title,
          assets: scene.assets,
          placements: scene.objects,
          version: scene.version,
          updatedAt: scene.updatedAt,
          createdBy: scene.createdBy,
          isPublished: scene.isPublished,
          hasTest: scene.hasTest,
          rootAnchor: scene.rootAnchor,
          arcoreToken: scene.arcoreToken,
          selectedAssetId: scene.assets.isEmpty ? null : scene.assets.first.id,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(status: ArSessionStatus.failure, message: error.message),
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
    emit(state.copyWith(selectedAssetId: event.assetId, message: null));
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
        message: null,
      ),
    );
  }

  void _onSceneAnchorUpdated(
    ArSessionSceneAnchorUpdated event,
    Emitter<ArSessionState> emit,
  ) {
    final current = state.rootAnchor;
    final nextAnchorName = event.clearAnchorName
        ? ''
        : event.anchorName ?? current?.anchorName ?? '';
    final nextCloudAnchorId = event.clearCloudAnchorId
        ? ''
        : event.cloudAnchorId ?? current?.cloudAnchorId ?? '';
    final nextAnchorTransform = event.clearAnchorTransform
        ? const <double>[]
        : event.anchorTransform ?? current?.anchorTransform ?? const <double>[];
    final nextTtl = event.clearTtl ? 1 : event.ttl ?? current?.ttl ?? 1;
    final shouldClearRootAnchor =
        nextAnchorName.isEmpty && nextAnchorTransform.isEmpty;

    emit(
      state.copyWith(
        status: ArSessionStatus.ready,
        rootAnchor: shouldClearRootAnchor
            ? null
            : ArSceneRootAnchorEntity(
                anchorName: nextAnchorName,
                cloudAnchorId: nextCloudAnchorId,
                anchorTransform: nextAnchorTransform,
                ttl: nextTtl,
                platform: current?.platform,
              ),
        message: null,
      ),
    );
  }

  Future<void> _onSaveRequested(
    ArSessionSaveRequested event,
    Emitter<ArSessionState> emit,
  ) async {
    emit(state.copyWith(status: ArSessionStatus.saving, message: null));

    try {
      final savedScene = await _saveArLayoutUseCase(
        questId: state.questId,
        version: state.version,
        rootAnchor: state.rootAnchor,
        objects: state.placements,
      );

      emit(
        state.copyWith(
          status: ArSessionStatus.saved,
          sceneId: savedScene.sceneId,
          questId: savedScene.questId,
          eventId: savedScene.eventId,
          eventTitle: savedScene.title,
          placements: savedScene.objects,
          assets: savedScene.assets,
          version: savedScene.version,
          updatedAt: savedScene.updatedAt,
          createdBy: savedScene.createdBy,
          isPublished: savedScene.isPublished,
          hasTest: savedScene.hasTest,
          rootAnchor: savedScene.rootAnchor,
          arcoreToken: savedScene.arcoreToken,
          message: 'Сцена квеста сохранена.',
        ),
      );
      emit(state.copyWith(status: ArSessionStatus.ready, message: null));
    } on ApiException catch (error) {
      if (error.code == 'scene_version_conflict') {
        try {
          final latestScene = await _getArSceneUseCase(
            questId: state.questId,
            mode: state.mode,
          );
          emit(
            state.copyWith(
              status: ArSessionStatus.ready,
              sceneId: latestScene.sceneId,
              questId: latestScene.questId,
              eventId: latestScene.eventId,
              eventTitle: latestScene.title,
              assets: latestScene.assets,
              placements: latestScene.objects,
              version: latestScene.version,
              updatedAt: latestScene.updatedAt,
              createdBy: latestScene.createdBy,
              isPublished: latestScene.isPublished,
              hasTest: latestScene.hasTest,
              rootAnchor: latestScene.rootAnchor,
              arcoreToken: latestScene.arcoreToken,
              message:
                  'Сцена была изменена на сервере. Загружена последняя версия, можно повторить сохранение.',
            ),
          );
          return;
        } catch (_) {
          emit(
            state.copyWith(
              status: ArSessionStatus.failure,
              message:
                  'Конфликт версий сцены. Не удалось перезагрузить актуальную версию.',
            ),
          );
          return;
        }
      }
      emit(
        state.copyWith(status: ArSessionStatus.failure, message: error.message),
      );
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
    emit(state.copyWith(message: null));
  }
}
