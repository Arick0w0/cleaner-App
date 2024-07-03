import 'package:mae_ban/feature/hunter/data/repositories/job_detail_repository.dart';

class GetJobDetail {
  final JobDetailRepository repository;

  GetJobDetail({required this.repository});

  Future<Map<String, dynamic>> call(String postJobId) async {
    return await repository.getJobDetail(postJobId);
  }
}
