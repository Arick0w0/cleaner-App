import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mae_ban/feature/hunter/domain/usecases/get_history.dart';
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';
import 'dart:io';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final GetHistory getHistory;
  final Connectivity connectivity;

  HistoryCubit({
    required this.getHistory,
    required this.connectivity,
  }) : super(HistoryInitial());

  Future<void> fetchHistory() async {
    emit(HistoryLoading());
    while (true) {
      final connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        emit(const HistoryError(message: 'No internet connection.'));
        await Future.delayed(
            const Duration(seconds: 5)); // Retry after 5 seconds
      } else {
        try {
          final history = await getHistory();
          if (history.isEmpty) {
            emit(HistoryNoData());
          } else {
            emit(HistoryLoaded(history: history));
          }
          break;
        } catch (e) {
          if (e is SocketException) {
            emit(const HistoryError(message: 'No internet connection.'));
          } else {
            emit(HistoryError(message: e.toString()));
          }
          break;
        }
      }
    }
  }
}
