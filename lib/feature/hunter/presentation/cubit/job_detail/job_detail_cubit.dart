import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mae_ban/feature/hunter/domain/usecases/get_job_detail.dart';

part 'job_detail_state.dart';

class JobDetailCubit extends Cubit<JobDetailState> {
  final GetJobDetail getJobDetail;

  JobDetailCubit({required this.getJobDetail}) : super(JobDetailInitial());

  Future<void> fetchJobDetail(String postJobId) async {
    try {
      emit(JobDetailLoading());
      final jobDetail = await getJobDetail(postJobId);
      emit(JobDetailLoaded(jobDetail: jobDetail));
    } catch (e) {
      emit(JobDetailError(message: e.toString()));
    }
  }
}
