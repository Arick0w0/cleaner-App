// data/repositories/history_user_repository_impl.dart
import 'package:mae_ban/feature/offer/data/datasources/history_user_remote_data_source.dart';
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';
import 'package:mae_ban/feature/offer/domain/repositories/history_user_repository.dart';

class HistoryUserRepositoryImpl implements HistoryUserRepository {
  final HistoryUserRemoteDataSource remoteDataSource;

  HistoryUserRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Booking>> fetchHistoryUserBookings(
      String token, String username) {
    return remoteDataSource.fetchHistoryUserBookings(token, username);
  }
}
