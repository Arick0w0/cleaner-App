// lib/feature/booking/presentation/pages/booking_page.dart

import 'package:flutter/material.dart';
import 'package:mae_ban/feature/offer/presentation/screen/history_page/offer_history_page.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking_page/offer_ativity_page.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking_page/widget/booking_tab_bar.dart';

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
            title: const Text('ການຈອງ'),
          ),
          body: DefaultTabController(
            initialIndex: initialIndex,
            length: 2,
            child: const Column(
              children: [
                BookingTabBar(),
                Flexible(
                  child: TabBarView(
                    children: [
                      ActivityPage(),
                      HistoryUserPage(),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
