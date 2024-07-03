import 'package:mae_ban/feature/hunter/data/repositories/booking_repository.dart';
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';

class GetBookings {
  final BookingRepository repository;

  GetBookings({required this.repository});

  Future<List<Booking>> call() async {
    return await repository.fetchBookings();
  }
}
