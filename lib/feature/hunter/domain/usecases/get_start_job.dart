import '../repositories/start_job_repository.dart';

class FetchStartJobDetailUseCase {
  final StartJobRepository repository;

  FetchStartJobDetailUseCase(this.repository);

  Future<Map<String, dynamic>> call(String startJobId) {
    return repository.fetchStartJobDetail(startJobId);
  }
}
