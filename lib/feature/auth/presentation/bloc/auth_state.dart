part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthResponseModel? authResponse;
  final String? status;
  final bool? isSignup;

  const AuthSuccess({this.authResponse, this.status, this.isSignup});

  @override
  List<Object> get props =>
      [authResponse ?? '', status ?? '', isSignup ?? false];
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object> get props => [error];
}

class LoggedOut extends AuthState {}

class TokenReceived extends AuthState {
  final String token;

  const TokenReceived(this.token);

  @override
  List<Object> get props => [token];
}

class ResetPasswordOtpSent extends AuthState {
  final String bearerToken;

  const ResetPasswordOtpSent(this.bearerToken);

  @override
  List<Object> get props => [bearerToken];
}

class ResetPasswordOtpVerified extends AuthState {
  final String userId;
  final String token;

  const ResetPasswordOtpVerified({required this.userId, required this.token});

  @override
  List<Object> get props => [userId, token];
}

class ResetPasswordSuccess extends AuthState {}
