part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignupJobOfferEvent extends AuthEvent {
  final JobOfferModel jobOffer;

  SignupJobOfferEvent(this.jobOffer);

  @override
  List<Object> get props => [jobOffer];
}

class SignupJobHunterEvent extends AuthEvent {
  final JobHunterModel jobHunter;

  SignupJobHunterEvent(this.jobHunter);

  @override
  List<Object> get props => [jobHunter];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;
  final UserCubit userCubit; // เพิ่ม UserCubit ตรงนี้

  const LoginEvent(this.username, this.password, this.userCubit);

  @override
  List<Object> get props => [username, password, userCubit];
}

class LogoutEvent extends AuthEvent {}

class GetTokenEvent extends AuthEvent {
  final String username;

  GetTokenEvent(this.username);

  @override
  List<Object> get props => [username];
}

class SendOtpEvent extends AuthEvent {
  final String phoneNumber;

  SendOtpEvent(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class VerifyOtpEvent extends AuthEvent {
  final String phoneNumber;
  final String otp;

  const VerifyOtpEvent(this.phoneNumber, this.otp);

  @override
  List<Object> get props => [phoneNumber, otp];
}

class ResetPasswordWithTokenEvent extends AuthEvent {
  final String userId;
  final String token;
  final String newPassword;

  const ResetPasswordWithTokenEvent({
    required this.userId,
    required this.token,
    required this.newPassword,
  });

  @override
  List<Object> get props => [userId, token, newPassword];
}

class SendOtpAgainEvent extends AuthEvent {
  final String phoneNumber;

  const SendOtpAgainEvent(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}
