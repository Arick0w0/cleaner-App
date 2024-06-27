// selection_cubit.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'selection_state.dart';

class SelectionCubit extends Cubit<SelectionState> {
  SelectionCubit()
      : super(
          SelectionState(
            selectedLocation: 'ນະຄອນຫຼວງວຽງຈັນ',
            selectedType: 'ບ້ານ 1 ຊັ້ນ (ບໍ່ເກີນ 100 ຕລ.ມ)',
            selectedUnits: '2:30 ຊ.ມ',
            selectedDate: DateTime.now(),
            selectedTime: TimeOfDay(hour: 0, minute: 0),
            serviceCost: '375.000',
            selectedPrice: 150000,
            selectedValue: 1,
            codename: '1F_HOUSE_<100', // Initialize codename
          ),
        );

  void updateLocation(String location) {
    emit(state.copyWith(selectedLocation: location));
  }

  void updateType(String type) {
    String updatedUnits;
    int updatedPrice;
    double updatedValue;
    String updatedCodename; // Declare codename variable

    if (type == 'ບ້ານ 1 ຊັ້ນ (ບໍ່ເກີນ 100 ຕລ.ມ)') {
      updatedUnits = '2:30 ຊ.ມ';
      updatedPrice = 150000;
      updatedValue = 2.5;
      updatedCodename = '1F_HOUSE_<100'; // Set codename for this type
    } else if (type == 'ບ້ານ 2-3 ຊັ້ນ (100-200 ຕລ.ມ)') {
      updatedUnits = '4:30 ຊ.ມ';
      updatedPrice = 150000;
      updatedValue = 4.5;
      updatedCodename = '2-3F_HOUSE_100-200'; // Set codename for this type
    } else if (type == 'ບ້ານ (ຫຼາຍກວ່າ 200 ຕລ.ມ)') {
      updatedUnits = '8 ຊ.ມ';
      updatedPrice = 150000;
      updatedValue = 8.0;
      updatedCodename = 'HOUSE_>200'; // Set codename for this type
    } else {
      updatedUnits = state.selectedUnits;
      updatedPrice = state.selectedPrice;
      updatedValue = state.selectedValue;
      updatedCodename = state.codename; // Use current codename
    }

    emit(state.copyWith(
      selectedType: type,
      selectedUnits: updatedUnits,
      selectedPrice: updatedPrice,
      selectedValue: updatedValue,
      codename: updatedCodename, // Update codename
    ));
    _calculateFinalCost();
  }

  void updateUnits(String units, double value) {
    print('Selected Units: $units'); // Print selected units
    print('Selected Value: $value'); // Print selected value
    emit(state.copyWith(selectedUnits: units, selectedValue: value));
    _calculateFinalCost();
  }

  void updateDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void updateTime(TimeOfDay time) {
    emit(state.copyWith(selectedTime: time));
  }

  void _calculateFinalCost() {
    final totalCost = state.selectedPrice * state.selectedValue;
    emit(state.copyWith(serviceCost: formatPrice(totalCost)));
  }

  String formatPrice(double price) {
    final formatter = NumberFormat('#,###');
    return formatter.format(price);
  }
}
