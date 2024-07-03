import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mae_ban/feature/hunter/domain/usecases/accept_booking.dart';
import 'package:mae_ban/feature/hunter/domain/usecases/get_bookings.dart';
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final GetBookings getBookings;
  final AcceptBooking acceptBooking;

  BookingCubit({required this.getBookings, required this.acceptBooking})
      : super(BookingInitial());

  Future<void> fetchBookings() async {
    try {
      emit(BookingLoading());
      final bookings = await getBookings();
      if (bookings.isEmpty) {
        emit(BookingNoData());
      } else {
        emit(BookingLoaded(bookings: bookings));
      }
    } catch (e) {
      debugPrint('Error fetching bookings: $e');
      emit(BookingError(message: e.toString()));
    }
  }

  Future<void> onAcceptBooking(String billCode) async {
    try {
      await acceptBooking(billCode);
      fetchBookings(); // Refresh bookings after accepting
    } catch (e) {
      debugPrint('Error accepting booking: $e');
      emit(BookingError(message: e.toString()));
    }
  }
}
