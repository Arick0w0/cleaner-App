import 'package:flutter/material.dart';
import 'package:mae_ban/feature/hunter/presentation/page/history_page/history_page.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking/widget/booking_tab_bar.dart';

import '../page/activity_page/atitive_page.dart';

class BookingContent extends StatelessWidget {
  final int initialIndex;

  const BookingContent({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: initialIndex,
      length: 2,
      child: Column(
        children: const [
          BookingTabBar(),
          Flexible(
            child: TabBarView(
              children: [
                ActivePage(),
                HistoryHunterPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
