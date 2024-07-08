// domain/repositories/my_booking_repository.dart
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';

abstract class MyBookingRepository {
  Future<List<Booking>> fetchBookings(String token, String username);
}
