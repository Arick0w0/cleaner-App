import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/getdata/data_event.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/getdata/data_state.dart';
import 'package:mae_ban/feature/shared/data/services/api_service.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final ApiServiceGet apiService;

  DataBloc({required this.apiService}) : super(DataInitial()) {
    on<FetchData>(_onFetchData);
    on<FetchAreasByProvince>(_onFetchAreasByProvince);
  }

  Future<void> _onFetchData(FetchData event, Emitter<DataState> emit) async {
    emit(DataLoading());
    try {
      final serviceTypes = await apiService.fetchServiceTypes();
      final provinces = await apiService.fetchProvinces();
      emit(DataLoaded(serviceTypes: serviceTypes, provinces: provinces));
    } catch (e) {
      emit(DataError(message: e.toString()));
    }
  }

  Future<void> _onFetchAreasByProvince(
      FetchAreasByProvince event, Emitter<DataState> emit) async {
    try {
      final areas =
          await apiService.fetchAreasByProvince(event.provinceCodeName);
      emit(DataLoaded(
        serviceTypes: (state as DataLoaded).serviceTypes,
        provinces: (state as DataLoaded).provinces,
        areas: areas,
      ));
    } catch (e) {
      emit(DataError(message: e.toString()));
    }
  }
}
