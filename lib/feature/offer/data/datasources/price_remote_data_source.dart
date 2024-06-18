// lib/feature/offer/data/datasources/price_remote_data_source.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mae_ban/core/secret/secret.dart';
import 'package:mae_ban/feature/offer/data/models/price_model.dart';

abstract class PriceRemoteDataSource {
  Future<List<PriceModel>> getPrices();
}

class PriceRemoteDataSourceImpl implements PriceRemoteDataSource {
  final http.Client client;

  PriceRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PriceModel>> getPrices() async {
    final baseUrl = Config.apiBaseUrl;
    final response = await client.get(Uri.parse('$baseUrl/app/price'));

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes))['data'] as List;
      return data.map((json) => PriceModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load prices');
    }
  }
}
