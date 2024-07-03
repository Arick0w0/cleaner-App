import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking/widget/booking_info_widget.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking/widget/booking_status_widget.dart';
import 'package:go_router/go_router.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;

  const BookingCard({required this.booking, super.key});

  String formatDateTime(String dateTimeStr) {
    final DateTime dateTime = DateTime.parse(dateTimeStr);
    final DateFormat formatter = DateFormat('dd-MM-yyyy (HH:mm)');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/detail', extra: booking.id);
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                    Flexible(
                      child: BookingInfoWidget(
                        name: booking.name,
                        date: formatDateTime(booking.date), // แปลงวันที่และเวลา
                        time: booking.time,
                        image: booking.image,
                      ),
                    ),
                    const Gap(10),
                    BookingStatusWidget(
                      status: booking.status,
                      showStatusText: true,
                    ),
                  ],
                ),
                const Divider(),
                const Gap(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "ຄໍາສັ່ງຊື້ ${booking.orderNumber}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        booking.orderDate, // แปลงวันที่และเวลา
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
