import 'package:bloc/bloc.dart';

class ObscureTextCubit extends Cubit<bool> {
  ObscureTextCubit() : super(true);

  void toggleObscureText() => emit(!state);
}

class GenderSelectionCubit extends Cubit<String> {
  GenderSelectionCubit() : super('MALE');

  void selectGender(String gender) => emit(gender);
}
