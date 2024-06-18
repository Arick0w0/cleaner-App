import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking/widget/booking_info_widget.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking/widget/booking_status_widget.dart';
import 'package:go_router/go_router.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;

  const BookingCard({required this.booking, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/detail', extra: booking.id);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: MColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BookingInfoWidget(
                  name: booking.name,
                  date: booking.date,
                  time: booking.time,
                ),
                BookingStatusWidget(status: booking.status),
              ],
            ),
            const Divider(),
            const Gap(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  booking.orderNumber,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  booking.orderDate,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
