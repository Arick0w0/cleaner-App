import 'package:mae_ban/feature/offer/data/datasources/time_remote_datasource.dart';
import 'package:mae_ban/feature/offer/domain/entities/time.dart';
import 'package:mae_ban/feature/offer/domain/repositories/time_repository.dart';

class TimeRepositoryImpl implements TimeRepository {
  final TimeRemoteDataSource remoteDataSource;

  TimeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Time>> getTimes() async {
    final times = await remoteDataSource.fetchTimes();
    return times;
  }
}
