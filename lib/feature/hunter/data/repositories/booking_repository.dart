import 'package:mae_ban/feature/hunter/data/datasource/booking_remote_data_source.dart';
import 'package:mae_ban/feature/hunter/data/datasource/history_remote_data_source.dart';
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';

abstract class BookingRepository {
  Future<List<Booking>> fetchBookings();
  Future<List<Booking>> fetchHistory();
  Future<void> acceptBooking(String billCode);
}

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource bookingRemoteDataSource;
  final HistoryRemoteDataSource historyRemoteDataSource;

  BookingRepositoryImpl(
      {required this.bookingRemoteDataSource,
      required this.historyRemoteDataSource});

  @override
  Future<List<Booking>> fetchBookings() async {
    return await bookingRemoteDataSource.fetchBookings();
  }

  @override
  Future<List<Booking>> fetchHistory() async {
    return await historyRemoteDataSource.fetchHistory();
  }

  @override
  Future<void> acceptBooking(String billCode) async {
    return await bookingRemoteDataSource.acceptBooking(billCode);
  }
}
