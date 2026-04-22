part of 'ar_session_bloc.dart';

enum ArSessionStatus { initial, loading, ready, saving, saved, failure }

final class ArSessionState extends Equatable {
  const ArSessionState({
    this.status = ArSessionStatus.initial,
    this.mode = ArSessionMode.user,
    this.eventCode = '',
    this.eventTitle = '',
    this.assets = const [],
    this.placements = const [],
    this.selectedAssetId,
    this.message,
  });

  final ArSessionStatus status;
  final ArSessionMode mode;
  final String eventCode;
  final String eventTitle;
  final List<ArAssetEntity> assets;
  final List<ArAssetPlacementEntity> placements;
  final String? selectedAssetId;
  final String? message;

  bool get isAdmin => mode == ArSessionMode.admin;

  ArAssetEntity? get selectedAsset {
    if (assets.isEmpty) {
      return null;
    }
    if (selectedAssetId == null) {
      return assets.first;
    }
    return assets.where((asset) => asset.id == selectedAssetId).firstOrNull ??
        assets.first;
  }

  ArSessionState copyWith({
    ArSessionStatus? status,
    ArSessionMode? mode,
    String? eventCode,
    String? eventTitle,
    List<ArAssetEntity>? assets,
    List<ArAssetPlacementEntity>? placements,
    String? selectedAssetId,
    String? message,
    bool clearMessage = false,
  }) {
    return ArSessionState(
      status: status ?? this.status,
      mode: mode ?? this.mode,
      eventCode: eventCode ?? this.eventCode,
      eventTitle: eventTitle ?? this.eventTitle,
      assets: assets ?? this.assets,
      placements: placements ?? this.placements,
      selectedAssetId: selectedAssetId ?? this.selectedAssetId,
      message: clearMessage ? null : message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    status,
    mode,
    eventCode,
    eventTitle,
    assets,
    placements,
    selectedAssetId,
    message,
  ];
}
