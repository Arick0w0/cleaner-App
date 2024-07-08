import '../../domain/repositories/job_repository.dart';
import '../datasources/job_remote_data_source.dart';
import '../../domain/usecases/submit_job.dart';

class JobRepositoryImpl implements JobRepository {
  final JobRemoteDataSource remoteDataSource;

  JobRepositoryImpl(this.remoteDataSource);

  @override
  Future<Map<String, dynamic>> submitJob(SubmitJobParams params) async {
    return await remoteDataSource.submitJob(params.billCode, params.token);
  }
}
