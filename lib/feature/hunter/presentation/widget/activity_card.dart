import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/feature/hunter/presentation/widget/status_widget.dart';
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking_page/widget/booking_info_widget.dart';

class ActivityCard extends StatelessWidget {
  final Booking booking;
  final VoidCallback onPressed;

  const ActivityCard(
      {required this.booking, super.key, required this.onPressed});

  String formatDateTime(String dateTimeStr) {
    final DateTime dateTime = DateTime.parse(dateTimeStr);
    final DateFormat formatter = DateFormat('dd-MM-yyyy (HH:mm)');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
                      date: formatDateTime(booking.date),
                      time: booking.time,
                      image: booking.image,
                    ),
                  ),
                  const Gap(10),
                  Status(
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
                  if (booking.status == 'WAIT_HUNTER')
                    Flexible(
                      child: SizedBox(
                        height: 30,
                        width: 100,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all(MColors.accent),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                          onPressed: onPressed,
                          child: Text(
                            'ຕອບຮັບ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                  else if (booking.status != 'MATCH_OFFER')
                    Flexible(
                      child: Text(
                        booking.orderDate,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  if (booking.status == 'MATCH_OFFER')
                    Flexible(
                      child: SizedBox(
                        height: 30,
                        width: 100,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all(MColors.accent),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            context.push('/start-job',
                                extra: booking.startJobId);
                          },
                          child: Text(
                            'ຕິດຕາມ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
