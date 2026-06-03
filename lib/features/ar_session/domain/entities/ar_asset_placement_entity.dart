import 'package:freezed_annotation/freezed_annotation.dart';

part 'ar_asset_placement_entity.freezed.dart';
part 'ar_asset_placement_entity.g.dart';

@freezed
abstract class ArAssetPlacementEntity with _$ArAssetPlacementEntity {
  const ArAssetPlacementEntity._();

  const factory ArAssetPlacementEntity({
    required String id,
    required int assetId,
    required String nodeName,
    required List<double> localTransform,
    @Default({}) Map<String, dynamic> meta,
  }) = _ArAssetPlacementEntity;

  factory ArAssetPlacementEntity.fromJson(Map<String, dynamic> json) =>
      _$ArAssetPlacementEntityFromJson(json);

  String? get role {
    final value = meta['role'];
    return value is String ? value : null;
  }

  bool get isTestAnchor {
    return role == 'test_anchor' ||
        meta['isTestAnchor'] == true ||
        id == 'test_anchor' ||
        nodeName == 'test_anchor';
  }

  bool get isFinishAnchor {
    return role == 'finish_anchor' ||
        meta['isFinishAnchor'] == true ||
        id == 'finish_anchor' ||
        nodeName == 'finish_anchor';
  }

  bool get isActionAnchor => isTestAnchor || isFinishAnchor;
}
