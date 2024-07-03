// // repositories/booking_repository.dart
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:mae_ban/feature/offer/domain/entities/booking.dart';
// import 'package:mae_ban/feature/auth/data/local_storage/local_storage_service.dart';

// class ActivityRepository {
//   final http.Client client;
//   final LocalStorageService localStorageService;

//   ActivityRepository({required this.client, required this.localStorageService});

//   Future<List<Booking>> fetchBookings() async {
//     final token = await localStorageService.getToken();
//     if (token == null) {
//       throw Exception('Token is null');
//     }

//     final url = 'http://18.142.53.143:9393/api/v1/job/many-post-jop-hunter';
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token',
//     };

//     final response = await client.get(Uri.parse(url), headers: headers);
//     if (response.statusCode == 200) {
//       List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes))['data'];
//       return data.map((json) => Booking.fromJson(json)).toList();
//     } else {
//       throw Exception(
//           'Failed to load bookings, status code: ${response.statusCode}');
//     }
//   }
// }
