import 'package:mae_ban/feature/offer/domain/entities/booking.dart';

abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingLoaded extends BookingState {
  final Booking booking;

  BookingLoaded(this.booking);
}

class BookingError extends BookingState {
  final String message;

  BookingError(this.message);
}
