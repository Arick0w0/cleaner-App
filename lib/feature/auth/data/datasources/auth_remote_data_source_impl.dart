import 'package:mae_ban/feature/auth/data/models/auth_response_model.dart';
import 'package:mae_ban/feature/auth/data/models/job_hunter_model.dart';
import 'package:mae_ban/feature/auth/data/models/job_offer_model.dart';
import 'package:mae_ban/feature/auth/data/service/api_service.dart';

import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl({required this.apiService});

  @override
  Future<void> signupJobOffer(JobOfferModel jobOffer) {
    return apiService.signupJobOffer(jobOffer);
  }

  @override
  Future<AuthResponseModel> signupJobHunter(JobHunterModel jobHunter) {
    return apiService.signupJobHunter(jobHunter);
  }

  @override
  Future<AuthResponseModel> login(String username, String password) {
    return apiService.login(username, password);
  }

  @override
  Future<String> getTokenForUsername(String username) {
    return apiService.getTokenForUsername(username);
  }

  @override
  Future<void> resetPassword(String userId, String newPassword, String token) {
    return apiService.resetPassword(userId, newPassword, token);
  }

  @override
  Future<String> sendOtp(String phoneNumber) {
    return apiService.sendOtp(phoneNumber);
  }

  @override
  Future<String> verifyOtp(String phoneNumber, String otp) {
    return apiService.verifyOtp(phoneNumber, otp);
  }

  @override
  Future<void> resetPasswordWithToken(
      String userId, String token, String newPassword) {
    return apiService.resetPasswordWithToken(
        userId, token, newPassword); // Updated line
  }
}
