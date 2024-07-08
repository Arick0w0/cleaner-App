// domain/usecases/fetch_my_bookings.dart
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';
import 'package:mae_ban/feature/offer/domain/repositories/my_booking_repository.dart';

class FetchMyBookings {
  final MyBookingRepository repository;

  FetchMyBookings(this.repository);

  Future<List<Booking>> execute(String token, String username) {
    return repository.fetchBookings(token, username);
  }
}
