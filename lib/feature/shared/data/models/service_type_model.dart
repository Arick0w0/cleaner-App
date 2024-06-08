import 'package:mae_ban/feature/shared/domain/entities/service_type.dart';

class ServiceTypeModel extends ServiceType {
  const ServiceTypeModel({
    required String id,
    required String serviceType,
    required String serviceCodeName,
  }) : super(
          id: id,
          serviceType: serviceType,
          serviceCodeName: serviceCodeName,
        );

  factory ServiceTypeModel.fromJson(Map<String, dynamic> json) {
    return ServiceTypeModel(
      id: json['_id'],
      serviceType: json['service_type'],
      serviceCodeName: json['service_code_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'service_type': serviceType,
      'service_code_name': serviceCodeName,
    };
  }

  @override
  List<Object?> get props => [id, serviceType, serviceCodeName];
}
