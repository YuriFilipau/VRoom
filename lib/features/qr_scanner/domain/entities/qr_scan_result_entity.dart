import 'package:freezed_annotation/freezed_annotation.dart';

part 'qr_scan_result_entity.freezed.dart';

@freezed
abstract class QrScanResultEntity with _$QrScanResultEntity {
  const factory QrScanResultEntity({
    required int questId,
    int? eventId,
    String? scanSessionId,
  }) = _QrScanResultEntity;
}
