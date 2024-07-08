// data/datasources/history_user_remote_data_source.dart
import 'package:mae_ban/core/secret/secret.dart';
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryUserRemoteDataSource {
  final http.Client client;

  HistoryUserRemoteDataSource(this.client);

  Future<List<Booking>> fetchHistoryUserBookings(
      String token, String username) async {
    final baseUrl = Config.apiBaseUrl;

    final url = '${baseUrl}/job/many-post-jop?username=$username&status=DONE';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await client.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      final data = responseBody['data'];

      if (data == null || data.isEmpty) {
        throw Exception('No data found');
      }

      return List<Booking>.from(data.map((json) => Booking.fromJson(json)));
    } else {
      throw Exception('Failed to load bookings');
    }
  }
}
