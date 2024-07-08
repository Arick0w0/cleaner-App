import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mae_ban/core/secret/secret.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class JobDetailRemoteDataSource {
  Future<Map<String, dynamic>> fetchJobDetail(String postJobId);
}

class JobDetailRemoteDataSourceImpl implements JobDetailRemoteDataSource {
  final http.Client client;

  JobDetailRemoteDataSourceImpl({required this.client});

  @override
  Future<Map<String, dynamic>> fetchJobDetail(String postJobId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    if (token == null) throw Exception('Token not found');
    final baseUrl = Config.apiBaseUrl;

    final url = '${baseUrl}/job/post-jop/$postJobId';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await client.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      final data = responseBody['data'] as Map<String, dynamic>;
      // _printLongString(data.toString());
      print(data);
      return data;
    } else {
      throw Exception(
          'Failed to load job detail, status code: ${response.statusCode}');
    }
  }

  // void _printLongString(String text) {
  //   final pattern = RegExp('.{1,800}'); // ตัดข้อความทุก 800 ตัวอักษร
  //   for (final match in pattern.allMatches(text)) {
  //     debugPrint(match.group(0));
  //   }
  // }
}
