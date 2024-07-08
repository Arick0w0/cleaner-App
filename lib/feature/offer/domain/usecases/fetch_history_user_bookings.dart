// domain/usecases/fetch_history_user_bookings.dart
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';
import 'package:mae_ban/feature/offer/domain/repositories/history_user_repository.dart';

class FetchHistoryUserBookings {
  final HistoryUserRepository repository;

  FetchHistoryUserBookings(this.repository);

  Future<List<Booking>> call(String token, String username) {
    return repository.fetchHistoryUserBookings(token, username);
  }
}
