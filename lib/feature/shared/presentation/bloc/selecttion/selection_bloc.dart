import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/selecttion/selection_event.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/selecttion/selection_state.dart';

class SelectionBloc extends Bloc<SelectionEvent, SelectionState> {
  SelectionBloc() : super(SelectionState()) {
    on<SelectServiceTypes>((event, emit) {
      emit(state.copyWith(selectedServiceTypes: event.serviceTypes));
    });

    on<SelectProvince>((event, emit) {
      emit(
          state.copyWith(selectedProvince: event.province, selectedArea: null));
    });

    on<SelectArea>((event, emit) {
      emit(state.copyWith(selectedArea: event.area));
    });
  }
}
