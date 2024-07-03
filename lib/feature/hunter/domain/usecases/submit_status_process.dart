import 'package:mae_ban/feature/hunter/domain/repositories/start_job_repository.dart';

class SubmitStatusProcessUseCase {
  final StartJobRepository repository;

  SubmitStatusProcessUseCase(this.repository);

  Future<void> call(String startJobId, String newStatus) {
    return repository.submitStatusProcess(startJobId, newStatus);
  }
}
