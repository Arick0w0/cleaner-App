import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client client;

  ApiClient({required this.client});

  Future<http.Response> get(String url) async {
    final response = await client.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Failed to load data');
    }
    return response;
  }
}
