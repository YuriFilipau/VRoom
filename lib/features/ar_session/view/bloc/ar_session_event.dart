part of 'ar_session_bloc.dart';

sealed class ArSessionEvent {
  const ArSessionEvent();
}

final class ArSessionLoadRequested extends ArSessionEvent {
  const ArSessionLoadRequested({required this.eventCode, required this.mode});

  final String eventCode;
  final ArSessionMode mode;
}

final class ArSessionAssetSelected extends ArSessionEvent {
  const ArSessionAssetSelected(this.assetId);

  final String assetId;
}

final class ArSessionPlacementUpserted extends ArSessionEvent {
  const ArSessionPlacementUpserted(this.placement);

  final ArAssetPlacementEntity placement;
}

final class ArSessionSceneAnchorUpdated extends ArSessionEvent {
  const ArSessionSceneAnchorUpdated({
    this.anchorName,
    this.cloudAnchorId,
    this.anchorTransform,
    this.ttl,
    this.clearCloudAnchorId = false,
    this.clearAnchorTransform = false,
    this.clearAnchorName = false,
    this.clearTtl = false,
  });

  final String? anchorName;
  final String? cloudAnchorId;
  final List<double>? anchorTransform;
  final int? ttl;
  final bool clearCloudAnchorId;
  final bool clearAnchorTransform;
  final bool clearAnchorName;
  final bool clearTtl;
}

final class ArSessionSaveRequested extends ArSessionEvent {
  const ArSessionSaveRequested();
}

final class ArSessionSnackbarConsumed extends ArSessionEvent {
  const ArSessionSnackbarConsumed();
}
