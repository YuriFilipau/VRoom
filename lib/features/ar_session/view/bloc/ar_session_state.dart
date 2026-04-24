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
    this.sceneAnchorName,
    this.sceneCloudAnchorId,
    this.sceneAnchorTransform,
    this.sceneAnchorTtl,
    this.selectedAssetId,
    this.message,
  });

  final ArSessionStatus status;
  final ArSessionMode mode;
  final String eventCode;
  final String eventTitle;
  final List<ArAssetEntity> assets;
  final List<ArAssetPlacementEntity> placements;
  final String? sceneAnchorName;
  final String? sceneCloudAnchorId;
  final List<double>? sceneAnchorTransform;
  final int? sceneAnchorTtl;
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
    String? sceneAnchorName,
    String? sceneCloudAnchorId,
    List<double>? sceneAnchorTransform,
    int? sceneAnchorTtl,
    bool clearSceneAnchorName = false,
    bool clearSceneCloudAnchorId = false,
    bool clearSceneAnchorTransform = false,
    bool clearSceneAnchorTtl = false,
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
      sceneAnchorName: clearSceneAnchorName
          ? null
          : sceneAnchorName ?? this.sceneAnchorName,
      sceneCloudAnchorId: clearSceneCloudAnchorId
          ? null
          : sceneCloudAnchorId ?? this.sceneCloudAnchorId,
      sceneAnchorTransform: clearSceneAnchorTransform
          ? null
          : sceneAnchorTransform ?? this.sceneAnchorTransform,
      sceneAnchorTtl: clearSceneAnchorTtl
          ? null
          : sceneAnchorTtl ?? this.sceneAnchorTtl,
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
    sceneAnchorName,
    sceneCloudAnchorId,
    sceneAnchorTransform,
    sceneAnchorTtl,
    selectedAssetId,
    message,
  ];
}
