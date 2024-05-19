import 'package:mae_ban/feature/auth/data/models/auth_response_model.dart';
import 'package:mae_ban/feature/auth/data/models/job_hunter_model.dart';
import 'package:mae_ban/feature/auth/data/models/job_offer_model.dart';

abstract class AuthRepository {
  Future<void> signupJobOffer(JobOfferModel jobOffer);
  Future<void> signupJobHunter(JobHunterModel jobHunter);

  Future<AuthResponseModel> login(String username, String password);
}
