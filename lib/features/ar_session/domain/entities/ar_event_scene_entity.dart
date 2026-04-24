import 'package:equatable/equatable.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_placement_entity.dart';

class ArEventSceneEntity extends Equatable {
  const ArEventSceneEntity({
    required this.eventCode,
    required this.title,
    required this.assets,
    required this.placements,
    this.sceneAnchorName,
    this.sceneCloudAnchorId,
    this.sceneAnchorTransform,
    this.sceneAnchorTtl,
  });

  final String eventCode;
  final String title;
  final List<ArAssetEntity> assets;
  final List<ArAssetPlacementEntity> placements;
  final String? sceneAnchorName;
  final String? sceneCloudAnchorId;
  final List<double>? sceneAnchorTransform;
  final int? sceneAnchorTtl;

  @override
  List<Object?> get props => [
    eventCode,
    title,
    assets,
    placements,
    sceneAnchorName,
    sceneCloudAnchorId,
    sceneAnchorTransform,
    sceneAnchorTtl,
  ];
}
