abstract interface class QrScannerRepository {
  Future<String> resolveEventCode(String rawValue);
}
