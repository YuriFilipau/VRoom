import 'package:vroom/features/qr_scanner/domain/entities/qr_scan_result_entity.dart';
import 'package:vroom/features/qr_scanner/domain/repository/qr_scanner_repository.dart';

class ProcessQrCodeUseCase {
  const ProcessQrCodeUseCase({required QrScannerRepository repository})
    : _repository = repository;

  final QrScannerRepository _repository;

  Future<QrScanResultEntity> call(String rawValue) {
    return _repository.processQr(rawValue);
  }
}
