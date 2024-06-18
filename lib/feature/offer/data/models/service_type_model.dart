// lib/feature/joboffer/data/models/service_type_model.dart
class ServiceTypeModel {
  final String id;
  final String imageType;
  final String serviceType;
  final String serviceCodeName;

  ServiceTypeModel({
    required this.id,
    required this.imageType,
    required this.serviceType,
    required this.serviceCodeName,
  });

  factory ServiceTypeModel.fromJson(Map<String, dynamic> json) {
    return ServiceTypeModel(
      id: json['_id'],
      imageType: json['image_type'],
      serviceType: json['service_type'],
      serviceCodeName: json['service_code_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'image_type': imageType,
      'service_type': serviceType,
      'service_code_name': serviceCodeName,
    };
  }
}
