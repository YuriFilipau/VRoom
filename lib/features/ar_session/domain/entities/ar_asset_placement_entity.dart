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
    return _normalizedPlacementToken(
      _firstPlacementString([
        meta['role'],
        meta['anchor_role'],
        meta['anchorRole'],
      ]),
    );
  }

  bool get isTestAnchor {
    final interactionType = _interactionType;
    final actionType = _actionType;
    return _isTestAnchorToken(role) ||
        _isTestAnchorToken(interactionType) ||
        _isTestAnchorToken(actionType) ||
        _isTestAnchorToken(_normalizedPlacementToken(id)) ||
        _isTestAnchorToken(_normalizedPlacementToken(nodeName)) ||
        meta['isTestAnchor'] == true ||
        meta['is_test_anchor'] == true;
  }

  bool get isFinishAnchor {
    final interactionType = _interactionType;
    final actionType = _actionType;
    return _isFinishAnchorToken(role) ||
        _isFinishAnchorToken(interactionType) ||
        _isFinishAnchorToken(actionType) ||
        _isFinishAnchorToken(_normalizedPlacementToken(id)) ||
        _isFinishAnchorToken(_normalizedPlacementToken(nodeName)) ||
        meta['isFinishAnchor'] == true ||
        meta['is_finish_anchor'] == true;
  }

  bool get isActionAnchor => isTestAnchor || isFinishAnchor;

  String? get _interactionType {
    return _normalizedPlacementToken(
      _firstPlacementString([
        meta['interaction_type'],
        meta['interactionType'],
        meta['type'],
      ]),
    );
  }

  String? get _actionType {
    final action = _placementMap(meta['action']);
    return _normalizedPlacementToken(
      _firstPlacementString([
        meta['action_type'],
        meta['actionType'],
        action['type'],
        action['interaction_type'],
        action['interactionType'],
      ]),
    );
  }
}

String? _firstPlacementString(Iterable<dynamic> values) {
  for (final value in values) {
    final parsed = _placementString(value);
    if (parsed != null) {
      return parsed;
    }
  }
  return null;
}

String? _placementString(dynamic value) {
  if (value is String) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
  if (value is num) {
    return value.toString();
  }
  return null;
}

String? _normalizedPlacementToken(dynamic value) {
  final raw = _placementString(value);
  if (raw == null) {
    return null;
  }

  return raw.toLowerCase().replaceAll('-', '_').replaceAll(' ', '_');
}

Map<String, dynamic> _placementMap(dynamic value) {
  if (value is! Map) {
    return const <String, dynamic>{};
  }

  return value.map((key, value) => MapEntry(key.toString(), value));
}

bool _isTestAnchorToken(String? value) {
  return switch (value) {
    'test_anchor' ||
    'test' ||
    'start_anchor' ||
    'start' ||
    'test_start' ||
    'unlock_test' ||
    'begin_test' => true,
    _ => false,
  };
}

bool _isFinishAnchorToken(String? value) {
  return switch (value) {
    'finish_anchor' ||
    'finish' ||
    'finish_point' ||
    'quest_finish' ||
    'complete_quest' ||
    'completion_anchor' => true,
    _ => false,
  };
}
