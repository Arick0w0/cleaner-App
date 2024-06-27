import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/feature/auth/data/local_storage/local_storage_service.dart';
import 'package:mae_ban/feature/auth/presentation/cubit/user_cubit.dart';
import 'dart:convert';

import 'package:mae_ban/feature/offer/domain/entities/booking.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking/widget/booking_card.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
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
          'http://18.142.53.143:9393/api/v1/job/many-post-jop?username=$username&not_status=DONE';
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      try {
        final response = await http.get(Uri.parse(url), headers: headers);

        if (response.statusCode == 200) {
          List<dynamic> data =
              jsonDecode(utf8.decode(response.bodyBytes))['data'];
          if (mounted) {
            setState(() {
              bookings = data.map((json) => Booking.fromJson(json)).toList();
              isLoading = false;
            });
          }
        } else {
          throw Exception('Failed to load bookings');
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        print('Error: $e');
      }
    } else {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      print('User is not loaded or token is null');
    }
  }

  Future<void> _refreshBookings() async {
    await Future.delayed(
        const Duration(milliseconds: 1000)); // เพิ่มความล่าช้า 2 วินาที
    await fetchBookings();
  }

  @override
  void dispose() {
    // ยกเลิก timer หรือ listener ที่นี่ถ้ามี
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? RefreshIndicator(
              onRefresh: _refreshBookings,
              child: ListView.builder(
                itemCount: 1, // แสดงรายการเดียวเพื่อให้ RefreshIndicator ทำงาน
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(child: Text("Loading...")),
                  );
                },
              ),
            )
          : RefreshIndicator(
              color: MColors.accent,
              onRefresh: _refreshBookings,
              child: ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BookingCard(booking: booking),
                  );
                },
              ),
            ),
    );
  }
}
