import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;

  Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [properties];

  String get message => 'An unexpected error occurred';
}

class ServerFailure extends Failure {
  @override
  String get message => 'Server Failure';
}

class CacheFailure extends Failure {
  @override
  String get message => 'Cache Failure';
}

class InvalidCredentialsException implements Exception {
  final String message;
  InvalidCredentialsException(this.message);

  @override
  String toString() => message;
}
