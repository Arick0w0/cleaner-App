import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mae_ban/core/secret/secret.dart';
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';
import 'package:mae_ban/feature/auth/data/local_storage/local_storage_service.dart';

abstract class HistoryRemoteDataSource {
  Future<List<Booking>> fetchHistory();
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  final http.Client client;
  final LocalStorageService localStorageService;

  HistoryRemoteDataSourceImpl(
      {required this.client, required this.localStorageService});

  @override
  Future<List<Booking>> fetchHistory() async {
    final token = await localStorageService.getToken();
    if (token == null) throw Exception('Token not found');
    final baseUrl = Config.apiBaseUrl;

    final url = '${baseUrl}/job/start-jop-history/';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await client.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      debugPrint(
          'Response Body: $responseBody'); // Debug print to check response
      final data = responseBody['data'] as List?;
      if (data == null) {
        debugPrint('Data is null'); // Debug print to indicate null data
        return []; // Return an empty list if data is null
      }
      return data.map((json) => Booking.fromJson(json)).toList();
    } else {
      debugPrint('Failed to load history, status code: ${response.statusCode}');
      throw Exception(
          'Failed to load history, status code: ${response.statusCode}');
    }
  }
}
