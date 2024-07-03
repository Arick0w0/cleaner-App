import 'package:flutter/material.dart';
import 'package:mae_ban/feature/hunter/presentation/landing_hunter/pageview.dart';

class ActivityViewPage extends StatelessWidget {
  final int initialIndex;

  const ActivityViewPage({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ກິດຈະກຳ'),
      ),
      body: BookingContent(initialIndex: initialIndex),
    );
  }
}
