// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ar_asset_placement_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ArAssetPlacementEntity _$ArAssetPlacementEntityFromJson(
  Map<String, dynamic> json,
) => _ArAssetPlacementEntity(
  id: json['id'] as String,
  assetId: (json['assetId'] as num).toInt(),
  nodeName: json['nodeName'] as String,
  localTransform: (json['localTransform'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
);

Map<String, dynamic> _$ArAssetPlacementEntityToJson(
  _ArAssetPlacementEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'assetId': instance.assetId,
  'nodeName': instance.nodeName,
  'localTransform': instance.localTransform,
};
