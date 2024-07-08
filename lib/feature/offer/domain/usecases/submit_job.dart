import 'package:equatable/equatable.dart';
import '../repositories/job_repository.dart';

class SubmitJob {
  final JobRepository repository;

  SubmitJob(this.repository);

  Future<Map<String, dynamic>> execute(SubmitJobParams params) async {
    return await repository.submitJob(params);
  }
}

class SubmitJobParams extends Equatable {
  final String billCode;
  final String token;

  const SubmitJobParams({
    required this.billCode,
    required this.token,
  });

  @override
  List<Object?> get props => [billCode, token];
}
