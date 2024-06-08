import 'package:equatable/equatable.dart';
import 'package:mae_ban/feature/shared/data/models/area_model.dart';
import 'package:mae_ban/feature/shared/data/models/province_model.dart';
import 'package:mae_ban/feature/shared/data/models/service_type_model.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object> get props => [];
}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataLoaded extends DataState {
  final List<ServiceTypeModel> serviceTypes;
  final List<Province> provinces;
  final List<Area>? areas;

  DataLoaded({
    required this.serviceTypes,
    required this.provinces,
    this.areas,
  });

  @override
  List<Object> get props => [serviceTypes, provinces, areas ?? []];
}

class DataError extends DataState {
  final String message;

  DataError({required this.message});

  @override
  List<Object> get props => [message];
}
