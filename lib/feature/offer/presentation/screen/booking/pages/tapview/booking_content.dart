import 'package:flutter/material.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking/pages/history_page/offer_history_page.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking/widget/booking_tab_bar.dart';

import '../offer_ativity_page.dart';

class BookingContent extends StatelessWidget {
  final int initialIndex;
  const BookingContent({
    super.key,
    this.initialIndex = 0,
  });

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
