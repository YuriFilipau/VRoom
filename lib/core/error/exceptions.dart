class ServerException implements Exception {}

class AuthException implements Exception {
  final String message;
  const AuthException(this.message);
}