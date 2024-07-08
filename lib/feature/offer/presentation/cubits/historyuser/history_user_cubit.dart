// presentation/cubits/historyuser/history_user_cubit.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/feature/offer/domain/repositories/history_user_repository.dart';
import 'dart:io';

import 'history_user_state.dart';

class HistoryUserCubit extends Cubit<HistoryUserState> {
  final HistoryUserRepository repository;
  final Connectivity connectivity;

  HistoryUserCubit({required this.repository, required this.connectivity})
      : super(HistoryUserInitial());

  Future<void> loadHistoryUserBookings(String token, String username) async {
    emit(HistoryUserLoading());
    while (true) {
      final connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        emit(const HistoryUserError(message: 'No internet connection.'));
        await Future.delayed(
            const Duration(seconds: 5)); // Retry after 5 seconds
      } else {
        try {
          final bookings =
              await repository.fetchHistoryUserBookings(token, username);
          if (bookings.isEmpty) {
            emit(HistoryUserNoData());
          } else {
            emit(HistoryUserLoaded(bookings));
          }
          break;
        } catch (e) {
          if (e is SocketException) {
            emit(const HistoryUserError(message: 'No internet connection.'));
          } else if (e.toString().contains('No data found')) {
            emit(HistoryUserNoData());
          } else {
            emit(HistoryUserError(message: e.toString()));
          }
          break;
        }
      }
    }
  }
}
