import 'package:flutter/material.dart';
import 'package:mae_ban/feature/hunter/presentation/page/activity_page/atitive_page.dart';
import 'package:mae_ban/feature/hunter/presentation/page/history_page/history_page.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking_page/widget/booking_tab_bar.dart';

class ActivityViewPage extends StatelessWidget {
  final int initialIndex;

  const ActivityViewPage({
    super.key,
    this.initialIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ກິດຈະກຳ'),
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
                  ActivePage(),
                  HistoryHunterPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
