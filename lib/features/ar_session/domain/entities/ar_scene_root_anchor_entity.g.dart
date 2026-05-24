// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ar_scene_root_anchor_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ArSceneRootAnchorEntity _$ArSceneRootAnchorEntityFromJson(
  Map<String, dynamic> json,
) => _ArSceneRootAnchorEntity(
  anchorName: json['anchorName'] as String,
  cloudAnchorId: json['cloudAnchorId'] as String,
  anchorTransform: (json['anchorTransform'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
  ttl: (json['ttl'] as num).toInt(),
  platform: json['platform'] as String?,
);

Map<String, dynamic> _$ArSceneRootAnchorEntityToJson(
  _ArSceneRootAnchorEntity instance,
) => <String, dynamic>{
  'anchorName': instance.anchorName,
  'cloudAnchorId': instance.cloudAnchorId,
  'anchorTransform': instance.anchorTransform,
  'ttl': instance.ttl,
  'platform': instance.platform,
};
