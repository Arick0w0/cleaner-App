import 'package:equatable/equatable.dart';

class ServiceType extends Equatable {
  final String id;
  final String serviceType;
  final String isActive;

  const ServiceType({
    required this.id,
    required this.serviceType,
    required this.isActive,
  });

  @override
  List<Object?> get props => [id, serviceType, isActive];
}
