import 'package:freezed_annotation/freezed_annotation.dart';

part 'ar_asset_entity.freezed.dart';

@freezed
abstract class ArAssetEntity with _$ArAssetEntity {
  const factory ArAssetEntity({
    required int id,
    required String name,
    required String modelUri,
    required double scale,
    @Default(1) double normalizationScale,
    required ArAssetPreviewIcon previewIcon,
    String? previewUrl,
  }) = _ArAssetEntity;
}

enum ArAssetPreviewIcon { cube, globe, rocket }
