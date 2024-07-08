import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mae_ban/core/secret/secret.dart';
import 'package:mae_ban/feature/offer/data/models/time_model.dart';

abstract class TimeRemoteDataSource {
  Future<List<TimeModel>> fetchTimes();
}

class TimeRemoteDataSourceImpl implements TimeRemoteDataSource {
  final http.Client client;

  TimeRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TimeModel>> fetchTimes() async {
    final baseUrl = Config.apiBaseUrl;

    final response = await client.get(Uri.parse('${baseUrl}/app/time'));
    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes))['data'] as List;
      return data.map((json) => TimeModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load times');
    }
  }
}
