import 'package:http/http.dart' as http;
import 'package:mae_ban/core/secret/secret.dart';
import 'dart:convert';
import 'package:mae_ban/feature/auth/data/models/address_model.dart';
import 'package:mae_ban/feature/auth/data/local_storage/local_storage_service.dart';

abstract class BillRemoteDataSource {
  Future<Map<String, dynamic>> generateBill({
    required String token,
    required String serviceType,
    required String date,
    required String time,
    required double price,
    required double hours,
    required String placeType,
    required Address address,
  });
}

class BillRemoteDataSourceImpl implements BillRemoteDataSource {
  final http.Client client;
  final LocalStorageService localStorageService;

  BillRemoteDataSourceImpl({
    required this.client,
    required this.localStorageService,
  });

  @override
  Future<Map<String, dynamic>> generateBill({
    required String token,
    required String serviceType,
    required String date,
    required String time,
    required double price,
    required double hours,
    required String placeType,
    required Address address,
  }) async {
    final baseUrl = Config.apiBaseUrl;

    final url = '${baseUrl}/job/generate-bill-code';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final payload = {
      "service_type": serviceType,
      "date_service_input": date,
      "time_service_input": time,
      "price_service_input": price.toInt(),
      "hours_service_input": hours, // Send hours as double
      "place_type": placeType,
      "address": {
        "address_name": address.addressName,
        "village": address.village,
        "district": address.district,
        "province": address.province,
        "google_map": address.googleMap
      }
    };

    // Log the request details
    // print('URL: $url');
    // print('Headers: $headers');
    // print('Payload: ${jsonEncode(payload)}');

    final response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(payload),
    );

    // Log the response details
    // print('Response Status: ${response.statusCode}');
    // print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final responseBody = jsonDecode(response.body);
      print('Detailed Response Body: $responseBody');
      throw Exception(
          'Failed to generate bill: ${responseBody['msg'] ?? 'Unknown error'}');
    }
  }
}
