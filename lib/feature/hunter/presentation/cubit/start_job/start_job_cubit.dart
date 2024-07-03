import 'package:bloc/bloc.dart';
import 'package:mae_ban/feature/hunter/domain/usecases/get_start_job.dart';
import 'package:mae_ban/feature/hunter/domain/usecases/submit_status_process.dart';

class StartJobState {
  final bool isLoading;
  final Map<String, dynamic>? startJobDetail;
  final String? errorMessage;
  final bool statusProcessSubmitted;

  StartJobState({
    this.isLoading = false,
    this.startJobDetail,
    this.errorMessage,
    this.statusProcessSubmitted = false,
  });

  StartJobState copyWith({
    bool? isLoading,
    Map<String, dynamic>? startJobDetail,
    String? errorMessage,
    bool? statusProcessSubmitted,
  }) {
    return StartJobState(
      isLoading: isLoading ?? this.isLoading,
      startJobDetail: startJobDetail ?? this.startJobDetail,
      errorMessage: errorMessage ?? this.errorMessage,
      statusProcessSubmitted:
          statusProcessSubmitted ?? this.statusProcessSubmitted,
    );
  }
}

class StartJobCubit extends Cubit<StartJobState> {
  final FetchStartJobDetailUseCase fetchStartJobDetailUseCase;
  final SubmitStatusProcessUseCase submitStatusProcessUseCase;

  StartJobCubit(
      this.fetchStartJobDetailUseCase, this.submitStatusProcessUseCase)
      : super(StartJobState());

  Future<void> fetchStartJobDetail(String startJobId) async {
    emit(state.copyWith(isLoading: true));
    try {
      final startJobDetail = await fetchStartJobDetailUseCase(startJobId);
      emit(state.copyWith(isLoading: false, startJobDetail: startJobDetail));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> submitStatusProcess(String startJobId, String newStatus) async {
    emit(state.copyWith(isLoading: true));
    try {
      await submitStatusProcessUseCase(startJobId, newStatus);
      emit(state.copyWith(isLoading: false, statusProcessSubmitted: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
