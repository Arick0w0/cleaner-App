import 'package:equatable/equatable.dart';
import 'package:mae_ban/feature/shared/data/models/area_model.dart';
import 'package:mae_ban/feature/shared/data/models/province_model.dart';
import 'package:mae_ban/feature/shared/data/models/service_type_model.dart';

abstract class SelectionEvent extends Equatable {
  const SelectionEvent();

  @override
  List<Object> get props => [];
}

class SelectServiceTypes extends SelectionEvent {
  final List<ServiceTypeModel> serviceTypes;

  const SelectServiceTypes(this.serviceTypes);

  @override
  List<Object> get props => [serviceTypes];
}

class SelectProvince extends SelectionEvent {
  final Province province;

  const SelectProvince(this.province);

  @override
  List<Object> get props => [province];
}

class SelectArea extends SelectionEvent {
  final Area area;

  const SelectArea(this.area);

  @override
  List<Object> get props => [area];
}
