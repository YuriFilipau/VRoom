import 'package:vroom/features/qr_scanner/domain/entities/qr_scan_result_entity.dart';

abstract interface class QrScannerRepository {
  Future<QrScanResultEntity> processQr(String rawValue);
}
