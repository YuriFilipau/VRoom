import 'package:freezed_annotation/freezed_annotation.dart';

part 'ar_scene_root_anchor_entity.freezed.dart';
part 'ar_scene_root_anchor_entity.g.dart';

@freezed
abstract class ArSceneRootAnchorEntity with _$ArSceneRootAnchorEntity {
  const factory ArSceneRootAnchorEntity({
    required String anchorName,
    required String cloudAnchorId,
    required List<double> anchorTransform,
    required int ttl,
    required String? platform,
  }) = _ArSceneRootAnchorEntity;

  factory ArSceneRootAnchorEntity.fromJson(Map<String, dynamic> json) =>
      _$ArSceneRootAnchorEntityFromJson(json);
}
