import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/feature/offer/domain/usecases/get_booking.dart';
import 'package:mae_ban/core/utils/network_info.dart';
import 'package:mae_ban/feature/offer/presentation/blocs/booking/booking_bloc.dart';
import 'package:mae_ban/feature/offer/presentation/blocs/booking/booking_event.dart';
import 'package:mae_ban/feature/offer/presentation/blocs/booking/booking_state.dart';
import 'package:mae_ban/service_locator.dart';

class BookingCard1 extends StatelessWidget {
  const BookingCard1({super.key});

  Color getStatusColor(String status) {
    switch (status) {
      case 'waiting':
        return Colors.purple;
      case 'select cleaner':
        return Colors.blue;
      case 'accept':
        return Colors.yellow;
      case 'success':
        return Colors.green;
      default:
        return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดการจอง'),
      ),
      body: BlocProvider(
        create: (context) => BookingBloc(
          getBooking: sl<GetBooking>(),
          networkInfo: sl<NetworkInfo>(),
        )..add(FetchBookingData()),
        child: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            if (state is BookingLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is BookingLoaded) {
              final booking = state.booking;
              return Container(
                padding: const EdgeInsets.all(10),
                height: 140,
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
                        Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            const Gap(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  booking.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Gap(5),
                                Text(
                                  booking.date,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: MColors.dark),
                                ),
                                Gap(5),
                                Text(
                                  booking.time,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'สถานะ',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const Gap(5),
                            SizedBox(
                              width: 110,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: getStatusColor(booking.status),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    booking.status,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: MColors.white,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
              );
            } else if (state is BookingError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
