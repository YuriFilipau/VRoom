part of 'ar_session_bloc.dart';

@freezed
class ArSessionEvent with _$ArSessionEvent {
  const factory ArSessionEvent.loadRequested({
    required int questId,
    required ArSessionMode mode,
  }) = ArSessionLoadRequested;

  const factory ArSessionEvent.assetSelected(int assetId) =
      ArSessionAssetSelected;

  const factory ArSessionEvent.placementSelected(String? placementId) =
      ArSessionPlacementSelected;

  const factory ArSessionEvent.placementUpserted(
    ArAssetPlacementEntity placement,
  ) = ArSessionPlacementUpserted;

  const factory ArSessionEvent.placementScaleChanged({
    required String placementId,
    required double scale,
  }) = ArSessionPlacementScaleChanged;

  const factory ArSessionEvent.placementRemoved(String placementId) =
      ArSessionPlacementRemoved;

  const factory ArSessionEvent.finishAnchorAdded() = ArSessionFinishAnchorAdded;

  const factory ArSessionEvent.finishAnchorRemoved() =
      ArSessionFinishAnchorRemoved;

  const factory ArSessionEvent.sceneAnchorUpdated({
    String? anchorName,
    String? cloudAnchorId,
    List<double>? anchorTransform,
    int? ttl,
    @Default(false) bool clearCloudAnchorId,
    @Default(false) bool clearAnchorTransform,
    @Default(false) bool clearAnchorName,
    @Default(false) bool clearTtl,
  }) = ArSessionSceneAnchorUpdated;

  const factory ArSessionEvent.saveRequested() = ArSessionSaveRequested;

  const factory ArSessionEvent.anchorReached({
    required String anchorId,
    String? sessionId,
  }) = ArSessionAnchorReached;

  const factory ArSessionEvent.anchorReachResultConsumed() =
      ArSessionAnchorReachResultConsumed;

  const factory ArSessionEvent.snackbarConsumed() = ArSessionSnackbarConsumed;
}
