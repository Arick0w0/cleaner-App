import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';
import 'package:mae_ban/feature/auth/data/local_storage/local_storage_service.dart';

abstract class BookingRemoteDataSource {
  Future<List<Booking>> fetchBookings();
  Future<void> acceptBooking(String billCode);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final http.Client client;
  final LocalStorageService localStorageService;

  BookingRemoteDataSourceImpl(
      {required this.client, required this.localStorageService});

  @override
  Future<List<Booking>> fetchBookings() async {
    final token = await localStorageService.getToken();
    if (token == null) throw Exception('Token not found');
    print(token);

    final url = 'http://18.142.53.143:9393/api/v1/job/many-post-jop-hunter';
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
      debugPrint(
          'Failed to load bookings, status code: ${response.statusCode}');
      throw Exception(
          'Failed to load bookings, status code: ${response.statusCode}');
    }
  }

  @override
  Future<void> acceptBooking(String billCode) async {
    final token = await localStorageService.getToken();
    if (token == null) throw Exception('Token not found');

    final url = 'http://18.142.53.143:9393/api/v1/job/submit-job';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
      'bill_code': billCode,
      'status': 'ANSWER_OFFER',
    });

    final response =
        await client.put(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode != 200) {
      debugPrint(
          'Failed to accept booking, status code: ${response.statusCode}');
      throw Exception(
          'Failed to accept booking, status code: ${response.statusCode}');
    }
  }
}
