import 'package:equatable/equatable.dart';

class ArAssetPlacementEntity extends Equatable {
  const ArAssetPlacementEntity({
    required this.id,
    required this.assetId,
    required this.nodeName,
    required this.transform,
    this.anchorTransform,
    this.anchorName,
    this.cloudAnchorId,
    this.ttl,
  });

  final String id;
  final String assetId;
  final String nodeName;
  final List<double> transform;
  final List<double>? anchorTransform;
  final String? anchorName;
  final String? cloudAnchorId;
  final int? ttl;

  ArAssetPlacementEntity copyWith({
    String? id,
    String? assetId,
    String? nodeName,
    List<double>? transform,
    List<double>? anchorTransform,
    String? anchorName,
    String? cloudAnchorId,
    int? ttl,
  }) {
    return ArAssetPlacementEntity(
      id: id ?? this.id,
      assetId: assetId ?? this.assetId,
      nodeName: nodeName ?? this.nodeName,
      transform: transform ?? this.transform,
      anchorTransform: anchorTransform ?? this.anchorTransform,
      anchorName: anchorName ?? this.anchorName,
      cloudAnchorId: cloudAnchorId ?? this.cloudAnchorId,
      ttl: ttl ?? this.ttl,
    );
  }

  factory ArAssetPlacementEntity.fromJson(Map<String, dynamic> json) {
    return ArAssetPlacementEntity(
      id: json['id'] as String,
      assetId: json['assetId'] as String,
      nodeName: json['nodeName'] as String,
      transform: (json['transform'] as List<dynamic>)
          .map((value) => (value as num).toDouble())
          .toList(),
      anchorTransform: (json['anchorTransform'] as List<dynamic>?)
          ?.map((value) => (value as num).toDouble())
          .toList(),
      anchorName: json['anchorName'] as String?,
      cloudAnchorId: json['cloudAnchorId'] as String?,
      ttl: json['ttl'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'assetId': assetId,
      'nodeName': nodeName,
      'transform': transform,
      'anchorTransform': anchorTransform,
      'anchorName': anchorName,
      'cloudAnchorId': cloudAnchorId,
      'ttl': ttl,
    };
  }

  @override
  List<Object?> get props => [
    id,
    assetId,
    nodeName,
    transform,
    anchorTransform,
    anchorName,
    cloudAnchorId,
    ttl,
  ];
}
