import 'package:mae_ban/feature/auth/data/models/job_offer_model.dart';
import 'package:mae_ban/feature/auth/domain/repositories/auth_repository.dart';

class SignUpJobOffer {
  final AuthRepository repository;

  SignUpJobOffer(this.repository);

  Future<void> execute(JobOfferModel jobOffer) async {
    return await repository.signupJobOffer(jobOffer);
  }
}
