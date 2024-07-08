import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mae_ban/feature/hunter/domain/usecases/accept_booking.dart';
import 'package:mae_ban/feature/hunter/domain/usecases/get_bookings.dart';
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';
import 'dart:io';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final GetBookings getBookings;
  final AcceptBooking acceptBooking;
  final Connectivity connectivity;

  BookingCubit({
    required this.getBookings,
    required this.acceptBooking,
    required this.connectivity,
  }) : super(BookingInitial());

  Future<void> fetchBookings() async {
    emit(BookingLoading());
    while (true) {
      final connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        emit(const BookingError(message: 'No internet connection.'));
        await Future.delayed(
            const Duration(seconds: 5)); // Retry after 5 seconds
      } else {
        try {
          final bookings = await getBookings();
          if (bookings.isEmpty) {
            emit(BookingNoData());
          } else {
            emit(BookingLoaded(bookings: bookings));
          }
          break;
        } catch (e) {
          if (e is SocketException) {
            emit(const BookingError(message: 'No internet connection.'));
          } else {
            emit(BookingError(message: e.toString()));
          }
          break;
        }
      }
    }
  }

  Future<void> onAcceptBooking(String billCode) async {
    try {
      await acceptBooking(billCode);
      fetchBookings(); // Refresh bookings after accepting
    } catch (e) {
      print('Error accepting booking: $e');
      emit(BookingError(message: e.toString()));
    }
  }
}
