import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mae_ban/feature/offer/domain/entities/service_type.dart';
import 'package:mae_ban/feature/offer/domain/usecases/get_service_types.dart';

part 'service_type_event.dart';
part 'service_type_state.dart';

class ServiceTypeBloc extends Bloc<ServiceTypeEvent, ServiceTypeState> {
  final GetServiceTypes getServiceTypes;
  final Connectivity connectivity;

  ServiceTypeBloc({required this.getServiceTypes, required this.connectivity})
      : super(ServiceTypeInitial()) {
    on<FetchServiceTypes>((event, emit) async {
      emit(ServiceTypeLoading());
      while (true) {
        final connectivityResult = await connectivity.checkConnectivity();
        if (connectivityResult == ConnectivityResult.none) {
          await Future.delayed(
              const Duration(seconds: 5)); // Retry after 5 seconds
        } else {
          try {
            final serviceTypes = await getServiceTypes();
            emit(ServiceTypeLoaded(serviceTypes: serviceTypes));
            break;
          } catch (e) {
            emit(ServiceTypeError(
                message: 'Failed to load services. Please try again later.'));
            break;
          }
        }
      }
    });
  }
}
