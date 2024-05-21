import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:mae_ban/feature/auth/data/models/auth_response_model.dart';
import 'package:mae_ban/feature/auth/data/models/job_hunter_model.dart';
import 'package:mae_ban/feature/auth/data/models/job_offer_model.dart';
import 'package:mae_ban/feature/auth/domain/usecases/login.dart';
import 'package:mae_ban/feature/auth/domain/usecases/signup_job_hunter.dart';
import 'package:mae_ban/feature/auth/domain/usecases/signup_job_offer.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpJobOffer signupJobOffer;
  final SignUpJobHunter signupJobHunter;
  final Login login;
  final Logger logger = Logger(); // Initialize logger

  AuthBloc({
    required this.signupJobOffer,
    required this.signupJobHunter,
    required this.login,
  }) : super(AuthInitial()) {
    on<SignupJobOfferEvent>(_onSignupJobOffer);
    on<SignupJobHunterEvent>(_onSignupJobHunter);
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout); // Add logout event
  }

  Future<void> _onSignupJobOffer(
      SignupJobOfferEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    logger.i('AuthLoading emitted for SignupJobOfferEvent'); // Debugging line
    try {
      await signupJobOffer.execute(event.jobOffer);
      // await _storeAuthState(event.jobOffer.username, 'JOB_OFFER');
      emit(AuthSuccess(null));
      logger.i('AuthSuccess emitted for SignupJobOfferEvent'); // Debugging line
    } catch (e) {
      emit(AuthFailure(e.toString()));
      logger.e(
          'AuthFailure emitted for SignupJobOfferEvent: ${e.toString()}'); // Debugging line
    }
  }

  Future<void> _onSignupJobHunter(
      SignupJobHunterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    logger.i('AuthLoading emitted for SignupJobHunterEvent'); // Debugging line
    try {
      await signupJobHunter.execute(event.jobHunter);
      // await _storeAuthState(event.jobHunter.username, 'JOB_HUNTER');
      emit(AuthSuccess(null));
      logger
          .i('AuthSuccess emitted for SignupJobHunterEvent'); // Debugging line
    } catch (e) {
      emit(AuthFailure(e.toString()));
      logger.e(
          'AuthFailure emitted for SignupJobHunterEvent: ${e.toString()}'); // Debugging line
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    logger.i('AuthLoading emitted for LoginEvent'); // Debugging line
    try {
      final authResponse = await login.execute(event.username, event.password);
      await _storeAuthState(
          event.username, authResponse.role, authResponse.accessToken);
      emit(AuthSuccess(authResponse));
      logger.i(
          'AuthSuccess emitted for LoginEvent with role: ${authResponse.role}'); // Debugging line
    } catch (e) {
      emit(AuthFailure(e.toString()));
      // print( 'AuthFailure emitted for LoginEvent: ${e.toString()}'); // Debugging line
      logger.e(
          'AuthFailure emitted for LoginEvent: ${e.toString()}'); // Logging error
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.clear();
      emit(LoggedOut());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _storeAuthState(String username, String role,
      [String? token]) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('username', username);
    await sharedPreferences.setString('role', role);
    if (token != null) {
      await sharedPreferences.setString('accessToken', token);
    }
  }
}
