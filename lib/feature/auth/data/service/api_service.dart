import 'package:http/http.dart' as http;
import 'package:mae_ban/feature/auth/data/models/auth_response_model.dart';
import 'package:mae_ban/feature/auth/data/models/job_hunter_model.dart';
import 'dart:convert';
import 'dart:io';

import 'package:mae_ban/feature/auth/data/models/job_offer_model.dart';

class ApiService {
  final http.Client client;
  final String baseUrl;

  ApiService({
    required this.client,
    this.baseUrl = 'http://192.168.100.73:7070/auth-service/api/v1/auth',
  });

  Future<void> signupJobOffer(JobOfferModel jobOffer) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/signup-job-offer'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(jobOffer.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to sign up job offer');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on HttpException {
      throw Exception('Failed to connect to server');
    } on FormatException {
      throw Exception('Invalid response format');
    }
  }

  Future<void> signupJobHunter(JobHunterModel jobHunter) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/signup-job-hunter'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(jobHunter.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to sign up job hunter');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on HttpException {
      throw Exception('Failed to connect to server');
    } on FormatException {
      throw Exception('Invalid response format');
    }
  }

  Future<AuthResponseModel> login(String username, String password) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/signin'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        // print('Login response: $jsonResponse'); // Debugging line
        final authResponse = AuthResponseModel.fromJson(jsonResponse);
        print('Parsed role: ${authResponse.role}'); // Debugging line
        return authResponse;
      } else {
        throw Exception('Failed to login');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on HttpException {
      throw Exception('Failed to connect to server');
    } on FormatException {
      throw Exception('Invalid response format');
    }
  }
}
