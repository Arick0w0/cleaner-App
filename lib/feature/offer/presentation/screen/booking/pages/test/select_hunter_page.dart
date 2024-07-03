// lib/feature/offer/presentation/screens/booking_page.dart

import 'package:flutter/material.dart';
import 'package:mae_ban/feature/offer/data/models/dummy_data.dart';
import 'package:mae_ban/feature/offer/presentation/widgets/cleaner_card.dart';

class SelectHunter extends StatelessWidget {
  const SelectHunter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: [
            const SizedBox(height: 16.0), // เพิ่มระยะห่างด้านบน
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // จำนวนคอลัมน์ในกริด
                  crossAxisSpacing: 10.0, // ระยะห่างระหว่างคอลัมน์
                  mainAxisSpacing: 10.0, // ระยะห่างระหว่างแถว
                  childAspectRatio: 0.68, // อัตราส่วนของขนาดวิดเจ็ต (ถ้าจำเป็น)
                ),
                itemCount: cleaners.length, // จำนวนรายการในกริด
                itemBuilder: (context, index) {
                  final cleaner = cleaners[index];
                  return CleanerCard(
                    name: cleaner.name,
                    imageProfile: cleaner.imageProfile,
                    image: cleaner.image,
                    // onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
