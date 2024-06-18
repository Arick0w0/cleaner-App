import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mae_ban/feature/offer/presentation/cubits/selection/selection_state.dart';

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
          ),
        );

  void updateLocation(String location) {
    emit(state.copyWith(selectedLocation: location));
  }

  void updateType(String type) {
    String updatedUnits;
    int updatedPrice;
    double updatedValue;

    if (type == 'ບ້ານ 1 ຊັ້ນ (ບໍ່ເກີນ 100 ຕລ.ມ)') {
      updatedUnits = '2:30 ຊ.ມ';
      updatedPrice = 150000;
      updatedValue = 2.5;
    } else if (type == 'ບ້ານ 2-3 ຊັ້ນ (100-200 ຕລ.ມ)') {
      updatedUnits = '4:30 ຊ.ມ';
      updatedPrice = 150000;
      updatedValue = 4.5;
    } else if (type == 'ບ້ານ (ຫຼາຍກວ່າ 200 ຕລ.ມ)') {
      updatedUnits = '8 ຊ.ມ';
      updatedPrice = 150000;
      updatedValue = 8.0;
    } else {
      updatedUnits = state.selectedUnits;
      updatedPrice = state.selectedPrice;
      updatedValue = state.selectedValue;
    }

    emit(state.copyWith(
      selectedType: type,
      selectedUnits: updatedUnits,
      selectedPrice: updatedPrice,
      selectedValue: updatedValue,
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
