class ServerException implements Exception {}

class CacheException implements Exception {}

// lib/core/error/exceptions.dart
class InvalidCredentialsException implements Exception {
  final String message;
  InvalidCredentialsException(this.message);

  @override
  String toString() => message;
}
