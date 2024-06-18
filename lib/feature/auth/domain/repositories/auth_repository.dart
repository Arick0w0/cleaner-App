import 'package:mae_ban/feature/auth/data/models/auth_response_model.dart';
import 'package:mae_ban/feature/auth/data/models/job_hunter_model.dart';
import 'package:mae_ban/feature/auth/data/models/job_offer_model.dart';

abstract class AuthRepository {
  Future<void> signupJobOffer(JobOfferModel jobOffer);
  Future<AuthResponseModel> signupJobHunter(JobHunterModel jobHunter);
  Future<AuthResponseModel> login(String username, String password);
  Future<String> getTokenForUsername(String username);
  Future<void> resetPassword(String userId, String newPassword, String token);
  Future<String> sendOtp(String phoneNumber);
  Future<String> verifyOtp(String phoneNumber, String otp);
  Future<void> resetPasswordWithToken(
      String userId, String token, String newPassword); // Update this line
}
