import 'package:equatable/equatable.dart';

class ArAssetEntity extends Equatable {
  const ArAssetEntity({
    required this.id,
    required this.name,
    required this.modelUri,
    required this.scale,
    required this.previewIcon,
  });

  final String id;
  final String name;
  final String modelUri;
  final double scale;
  final ArAssetPreviewIcon previewIcon;

  @override
  List<Object?> get props => [id, name, modelUri, scale, previewIcon];
}

enum ArAssetPreviewIcon { cube, globe, rocket }
