import 'package:freezed_annotation/freezed_annotation.dart';

part 'ar_asset_placement_entity.freezed.dart';
part 'ar_asset_placement_entity.g.dart';

@freezed
abstract class ArAssetPlacementEntity with _$ArAssetPlacementEntity {
  const factory ArAssetPlacementEntity({
    required String id,
    required int assetId,
    required String nodeName,
    required List<double> localTransform,
  }) = _ArAssetPlacementEntity;

  factory ArAssetPlacementEntity.fromJson(Map<String, dynamic> json) =>
      _$ArAssetPlacementEntityFromJson(json);
}
