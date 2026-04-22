import 'package:vroom/features/qr_scanner/domain/repository/qr_scanner_repository.dart';

class ResolveQrEventCodeUseCase {
  const ResolveQrEventCodeUseCase({required QrScannerRepository repository})
    : _repository = repository;

  final QrScannerRepository _repository;

  Future<String> call(String rawValue) {
    return _repository.resolveEventCode(rawValue);
  }
}
