import 'package:mae_ban/feature/auth/data/models/auth_response_model.dart';
import 'package:mae_ban/feature/auth/data/models/job_hunter_model.dart';
import 'package:mae_ban/feature/auth/data/models/job_offer_model.dart';
import 'package:mae_ban/feature/auth/data/service/api_service.dart';

abstract class AuthRemoteDataSource {
  Future<void> signupJobOffer(JobOfferModel jobOffer);
  Future<void> signupJobHunter(JobHunterModel jobHunter);
  Future<AuthResponseModel> login(String username, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl({required this.apiService});

  @override
  Future<void> signupJobOffer(JobOfferModel jobOffer) {
    return apiService.signupJobOffer(jobOffer);
  }

  @override
  Future<void> signupJobHunter(JobHunterModel jobHunter) {
    return apiService.signupJobHunter(jobHunter);
  }

  @override
  Future<AuthResponseModel> login(String username, String password) {
    return apiService.login(username, password);
  }
}
