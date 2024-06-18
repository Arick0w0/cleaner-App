import 'package:mae_ban/feature/auth/data/models/auth_response_model.dart';
import 'package:mae_ban/feature/auth/data/models/job_hunter_model.dart';
import 'package:mae_ban/feature/auth/domain/repositories/auth_repository.dart';

class SignUpJobHunter {
  final AuthRepository repository;

  SignUpJobHunter(this.repository);

  Future<AuthResponseModel> execute(JobHunterModel jobHunter) async {
    return await repository.signupJobHunter(jobHunter);
  }
}
