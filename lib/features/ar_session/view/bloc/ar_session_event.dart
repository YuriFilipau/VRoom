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

final class ArSessionSaveRequested extends ArSessionEvent {
  const ArSessionSaveRequested();
}

final class ArSessionSnackbarConsumed extends ArSessionEvent {
  const ArSessionSnackbarConsumed();
}
