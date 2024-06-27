import 'package:flutter/material.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking/pages/offer_history_page.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking/widget/booking_tab_bar.dart';

import 'offer_ativity_page.dart';

class BookingContent extends StatelessWidget {
  const BookingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Column(
        children: [
          BookingTabBar(),
          Flexible(
            child: TabBarView(
              children: [
                ActivityPage(),
                HistoryPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
