import 'package:http/http.dart' as http;
import 'package:mae_ban/core/error/exceptions.dart';
import 'package:mae_ban/core/error/failures.dart';
import 'package:mae_ban/feature/auth/data/models/auth_response_model.dart';
import 'package:mae_ban/feature/auth/data/models/job_hunter_model.dart';
import 'dart:convert';

import 'package:mae_ban/feature/auth/data/models/job_offer_model.dart';

class ApiService {
  final http.Client client;
  final String baseUrl;

  ApiService({
    required this.client,
    required this.baseUrl,
  });

  Future<void> signupJobOffer(JobOfferModel jobOffer) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/signup-job-offer'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(jobOffer.toJson()),
    );
    if (response.statusCode != 200) {
      throw ServerException('Failed to sign up job offer');
    }
  }

  Future<AuthResponseModel> signupJobHunter(JobHunterModel jobHunter) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/signup-job-hunter'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(jobHunter.toJson()),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return AuthResponseModel.fromJson(jsonResponse);
    } else {
      throw ServerException('Failed to sign up job hunter');
    }
  }

  Future<AuthResponseModel> login(String username, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/signin'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return AuthResponseModel.fromJson(jsonResponse);
    } else if (response.statusCode == 409 || response.statusCode == 500) {
      throw InvalidCredentialsException('Incorrect username or password');
    } else {
      throw ServerException('Failed to login');
    }
  }

  Future<String> getTokenForUsername(String username) async {
    final response = await client.post(
      Uri.parse('$baseUrl/token'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username}),
    );
    if (response.statusCode != 200) {
      throw ServerException('Failed to get token for username');
    }
    final jsonResponse = json.decode(response.body);
    return jsonResponse['token'];
  }

  Future<void> resetPassword(
      String userId, String newPassword, String jwtToken) async {
    final response = await client.put(
      Uri.parse('$baseUrl/auth/reset-password/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
      body: json.encode({'password': newPassword}),
    );
    if (response.statusCode != 200) {
      throw ServerException('Failed to reset password');
    }
  }

  Future<String> sendOtp(String phoneNumber) async {
    final url = Uri.parse('$baseUrl/auth/send-otp?phone=$phoneNumber');
    final response = await client.post(url);
    if (response.statusCode != 200) {
      throw ServerException('Failed to send OTP');
    }
    final responseBody = response.body;
    if (responseBody.contains('OTP sent successfully!')) {
      return responseBody;
    } else {
      throw FormatErrorException('Invalid response format');
    }
  }

  Future<String> verifyOtp(String phoneNumber, String otp) async {
    final url =
        Uri.parse('$baseUrl/auth/verify-otp?phone=$phoneNumber&otp=$otp');
    final response = await client.post(url);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('data') &&
          jsonResponse['data'].containsKey('accessToken')) {
        return jsonResponse['data']['accessToken'];
      } else {
        throw FormatErrorException('Invalid response format');
      }
    } else {
      throw ServerException('Failed to verify OTP');
    }
  }

  Future<void> resetPasswordWithToken(
      String userId, String token, String newPassword) async {
    final url = Uri.parse('$baseUrl/auth/reset-password');
    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'id': userId, 'password': newPassword}),
    );
    if (response.statusCode != 200) {
      throw ServerException('Failed to reset password');
    }
  }
}
