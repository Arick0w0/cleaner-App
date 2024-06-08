import 'package:equatable/equatable.dart';
import 'service_type_model.dart';

class ServiceTypeResponse extends Equatable {
  final List<ServiceTypeModel> data;
  final bool error;
  final int total;

  const ServiceTypeResponse({
    required this.data,
    required this.error,
    required this.total,
  });

  factory ServiceTypeResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<ServiceTypeModel> dataList =
        list.map((i) => ServiceTypeModel.fromJson(i)).toList();

    return ServiceTypeResponse(
      data: dataList,
      error: json['error'],
      total: json['total'],
    );
  }

  @override
  List<Object?> get props => [data, error, total];
}
