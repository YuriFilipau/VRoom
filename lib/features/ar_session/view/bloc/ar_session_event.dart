part of 'ar_session_bloc.dart';

@freezed
class ArSessionEvent with _$ArSessionEvent {
  const factory ArSessionEvent.loadRequested({
    required int questId,
    required ArSessionMode mode,
  }) = ArSessionLoadRequested;

  const factory ArSessionEvent.assetSelected(int assetId) =
      ArSessionAssetSelected;

  const factory ArSessionEvent.placementUpserted(
    ArAssetPlacementEntity placement,
  ) = ArSessionPlacementUpserted;

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

  const factory ArSessionEvent.snackbarConsumed() = ArSessionSnackbarConsumed;
}
