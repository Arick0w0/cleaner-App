import 'package:mae_ban/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mae_ban/feature/auth/domain/repositories/auth_repository.dart';
import 'package:mae_ban/feature/auth/data/models/auth_response_model.dart';
import 'package:mae_ban/feature/auth/data/models/job_hunter_model.dart';
import 'package:mae_ban/feature/auth/data/models/job_offer_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> signupJobOffer(JobOfferModel jobOffer) {
    return remoteDataSource.signupJobOffer(jobOffer);
  }

  @override
  Future<AuthResponseModel> signupJobHunter(JobHunterModel jobHunter) {
    return remoteDataSource.signupJobHunter(jobHunter);
  }

  @override
  Future<AuthResponseModel> login(String username, String password) {
    return remoteDataSource.login(username, password);
  }

  @override
  Future<String> getTokenForUsername(String username) {
    return remoteDataSource.getTokenForUsername(username);
  }

  @override
  Future<void> resetPassword(String userId, String newPassword, String token) {
    return remoteDataSource.resetPassword(userId, newPassword, token);
  }

  @override
  Future<String> sendOtp(String phoneNumber) {
    return remoteDataSource.sendOtp(phoneNumber);
  }

  @override
  Future<String> verifyOtp(String phoneNumber, String otp) {
    return remoteDataSource.verifyOtp(phoneNumber, otp);
  }

  @override
  Future<void> resetPasswordWithToken(
      String userId, String token, String newPassword) {
    return remoteDataSource.resetPasswordWithToken(
        userId, token, newPassword); // Update this line
  }
}
