import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/feature/hunter/domain/usecases/get_start_job.dart';
import 'package:mae_ban/feature/hunter/domain/usecases/submit_status_process.dart';
import 'package:mae_ban/feature/hunter/domain/usecases/sumbit_status_process_offer.dart';

import 'start_job_state.dart';

// import 'start_job_state';

class StartJobCubit extends Cubit<StartJobState> {
  final FetchStartJobDetailUseCase fetchStartJobDetailUseCase;
  final SubmitStatusProcessUseCase submitStatusProcessUseCase;
  final SubmitStatusProcessOfferUseCase submitStatusProcessOfferUseCase;

  StartJobCubit({
    required this.fetchStartJobDetailUseCase,
    required this.submitStatusProcessUseCase,
    required this.submitStatusProcessOfferUseCase,
  }) : super(const StartJobState());

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
      emit(state.copyWith(
        isLoading: false,
        statusProcessSubmitted: true,
      ));
      await fetchStartJobDetail(
          startJobId); // Refetch details after updating status
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> submitStatusProcessOffer(
      String startJobId, String newStatus) async {
    emit(state.copyWith(isLoading: true));
    try {
      await submitStatusProcessOfferUseCase(startJobId, newStatus);
      emit(state.copyWith(
        isLoading: false,
        statusProcessSubmitted: true,
      ));
      await fetchStartJobDetail(
          startJobId); // Refetch details after updating status
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
