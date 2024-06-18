// lib/feature/joboffer/presentation/blocs/service_type_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mae_ban/feature/offer/domain/entities/service_type.dart';
import 'package:mae_ban/feature/offer/domain/usecases/get_service_types.dart';

part 'service_type_event.dart';
part 'service_type_state.dart';

class ServiceTypeBloc extends Bloc<ServiceTypeEvent, ServiceTypeState> {
  final GetServiceTypes getServiceTypes;

  ServiceTypeBloc({required this.getServiceTypes})
      : super(ServiceTypeInitial()) {
    on<FetchServiceTypes>((event, emit) async {
      emit(ServiceTypeLoading());
      try {
        final serviceTypes = await getServiceTypes();
        print('Service types loaded: $serviceTypes'); // Debugging line
        emit(ServiceTypeLoaded(serviceTypes: serviceTypes));
      } catch (e) {
        print('Error occurred: $e'); // Debugging line
        emit(ServiceTypeError(message: e.toString()));
      }
    });
  }
}
