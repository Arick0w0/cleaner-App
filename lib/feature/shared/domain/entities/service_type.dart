import 'package:equatable/equatable.dart';

class ServiceType extends Equatable {
  final String id;
  final String serviceType;
  final String serviceCodeName;

  const ServiceType({
    required this.id,
    required this.serviceType,
    required this.serviceCodeName,
  });

  @override
  List<Object?> get props => [id, serviceType, serviceCodeName];
}
