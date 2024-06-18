// selection_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/feature/shared/data/models/service_type_model.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/selecttion/selection_event.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/selecttion/selection_state.dart';

class SelectionBloc extends Bloc<SelectionEvent, SelectionState> {
  SelectionBloc() : super(SelectionState()) {
    on<SelectServiceTypes>((event, emit) {
      emit(state.copyWith(selectedServiceTypes: event.serviceTypes));
    });

    on<ToggleServiceType>((event, emit) {
      final List<ServiceTypeModel> updatedServiceTypes =
          List.from(state.selectedServiceTypes);
      final index =
          updatedServiceTypes.indexWhere((st) => st.id == event.serviceType.id);
      if (index >= 0) {
        updatedServiceTypes.removeAt(index);
      } else {
        updatedServiceTypes.add(event.serviceType);
      }
      emit(state.copyWith(selectedServiceTypes: updatedServiceTypes));
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
