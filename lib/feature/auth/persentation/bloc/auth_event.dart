part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupJobOfferEvent extends AuthEvent {
  final JobOfferModel jobOffer;

  SignupJobOfferEvent(this.jobOffer);

  @override
  List<Object?> get props => [jobOffer];
}

class SignupJobHunterEvent extends AuthEvent {
  final JobHunterModel jobHunter;

  SignupJobHunterEvent(this.jobHunter);

  @override
  List<Object?> get props => [jobHunter];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  LoginEvent(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}

class LogoutEvent extends AuthEvent {}
