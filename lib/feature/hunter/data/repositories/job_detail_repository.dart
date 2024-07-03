import 'package:mae_ban/feature/hunter/data/datasource/job_detail_remote_data_source.dart';

abstract class JobDetailRepository {
  Future<Map<String, dynamic>> getJobDetail(String postJobId);
}

class JobDetailRepositoryImpl implements JobDetailRepository {
  final JobDetailRemoteDataSource remoteDataSource;

  JobDetailRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Map<String, dynamic>> getJobDetail(String postJobId) async {
    return await remoteDataSource.fetchJobDetail(postJobId);
  }
}
