// domain/repositories/history_user_repository.dart
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';

abstract class HistoryUserRepository {
  Future<List<Booking>> fetchHistoryUserBookings(String token, String username);
}
