import 'package:mae_ban/feature/hunter/data/repositories/booking_repository.dart';

class AcceptBooking {
  final BookingRepository repository;

  AcceptBooking({required this.repository});

  Future<void> call(String billCode) async {
    return await repository.acceptBooking(billCode);
  }
}
