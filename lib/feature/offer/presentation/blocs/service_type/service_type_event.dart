// lib/feature/joboffer/presentation/blocs/service_type_event.dart
part of 'service_type_bloc.dart';

abstract class ServiceTypeEvent extends Equatable {
  const ServiceTypeEvent();

  @override
  List<Object> get props => [];
}

class FetchServiceTypes extends ServiceTypeEvent {}
