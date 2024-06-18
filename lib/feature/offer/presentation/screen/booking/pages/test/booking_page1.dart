import 'package:flutter/material.dart';
import 'package:mae_ban/core/utils/network_info.dart';
import 'package:mae_ban/feature/offer/domain/usecases/get_booking.dart';
import 'package:mae_ban/feature/offer/presentation/blocs/booking/booking_bloc.dart';
import 'package:mae_ban/feature/offer/presentation/blocs/booking/booking_event.dart';
import 'package:mae_ban/feature/offer/presentation/blocs/booking/booking_state.dart';
import 'package:mae_ban/feature/offer/presentation/screen/booking/widget/booking_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/service_locator.dart';

class BookingPage1 extends StatelessWidget {
  const BookingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingBloc(
        getBooking: sl<GetBooking>(),
        networkInfo: sl<NetworkInfo>(),
      )..add(FetchBookingData()),
      child: Scaffold(
        body: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            if (state is BookingLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BookingLoaded) {
              final booking = state.booking;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      BookingCard(booking: booking),
                    ],
                  ),
                ),
              );
            } else if (state is BookingError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
