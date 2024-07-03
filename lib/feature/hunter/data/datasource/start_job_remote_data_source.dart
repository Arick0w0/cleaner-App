import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class StartJobDetailRemoteDataSource {
  Future<Map<String, dynamic>> fetchJobDetail(String postJobId);
  Future<void> submitStatusProcess(String startJobId, String newStatus);
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

    final url = 'http://18.142.53.143:9393/api/v1/job/start-jop/$postJobId';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await client.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
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

    final url =
        'http://18.142.53.143:9393/api/v1/job/start-jop-hunter/$startJobId';
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
