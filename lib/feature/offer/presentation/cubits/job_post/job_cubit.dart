import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/feature/offer/domain/usecases/submit_job.dart';
import 'job_state.dart';

class JobCubit extends Cubit<JobState> {
  final SubmitJob submitJob;

  JobCubit(this.submitJob) : super(JobInitial());

  Future<void> executeSubmitJob(SubmitJobParams params) async {
    emit(JobLoading());
    try {
      final result = await submitJob.execute(params);
      final postJobId = result['post_job_Id']; // Ensure this key is correct
      print('Job Success with postJobId: $postJobId'); // Debug log
      emit(JobSuccess(postJobId: postJobId));
    } catch (e) {
      print('Job Failure with error: $e'); // Debug log
      emit(JobFailure(error: e.toString()));
    }
  }
}
