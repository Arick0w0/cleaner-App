// lib/feature/joboffer/presentation/blocs/service_type_state.dart
part of 'service_type_bloc.dart';

abstract class ServiceTypeState extends Equatable {
  const ServiceTypeState();

  @override
  List<Object> get props => [];
}

class ServiceTypeInitial extends ServiceTypeState {}

class ServiceTypeLoading extends ServiceTypeState {}

class ServiceTypeLoaded extends ServiceTypeState {
  final List<ServiceType> serviceTypes;

  const ServiceTypeLoaded({required this.serviceTypes});

  @override
  List<Object> get props => [serviceTypes];
}

class ServiceTypeError extends ServiceTypeState {
  final String message;

  const ServiceTypeError({required this.message});

  @override
  List<Object> get props => [message];
}
