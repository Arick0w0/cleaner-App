import 'package:mae_ban/feature/hunter/domain/repositories/start_job_repository.dart';

class SubmitStatusProcessOfferUseCase {
  final StartJobRepository repository;

  SubmitStatusProcessOfferUseCase(this.repository);

  Future<void> call(String startJobId, String newStatus) {
    return repository.submitStatusProcessOffer(startJobId, newStatus);
  }
}
