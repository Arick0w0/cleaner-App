// States
import 'package:equatable/equatable.dart';
import 'package:mae_ban/feature/shared/data/models/area_model.dart';
import 'package:mae_ban/feature/shared/data/models/province_model.dart';
import 'package:mae_ban/feature/shared/data/models/service_type_model.dart';

class SelectionState extends Equatable {
  final List<ServiceTypeModel> selectedServiceTypes;
  final Province? selectedProvince;
  final Area? selectedArea;

  const SelectionState({
    this.selectedServiceTypes = const [],
    this.selectedProvince,
    this.selectedArea,
  });

  SelectionState copyWith({
    List<ServiceTypeModel>? selectedServiceTypes,
    Province? selectedProvince,
    Area? selectedArea,
  }) {
    return SelectionState(
      selectedServiceTypes: selectedServiceTypes ?? this.selectedServiceTypes,
      selectedProvince: selectedProvince ?? this.selectedProvince,
      selectedArea: selectedArea ?? this.selectedArea,
    );
  }

  @override
  List<Object?> get props =>
      [selectedServiceTypes, selectedProvince, selectedArea];
}
