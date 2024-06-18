import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit สำหรับการจัดการสถานะการเลือก
class SelectionCubit extends Cubit<String> {
  SelectionCubit(super.initialState);

  void select(String value) {
    emit(value);
  }
}
