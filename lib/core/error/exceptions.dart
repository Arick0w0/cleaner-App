class NoInternetException implements Exception {
  final String message;
  NoInternetException([this.message = 'No Internet connection']);
  @override
  String toString() => message;
}

class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Failed to connect to server']);
  @override
  String toString() => message;
}

class FormatErrorException implements Exception {
  final String message;
  FormatErrorException([this.message = 'Invalid response format']);
  @override
  String toString() => message;
}
