import 'package:vector_math/vector_math_64.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_entity.dart';
import 'package:vroom/features/ar_session/domain/entities/ar_asset_placement_entity.dart';

double arPlacementScale(ArAssetPlacementEntity placement) {
  final rawScale = placement.meta['scale'];
  if (rawScale is num) {
    return rawScale.toDouble();
  }
  if (rawScale is String) {
    final parsed = double.tryParse(rawScale);
    if (parsed != null) {
      return parsed;
    }
  }
  if (placement.localTransform.length != 16) {
    return 1;
  }

  final scale = Vector3.zero();
  Matrix4.fromList(
    placement.localTransform,
  ).decompose(Vector3.zero(), Quaternion.identity(), scale);
  return scale.x <= 0 ? 1 : scale.x;
}

String arPlacementTitle(
  ArAssetPlacementEntity placement,
  ArAssetEntity? asset,
) {
  final title = placement.meta['title'];
  if (title is String && title.trim().isNotEmpty) {
    return title.trim();
  }
  if (placement.isTestAnchor) {
    return 'Точка начала теста';
  }
  if (placement.isFinishAnchor) {
    return 'Точка окончания квеста';
  }
  return asset?.name ?? placement.nodeName;
}
