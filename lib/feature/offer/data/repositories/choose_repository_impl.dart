import 'package:mae_ban/feature/offer/data/datasources/choose_remote_data_source.dart';
import 'package:mae_ban/feature/offer/domain/repositories/choose_repository.dart';

class ChooseRepositoryImpl implements ChooseRepository {
  final ChooseRemoteDataSource remoteDataSource;

  ChooseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<dynamic>> fetchCleaners(String postJobId) async {
    return await remoteDataSource.fetchCleaners(postJobId);
  }

  @override
  Future<void> chooseCleaner(String billCode, String hunterUsername) async {
    await remoteDataSource.chooseCleaner(billCode, hunterUsername);
  }
}
