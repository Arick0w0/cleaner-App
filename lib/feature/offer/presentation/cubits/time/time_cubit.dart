import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/feature/offer/domain/usecases/get_times.dart';
import 'package:mae_ban/feature/offer/presentation/cubits/time/time_state.dart';

class TimeCubit extends Cubit<TimeState> {
  final GetTimes getTimes;

  TimeCubit({required this.getTimes}) : super(TimeInitial());

  Future<void> fetchTimes() async {
    try {
      emit(TimeLoading());
      final times = await getTimes();
      emit(TimeLoaded(times));
    } catch (e) {
      emit(TimeError(e.toString()));
    }
  }
}
