import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mae_ban/feature/auth/data/local_storage/local_storage_service.dart';
import 'package:mae_ban/feature/auth/presentation/cubit/user_cubit.dart';
import 'dart:convert';

import 'package:mae_ban/feature/offer/domain/entities/booking.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking/widget/booking_card.dart';

// นำเข้า LocalStorageService

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<HistoryPage> {
  List<Booking> bookings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    final userCubit = context.read<UserCubit>();
    final userState = userCubit.state;

    final localStorageService = LocalStorageService();
    final token = await localStorageService.getToken();

    if (userState is UserLoaded && token != null) {
      final username = userState.user.username;

      final url =
          'http://18.142.53.143:9393/api/v1/job/many-post-jop?username=$username&status=DONE';
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      try {
        final response = await http.get(Uri.parse(url), headers: headers);

        if (response.statusCode == 200) {
          List<dynamic> data =
              jsonDecode(utf8.decode(response.bodyBytes))['data'];
          // print(response.body.toString());

          setState(() {
            bookings = data.map((json) => Booking.fromJson(json)).toList();
            isLoading = false;
          });
        } else {
          throw Exception('Failed to load bookings');
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print('Error: $e');
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print('User is not loaded or token is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BookingCard(booking: booking),
                );
              },
            ),
    );
  }
}
