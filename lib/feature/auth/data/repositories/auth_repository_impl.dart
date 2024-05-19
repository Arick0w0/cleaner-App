import 'package:mae_ban/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mae_ban/feature/auth/data/models/auth_response_model.dart';
import 'package:mae_ban/feature/auth/data/models/job_hunter_model.dart';
import 'package:mae_ban/feature/auth/data/models/job_offer_model.dart';
import 'package:mae_ban/feature/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> signupJobOffer(JobOfferModel jobOffer) async {
    await remoteDataSource.signupJobOffer(jobOffer);
  }

  @override
  Future<void> signupJobHunter(JobHunterModel jobHunter) async {
    await remoteDataSource.signupJobHunter(jobHunter);
  }

  @override
  Future<AuthResponseModel> login(String username, String password) async {
    return remoteDataSource.login(username, password);
  }
}
