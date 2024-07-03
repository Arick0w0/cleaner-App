// lib/feature/booking/presentation/pages/booking_page.dart

import 'package:flutter/material.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking/pages/tapview/booking_content.dart';

class BookingPage extends StatelessWidget {
  final int initialIndex;
  const BookingPage({
    super.key,
    this.initialIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Booking Page'),
        ),
        body: BookingContent(initialIndex: initialIndex),
      ),
    );
  }
}
