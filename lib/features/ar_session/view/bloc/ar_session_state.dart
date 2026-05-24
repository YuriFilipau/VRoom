part of 'ar_session_bloc.dart';

enum ArSessionStatus { initial, loading, ready, saving, saved, failure }

@freezed
abstract class ArSessionState with _$ArSessionState {
  const ArSessionState._();

  const factory ArSessionState({
    @Default(ArSessionStatus.initial) ArSessionStatus status,
    @Default(ArSessionMode.user) ArSessionMode mode,
    @Default('') String sceneId,
    @Default(0) int questId,
    @Default(0) int eventId,
    @Default('') String eventTitle,
    @Default([]) List<ArAssetEntity> assets,
    @Default([]) List<ArAssetPlacementEntity> placements,
    int? version,
    String? updatedAt,
    int? createdBy,
    @Default(false) bool isPublished,
    ArSceneRootAnchorEntity? rootAnchor,
    String? arcoreToken,
    int? selectedAssetId,
    String? message,
  }) = _ArSessionState;

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
}
