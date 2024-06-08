import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mae_ban/feature/shared/data/models/area_model.dart';
import 'package:mae_ban/feature/shared/data/models/province_model.dart';
import 'package:mae_ban/feature/shared/data/models/service_type_model.dart';

class ApiServiceGet {
  Future<List<ServiceTypeModel>> fetchServiceTypes() async {
    final response = await http.get(Uri.parse(
        'http://18.140.3.166:9393/app-service/api/v1/app/service-type'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes))['data'];
      return jsonResponse
          .map((service) => ServiceTypeModel.fromJson(service))
          .toList();
    } else {
      throw Exception('Failed to load service types');
    }
  }

  Future<List<Province>> fetchProvinces() async {
    final response = await http
        .get(Uri.parse('http://18.140.3.166:9393/app-service/api/v1/app/area'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes))['data'];
      List<Province> provinces =
          jsonResponse.map((area) => Province.fromJson(area)).toSet().toList();
      return provinces;
    } else {
      throw Exception('Failed to load provinces');
    }
  }

  Future<List<Area>> fetchAreasByProvince(String provinceCodeName) async {
    final response = await http.get(Uri.parse(
        'http://18.140.3.166:9393/app-service/api/v1/app/area?area_code_name=&province_code_name=$provinceCodeName'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes))['data'];
      return jsonResponse.map((area) => Area.fromJson(area)).toList();
    } else {
      throw Exception('Failed to load areas for province $provinceCodeName');
    }
  }
}
