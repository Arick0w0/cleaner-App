// selection_state.dart
import 'package:flutter/material.dart';

class SelectionState {
  final String selectedLocation;
  final String selectedType;
  final String selectedUnits;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final String serviceCost;
  final int selectedPrice;
  final double selectedValue;
  final String codename; // Add codename field

  SelectionState({
    required this.selectedLocation,
    required this.selectedType,
    required this.selectedUnits,
    required this.selectedDate,
    required this.selectedTime,
    required this.serviceCost,
    required this.selectedPrice,
    required this.selectedValue,
    required this.codename, // Initialize codename
  });

  SelectionState copyWith({
    String? selectedLocation,
    String? selectedType,
    String? selectedUnits,
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    String? serviceCost,
    int? selectedPrice,
    double? selectedValue,
    String? codename, // Add codename to copyWith
  }) {
    return SelectionState(
      selectedLocation: selectedLocation ?? this.selectedLocation,
      selectedType: selectedType ?? this.selectedType,
      selectedUnits: selectedUnits ?? this.selectedUnits,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      serviceCost: serviceCost ?? this.serviceCost,
      selectedPrice: selectedPrice ?? this.selectedPrice,
      selectedValue: selectedValue ?? this.selectedValue,
      codename: codename ?? this.codename, // Copy codename
    );
  }
}
