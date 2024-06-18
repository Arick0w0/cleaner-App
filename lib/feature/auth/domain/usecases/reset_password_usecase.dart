import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mae_ban/feature/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<String> getTokenForUsername(String username) async {
    return await repository.getTokenForUsername(username);
  }

  String decodeTokenToGetUserId(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return decodedToken['_id'];
  }

  Future<void> resetPassword(
      String userId, String newPassword, String jwtToken) async {
    return await repository.resetPassword(userId, newPassword, jwtToken);
  }

  Future<String> sendOtp(String phoneNumber) async {
    return await repository.sendOtp(phoneNumber);
  }

  Future<String> verifyOtp(String phoneNumber, String otp) async {
    return await repository.verifyOtp(phoneNumber, otp);
  }

  Future<void> resetPasswordWithToken(
      String userId, String token, String newPassword) async {
    return await repository.resetPasswordWithToken(userId, token, newPassword);
  }
}
