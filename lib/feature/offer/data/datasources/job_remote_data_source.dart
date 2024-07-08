import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mae_ban/core/secret/secret.dart';

class JobRemoteDataSource {
  final http.Client client;

  JobRemoteDataSource(this.client);

  Future<Map<String, dynamic>> submitJob(String billCode, String token) async {
    final baseUrl = Config.apiBaseUrl;

    final url = '${baseUrl}/job/post-jop';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final payload = {"bill_code": billCode};

    final response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['data'] == 'successfully') {
        return responseData;
      } else {
        throw Exception('Failed to submit job: ${responseData['data']}');
      }
    } else {
      final responseBody = jsonDecode(response.body);
      throw Exception(
          'Failed to submit job: ${responseBody['msg'] ?? 'Unknown error'}');
    }
  }
}
