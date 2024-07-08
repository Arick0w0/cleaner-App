// lib/feature/joboffer/data/datasources/service_type_remote_data_source.dart
import 'package:http/http.dart' as http;
import 'package:mae_ban/core/secret/secret.dart';
import 'package:mae_ban/feature/offer/data/models/service_type_model.dart';
import 'dart:convert';

abstract class ServiceTypeRemoteDataSource {
  Future<List<ServiceTypeModel>> fetchServiceTypes();
}

class ServiceTypeRemoteDataSourceImpl implements ServiceTypeRemoteDataSource {
  final http.Client client;

  ServiceTypeRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ServiceTypeModel>> fetchServiceTypes() async {
    const baseUrl = Config.apiBaseUrl;

    final response = await client.get(Uri.parse('$baseUrl/app/service-type'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          json.decode(utf8.decode(response.bodyBytes));
      // print('Data received from API: $data'); // Debugging line
      final List<dynamic> serviceTypes = data['data'];
      return serviceTypes
          .map((json) => ServiceTypeModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load service types');
    }
  }
}
