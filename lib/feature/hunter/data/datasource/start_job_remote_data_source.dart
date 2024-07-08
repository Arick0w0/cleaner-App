import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mae_ban/core/secret/secret.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StartJobDetailRemoteDataSource {
  Future<Map<String, dynamic>> fetchJobDetail(String postJobId);
  Future<void> submitStatusProcess(String startJobId, String newStatus);
  Future<void> submitStatusProcessOffer(String startJobId, String newStatus);
}

class StartJobDetailRemoteDataSourceImpl
    implements StartJobDetailRemoteDataSource {
  final http.Client client;

  StartJobDetailRemoteDataSourceImpl({required this.client});

  @override
  Future<Map<String, dynamic>> fetchJobDetail(String postJobId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    if (token == null) throw Exception('Token not found');
    final baseUrl = Config.apiBaseUrl;

    final url = '${baseUrl}/job/start-jop/$postJobId';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await client.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      // _printLongString(responseBody.toString());

      return responseBody['data'] as Map<String, dynamic>;
    } else {
      throw Exception(
          'Failed to load job detail, status code: ${response.statusCode}');
    }
  }

  @override
  Future<void> submitStatusProcess(String startJobId, String newStatus) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    final baseUrl = Config.apiBaseUrl;

    final url = '${baseUrl}/job/start-jop-hunter/$startJobId';
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final response = await client.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode({'status_process': newStatus}),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to update status, status code: ${response.statusCode}');
    }
  }

  Future<void> submitStatusProcessOffer(
      String startJobId, String newStatus) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    final baseUrl = Config.apiBaseUrl;

    final url = '${baseUrl}/job/start-jop-offer/$startJobId';
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final response = await client.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode({'status_process': newStatus}),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to update status, status code: ${response.statusCode}');
    }
  }
}

// void _printLongString(String text) {
//   final pattern = RegExp('.{1,800}'); // ตัดข้อความทุก 800 ตัวอักษร
//   for (final match in pattern.allMatches(text)) {
//     debugPrint(match.group(0));
//   }
// }
