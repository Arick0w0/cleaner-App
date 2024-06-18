class ServiceTypess {
  final String id;
  final String serviceType;
  final String isActive;

  ServiceTypess({
    required this.id,
    required this.serviceType,
    required this.isActive,
  });

  factory ServiceTypess.fromJson(Map<String, dynamic> json) {
    return ServiceTypess(
      id: json['id'] ?? '',
      serviceType: json['service_type'] ?? '',
      isActive: json['is_active'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_type': serviceType,
      'is_active': isActive,
    };
  }
}
