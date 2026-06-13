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
  final title = _readHumanReadableTitle(placement.meta['title']);
  if (title != null) {
    return title;
  }
  final displayName =
      _readHumanReadableTitle(placement.meta['display_name']) ??
      _readHumanReadableTitle(placement.meta['displayName']) ??
      _readHumanReadableTitle(placement.meta['name']) ??
      _readHumanReadableTitle(placement.meta['label']);
  if (displayName != null) {
    return displayName;
  }
  if (placement.isTestAnchor) {
    return 'Точка начала теста';
  }
  if (placement.isFinishAnchor) {
    return 'Точка окончания квеста';
  }
  final assetName = _readHumanReadableTitle(asset?.name);
  if (assetName != null) {
    return assetName;
  }
  if (asset != null && asset.id > 0) {
    return 'Модель ${asset.id}';
  }
  return _readHumanReadableTitle(placement.nodeName) ?? 'Модель';
}

String? _readHumanReadableTitle(dynamic raw) {
  if (raw is! String) {
    return null;
  }
  final value = raw.trim();
  if (value.isEmpty || _looksLikeModelFilename(value)) {
    return null;
  }
  return value;
}

bool _looksLikeModelFilename(String value) {
  final normalized = value.trim().toLowerCase();
  return normalized.endsWith('.glb') ||
      normalized.endsWith('.gltf') ||
      normalized.contains('.glb?') ||
      normalized.contains('.gltf?') ||
      normalized.startsWith('ar_asset_');
}
