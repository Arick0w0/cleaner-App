import 'package:http/http.dart' as http;
import 'package:mae_ban/core/secret/secret.dart';
import 'package:mae_ban/feature/auth/data/local_storage/local_storage_service.dart';
import 'dart:convert';
import 'dart:io';

class ChooseRemoteDataSource {
  final http.Client client;
  final LocalStorageService localStorageService;

  ChooseRemoteDataSource(
      {required this.client, required this.localStorageService});

  Future<List<dynamic>> fetchCleaners(String postJobId) async {
    final baseUrl = Config.apiBaseUrl;

    final url = '${baseUrl}/job/post-jop-hunter-info/$postJobId';
    final token = await localStorageService.getToken();
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await client.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes))['data'];
      } else {
        throw Exception('Failed to fetch cleaner data: ${response.statusCode}');
      }
    } on SocketException {
      throw SocketException('No internet connection');
    } catch (e) {
      throw Exception('Error fetching cleaner data: $e');
    }
  }

  Future<void> chooseCleaner(String billCode, String hunterUsername) async {
    final baseUrl = Config.apiBaseUrl;

    final url = '${baseUrl}/job/choose-hunter/';
    final token = await localStorageService.getToken();
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    final body = jsonEncode({
      "bill_code": billCode,
      "status": "MATCH_HUNTER",
      "hunter_username": hunterUsername,
    });

    try {
      final response =
          await client.put(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode != 200) {
        throw Exception('Failed to choose cleaner: ${response.statusCode}');
      }
    } on SocketException {
      throw SocketException('No internet connection');
    } catch (e) {
      throw Exception('Error choosing cleaner: $e');
    }
  }
}
