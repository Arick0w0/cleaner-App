import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart';
import 'package:mae_ban/core/error/exceptions.dart';
import 'package:mae_ban/core/error/failures.dart';
import 'package:mae_ban/feature/auth/data/models/auth_response_model.dart';
import 'package:mae_ban/feature/auth/data/models/job_hunter_model.dart';
import 'package:mae_ban/feature/auth/data/models/job_offer_model.dart';
import 'package:mae_ban/feature/auth/data/models/user_model.dart';
import 'package:mae_ban/feature/auth/domain/usecases/login.dart';
import 'package:mae_ban/feature/auth/domain/usecases/reset_password_usecase.dart';
import 'package:mae_ban/feature/auth/domain/usecases/signup_job_hunter.dart';
import 'package:mae_ban/feature/auth/domain/usecases/signup_job_offer.dart';
import 'package:mae_ban/feature/auth/presentation/cubit/user_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpJobOffer signupJobOffer;
  final SignUpJobHunter signupJobHunter;
  final Login login;
  final ResetPasswordUseCase resetPasswordUseCase;
  final Logger logger = Logger();

  AuthBloc({
    required this.signupJobOffer,
    required this.signupJobHunter,
    required this.login,
    required this.resetPasswordUseCase,
  }) : super(AuthInitial()) {
    on<SignupJobOfferEvent>(_onSignupJobOffer);
    on<SignupJobHunterEvent>(_onSignupJobHunter);
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<GetTokenEvent>(_onGetToken);
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<ResetPasswordWithTokenEvent>(_onResetPasswordWithToken);
    on<SendOtpAgainEvent>(_onSendOtpAgain); // Add this line
  }

  Future<void> _onSignupJobOffer(
      SignupJobOfferEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    logger.i('AuthLoading emitted for SignupJobOfferEvent');

    try {
      await signupJobOffer.execute(event.jobOffer);
      emit(AuthSuccess(status: 'REGISTER'));
      logger.i('AuthSuccess emitted for SignupJobOfferEvent');
    } catch (e) {
      emit(AuthFailure(e.toString()));
      logger.e('AuthFailure emitted for SignupJobOfferEvent: ${e.toString()}');
    }
  }

  Future<void> _onSignupJobHunter(
      SignupJobHunterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    logger.i('AuthLoading emitted for SignupJobHunterEvent');

    try {
      final AuthResponseModel response =
          await signupJobHunter.execute(event.jobHunter);
      emit(AuthSuccess(
          authResponse: response, isSignup: true, status: response.status));
      logger.i(
          'AuthSuccess emitted for SignupJobHunterEvent with status: ${response.status}');
    } catch (e) {
      emit(AuthFailure(e.toString()));
      logger.e('AuthFailure emitted for SignupJobHunterEvent: ${e.toString()}');
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    logger.i('AuthLoading emitted for LoginEvent');

    try {
      logger.i('Attempting login for username: ${event.username}');
      final AuthResponseModel authResponse =
          await login.execute(event.username, event.password);
      logger.i(
          'Login successful, received authResponse: ${authResponse.toString()}');
      await _storeAuthState(
          event.username, authResponse.role, authResponse.accessToken);
      logger.i('Stored auth state for username: ${event.username}');

      // Decode token and save user in UserCubit
      final userCubit = event.userCubit; // Get UserCubit from event
      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(authResponse.accessToken);
      User user = User.fromJson(decodedToken);
      userCubit.saveUser(user);

      emit(
          AuthSuccess(authResponse: authResponse, status: authResponse.status));
      logger.i(
          'AuthSuccess emitted for LoginEvent with role: ${authResponse.role}');
    } on InvalidCredentialsException catch (e) {
      emit(AuthFailure('Incorrect username or password'));
      logger.e(
          'AuthFailure emitted for LoginEvent: Incorrect username or password');
    } on NoInternetException catch (e) {
      emit(AuthFailure('No Internet connection'));
      logger.e('AuthFailure emitted for LoginEvent: No Internet connection');
    } on ServerException catch (e) {
      emit(AuthFailure('Failed to connect to server'));
      logger
          .e('AuthFailure emitted for LoginEvent: Failed to connect to server');
    } on FormatErrorException catch (e) {
      emit(AuthFailure('Invalid response format'));
      logger.e('AuthFailure emitted for LoginEvent: Invalid response format');
    } catch (e) {
      emit(AuthFailure(e.toString()));
      logger.e('AuthFailure emitted for LoginEvent: ${e.toString()}');
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

  Future<void> _onGetToken(GetTokenEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    logger.i('AuthLoading emitted for GetTokenEvent');

    try {
      final token =
          await resetPasswordUseCase.getTokenForUsername(event.username);
      emit(TokenReceived(token));
      logger.i('TokenReceived emitted for GetTokenEvent');
    } catch (e) {
      emit(AuthFailure(e.toString()));
      logger.e('AuthFailure emitted for GetTokenEvent: ${e.toString()}');
    }
  }

  Future<void> _onSendOtpAgain(
      SendOtpAgainEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    logger.i('AuthLoading emitted for SendOtpAgainEvent');

    try {
      final String response =
          await resetPasswordUseCase.sendOtp(event.phoneNumber);
      emit(ResetPasswordOtpSent(response));
      logger.i('ResetPasswordOtpSent emitted for SendOtpAgainEvent');
    } catch (e) {
      emit(AuthFailure(e.toString()));
      logger.e('AuthFailure emitted for SendOtpAgainEvent: ${e.toString()}');
    }
  }

  Future<void> _onSendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    logger.i('AuthLoading emitted for SendOtpEvent');

    try {
      final String response =
          await resetPasswordUseCase.sendOtp(event.phoneNumber);
      emit(ResetPasswordOtpSent(response));
      logger.i('ResetPasswordOtpSent emitted for SendOtpEvent');
    } catch (e) {
      emit(AuthFailure(e.toString()));
      logger.e('AuthFailure emitted for SendOtpEvent: ${e.toString()}');
    }
  }

  Future<void> _onVerifyOtp(
      VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    logger.i('AuthLoading emitted for VerifyOtpEvent');

    try {
      final token =
          await resetPasswordUseCase.verifyOtp(event.phoneNumber, event.otp);
      final userId = resetPasswordUseCase.decodeTokenToGetUserId(token);
      logger.i('Verified userId: $userId');
      emit(ResetPasswordOtpVerified(userId: userId, token: token));
      logger.i('ResetPasswordOtpVerified emitted for VerifyOtpEvent');
    } catch (e) {
      emit(AuthFailure(e.toString()));
      logger.e('AuthFailure emitted for VerifyOtpEvent: ${e.toString()}');
    }
  }

  Future<void> _onResetPasswordWithToken(
      ResetPasswordWithTokenEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    logger.i('AuthLoading emitted for ResetPasswordWithTokenEvent');

    try {
      await resetPasswordUseCase.resetPasswordWithToken(
          event.userId, event.token, event.newPassword);
      emit(ResetPasswordSuccess());
      logger.i('ResetPasswordSuccess emitted for ResetPasswordWithTokenEvent');
    } catch (e) {
      emit(AuthFailure(e.toString()));
      logger.e(
          'AuthFailure emitted for ResetPasswordWithTokenEvent: ${e.toString()}');
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
