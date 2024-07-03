import 'package:mae_ban/feature/hunter/data/datasource/start_job_remote_data_source.dart';
import 'package:mae_ban/feature/hunter/domain/repositories/start_job_repository.dart';

class StartJobDetailRepositoryImpl implements StartJobRepository {
  final StartJobDetailRemoteDataSource remoteDataSource;

  StartJobDetailRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Map<String, dynamic>> fetchStartJobDetail(String postJobId) async {
    return await remoteDataSource.fetchJobDetail(postJobId);
  }

  @override
  Future<void> submitStatusProcess(String startJobId, String newStatus) async {
    return await remoteDataSource.submitStatusProcess(startJobId, newStatus);
  }
}
