import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vroom/core/network/api_exception.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_anchor_reach_result_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_placement_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_quest_scene_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_scene_root_anchor_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_session_mode.dart';
import 'package:vroom/features/ar_session/domain/usecases/get_ar_scene_usecase.dart';
import 'package:vroom/features/ar_session/domain/usecases/mark_ar_anchor_reached_usecase.dart';
import 'package:vroom/features/ar_session/domain/usecases/save_ar_layout_usecase.dart';

part 'ar_session_bloc.freezed.dart';
part 'ar_session_event.dart';
part 'ar_session_state.dart';

class ArSessionBloc extends Bloc<ArSessionEvent, ArSessionState> {
  ArSessionBloc({
    required GetArSceneUseCase getArSceneUseCase,
    required SaveArLayoutUseCase saveArLayoutUseCase,
    required MarkArAnchorReachedUseCase markAnchorReachedUseCase,
  }) : _getArSceneUseCase = getArSceneUseCase,
       _saveArLayoutUseCase = saveArLayoutUseCase,
       _markAnchorReachedUseCase = markAnchorReachedUseCase,
       super(const ArSessionState()) {
    on<ArSessionLoadRequested>(_onLoadRequested);
    on<ArSessionAssetSelected>(_onAssetSelected);
    on<ArSessionPlacementSelected>(_onPlacementSelected);
    on<ArSessionPlacementUpserted>(_onPlacementUpserted);
    on<ArSessionPlacementScaleChanged>(_onPlacementScaleChanged);
    on<ArSessionPlacementRemoved>(_onPlacementRemoved);
    on<ArSessionFinishAnchorAdded>(_onFinishAnchorAdded);
    on<ArSessionFinishAnchorRemoved>(_onFinishAnchorRemoved);
    on<ArSessionSceneAnchorUpdated>(_onSceneAnchorUpdated);
    on<ArSessionSaveRequested>(_onSaveRequested);
    on<ArSessionAnchorReached>(_onAnchorReached);
    on<ArSessionAnchorReachResultConsumed>(_onAnchorReachResultConsumed);
    on<ArSessionSnackbarConsumed>(_onSnackbarConsumed);
  }

  final GetArSceneUseCase _getArSceneUseCase;
  final SaveArLayoutUseCase _saveArLayoutUseCase;
  final MarkArAnchorReachedUseCase _markAnchorReachedUseCase;

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
      final placements = _placementsWithRequiredAnchors(
        scene,
        createMissingTestAnchor: event.mode == ArSessionMode.admin,
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
          placements: placements,
          version: scene.version,
          updatedAt: scene.updatedAt,
          createdBy: scene.createdBy,
          isPublished: scene.isPublished,
          hasTest: scene.hasTest,
          rootAnchor: scene.rootAnchor,
          arcoreToken: scene.arcoreToken,
          selectedAssetId: scene.assets.isEmpty ? null : scene.assets.first.id,
          selectedPlacementId: null,
          interactiveProgressCompleted: null,
          interactiveProgressTotal: null,
          anchorReachResult: null,
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
    emit(
      state.copyWith(
        selectedAssetId: event.assetId,
        selectedPlacementId: null,
        message: null,
      ),
    );
  }

  void _onPlacementSelected(
    ArSessionPlacementSelected event,
    Emitter<ArSessionState> emit,
  ) {
    emit(state.copyWith(selectedPlacementId: event.placementId, message: null));
  }

  void _onPlacementUpserted(
    ArSessionPlacementUpserted event,
    Emitter<ArSessionState> emit,
  ) {
    final nextPlacements = [...state.placements];
    final index = nextPlacements.indexWhere((placement) {
      if (event.placement.isTestAnchor) {
        return placement.isTestAnchor;
      }
      if (event.placement.isFinishAnchor) {
        return placement.isFinishAnchor;
      }
      return placement.id == event.placement.id;
    });

    if (index == -1) {
      nextPlacements.add(event.placement);
    } else {
      nextPlacements[index] = event.placement;
    }

    emit(
      state.copyWith(
        status: ArSessionStatus.ready,
        placements: nextPlacements,
        selectedPlacementId: event.placement.id,
        message: null,
      ),
    );
  }

  void _onPlacementScaleChanged(
    ArSessionPlacementScaleChanged event,
    Emitter<ArSessionState> emit,
  ) {
    final scale = event.scale.clamp(0.1, 10.0).toDouble();
    final nextPlacements = [...state.placements];
    final index = nextPlacements.indexWhere(
      (placement) => placement.id == event.placementId,
    );
    if (index == -1) {
      return;
    }

    final placement = nextPlacements[index];
    nextPlacements[index] = placement.copyWith(
      meta: {...placement.meta, 'scale': scale},
    );

    emit(
      state.copyWith(
        status: ArSessionStatus.ready,
        placements: nextPlacements,
        selectedPlacementId: event.placementId,
        message: null,
      ),
    );
  }

  void _onPlacementRemoved(
    ArSessionPlacementRemoved event,
    Emitter<ArSessionState> emit,
  ) {
    final placement = state.placements
        .where((item) => item.id == event.placementId)
        .firstOrNull;
    if (placement == null) {
      return;
    }

    if (state.hasTest && placement.isTestAnchor) {
      emit(
        state.copyWith(
          status: ArSessionStatus.ready,
          message:
              'Точку начала теста нельзя удалить, пока у квеста включён тест.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: ArSessionStatus.ready,
        placements: state.placements
            .where((item) => item.id != event.placementId)
            .toList(growable: false),
        selectedPlacementId: state.selectedPlacementId == event.placementId
            ? null
            : state.selectedPlacementId,
        message: null,
      ),
    );
  }

  void _onFinishAnchorAdded(
    ArSessionFinishAnchorAdded event,
    Emitter<ArSessionState> emit,
  ) {
    if (state.hasTest) {
      emit(
        state.copyWith(
          status: ArSessionStatus.ready,
          message:
              'Для квеста с тестом используется точка начала теста, точка завершения не требуется.',
        ),
      );
      return;
    }

    if (state.placements.any((item) => item.isFinishAnchor)) {
      return;
    }

    emit(
      state.copyWith(
        status: ArSessionStatus.ready,
        placements: [
          ...state.placements,
          _buildActionAnchor(
            id: 'finish_anchor',
            assetId: state.assets.firstOrNull?.id ?? 0,
            title: 'Точка окончания квеста',
            actionType: 'complete_quest',
            actionLabel: 'Завершить квест',
            presentation: 'fullscreen_dialog',
          ),
        ],
        selectedPlacementId: 'finish_anchor',
        message: null,
      ),
    );
  }

  void _onFinishAnchorRemoved(
    ArSessionFinishAnchorRemoved event,
    Emitter<ArSessionState> emit,
  ) {
    if (state.hasTest) {
      return;
    }

    emit(
      state.copyWith(
        status: ArSessionStatus.ready,
        placements: state.placements
            .where((item) => !item.isFinishAnchor)
            .toList(growable: false),
        selectedPlacementId: state.selectedPlacement?.isFinishAnchor == true
            ? null
            : state.selectedPlacementId,
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
          placements: _placementsWithRequiredAnchors(
            savedScene,
            createMissingTestAnchor: state.isAdmin,
          ),
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
              placements: _placementsWithRequiredAnchors(
                latestScene,
                createMissingTestAnchor: state.isAdmin,
              ),
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

  Future<void> _onAnchorReached(
    ArSessionAnchorReached event,
    Emitter<ArSessionState> emit,
  ) async {
    if (state.isAdmin || state.questId == 0) {
      return;
    }

    try {
      final result = await _markAnchorReachedUseCase(
        questId: state.questId,
        anchorId: event.anchorId,
        sessionId: event.sessionId,
        interactionType: event.interactionType,
        answerIndex: event.answerIndex,
      );
      emit(
        state.copyWith(
          status: ArSessionStatus.ready,
          anchorReachResult: result,
          interactiveProgressCompleted:
              result.progressCompleted ?? state.interactiveProgressCompleted,
          interactiveProgressTotal:
              result.progressTotal ?? state.interactiveProgressTotal,
          message: null,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(status: ArSessionStatus.ready, message: error.message),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ArSessionStatus.ready,
          message: 'Не удалось зафиксировать контрольную точку',
        ),
      );
    }
  }

  void _onAnchorReachResultConsumed(
    ArSessionAnchorReachResultConsumed event,
    Emitter<ArSessionState> emit,
  ) {
    emit(state.copyWith(anchorReachResult: null));
  }

  void _onSnackbarConsumed(
    ArSessionSnackbarConsumed event,
    Emitter<ArSessionState> emit,
  ) {
    emit(state.copyWith(message: null));
  }

  List<ArAssetPlacementEntity> _placementsWithRequiredAnchors(
    ArQuestSceneEntity scene, {
    required bool createMissingTestAnchor,
  }) {
    final placements = _dedupeActionAnchors(scene.objects);
    if (!scene.hasTest ||
        !createMissingTestAnchor ||
        placements.any((item) => item.isTestAnchor)) {
      return placements;
    }

    placements.add(
      _buildActionAnchor(
        id: 'test_anchor',
        assetId: scene.assets.firstOrNull?.id ?? 0,
        title: 'Точка начала теста',
        actionType: 'unlock_test',
        actionLabel: 'Начать тест',
        presentation: 'world_button',
      ),
    );
    return _dedupeActionAnchors(placements);
  }

  List<ArAssetPlacementEntity> _dedupeActionAnchors(
    List<ArAssetPlacementEntity> source,
  ) {
    ArAssetPlacementEntity? testAnchor;
    ArAssetPlacementEntity? finishAnchor;
    final placements = <ArAssetPlacementEntity>[];

    for (final placement in source) {
      if (placement.isTestAnchor) {
        testAnchor = _preferredActionAnchor(testAnchor, placement);
        continue;
      }
      if (placement.isFinishAnchor) {
        finishAnchor = _preferredActionAnchor(finishAnchor, placement);
        continue;
      }
      placements.add(placement);
    }

    if (testAnchor != null) {
      placements.add(testAnchor);
    }
    if (finishAnchor != null) {
      placements.add(finishAnchor);
    }
    return placements;
  }

  ArAssetPlacementEntity _preferredActionAnchor(
    ArAssetPlacementEntity? current,
    ArAssetPlacementEntity candidate,
  ) {
    if (current == null) {
      return candidate;
    }

    final currentIsDefault = _hasDefaultActionAnchorTransform(current);
    final candidateIsDefault = _hasDefaultActionAnchorTransform(candidate);
    if (currentIsDefault && !candidateIsDefault) {
      return candidate;
    }
    if (!currentIsDefault && candidateIsDefault) {
      return current;
    }
    return candidate;
  }

  bool _hasDefaultActionAnchorTransform(ArAssetPlacementEntity placement) {
    const defaultTransform = [
      1.0,
      0.0,
      0.0,
      0.0,
      0.0,
      1.0,
      0.0,
      0.0,
      0.0,
      0.0,
      1.0,
      0.0,
      0.0,
      0.0,
      -1.5,
      1.0,
    ];
    if (placement.localTransform.length != defaultTransform.length) {
      return true;
    }

    for (var index = 0; index < defaultTransform.length; index++) {
      if ((placement.localTransform[index] - defaultTransform[index]).abs() >
          0.0001) {
        return false;
      }
    }
    return true;
  }

  ArAssetPlacementEntity _buildActionAnchor({
    required String id,
    required int assetId,
    required String title,
    required String actionType,
    required String actionLabel,
    required String presentation,
  }) {
    return ArAssetPlacementEntity(
      id: id,
      assetId: assetId,
      nodeName: id,
      localTransform: const [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, -1.5, 1],
      meta: {
        'id': id,
        'role': id,
        'title': title,
        'action': {
          'type': actionType,
          'label': actionLabel,
          'presentation': presentation,
        },
      },
    );
  }
}
