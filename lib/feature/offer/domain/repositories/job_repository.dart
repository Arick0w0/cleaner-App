import 'package:mae_ban/feature/offer/domain/usecases/submit_job.dart';

abstract class JobRepository {
  Future<Map<String, dynamic>> submitJob(SubmitJobParams params);
}
