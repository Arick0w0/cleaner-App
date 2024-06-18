import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:mae_ban/feature/auth/data/models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> loadUser() async {
    User? user = await _loadUserFromPreferences();
    if (user != null) {
      emit(UserLoaded(user: user));
    } else {
      emit(UserInitial());
    }
  }

  void saveUser(User user) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('user', jsonEncode(user.toJson()));
    emit(UserLoaded(user: user));
  }

  void clearUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('user');
    emit(UserInitial());
  }

  Future<User?> _loadUserFromPreferences() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final userJson = sharedPreferences.getString('user');
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return User.fromJson(userMap);
    }
    return null;
  }
}
