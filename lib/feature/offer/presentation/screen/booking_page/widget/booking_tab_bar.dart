// lib/feature/booking/presentation/widgets/booking_tab_bar.dart

import 'package:flutter/material.dart';
import 'package:mae_ban/core/constants/color.dart';

class BookingTabBar extends StatelessWidget {
  const BookingTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
      ),
      child: const TabBar(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: MColors.accent, // สีของเส้นคั่นเมื่อแท็บถูกเลือก
            width: 3.0, // ความหนาของเส้นคั่น
          ),
          insets: EdgeInsets.symmetric(
            horizontal: 70.0, // กำหนดระยะห่างของเส้นคั่นจากขอบแท็บ
          ),
        ),
        labelColor: MColors.accent, // สีของ label ที่ถูกเลือก
        unselectedLabelColor: Colors.grey, // สีของ label ที่ไม่ได้ถูกเลือก
        tabs: [
          Tab(
            // icon: Icon(Icons.home),
            // text: 'Booking',
            child: Text(
              'ການຈອງ',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Tab(
            // icon: Icon(Icons.book_online),
            child: Text(
              'ປະຫວັດ',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
