// lib/feature/booking/presentation/pages/booking_page.dart

import 'package:flutter/material.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking/pages/booking_content.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Booking Page'),
        ),
        body: const BookingContent(),
      ),
    );
  }
}
