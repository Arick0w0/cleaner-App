// data/repositories/my_booking_repository_impl.dart
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';
import 'package:mae_ban/feature/offer/domain/repositories/my_booking_repository.dart';
import 'package:mae_ban/feature/offer/data/datasources/my_booking_remote_data_source.dart';

class MyBookingRepositoryImpl implements MyBookingRepository {
  final MyBookingRemoteDataSource remoteDataSource;

  MyBookingRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Booking>> fetchBookings(String token, String username) async {
    return await remoteDataSource.fetchBookings(token, username);
  }
}
