import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/feature/hunter/domain/usecases/get_history.dart';
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final GetHistory getHistory;

  HistoryCubit({required this.getHistory}) : super(HistoryInitial());

  Future<void> fetchHistory() async {
    try {
      emit(HistoryLoading());
      final history = await getHistory();
      if (history.isEmpty) {
        emit(HistoryNoData());
      } else {
        emit(HistoryLoaded(history: history));
      }
    } catch (e) {
      debugPrint('Error fetching history: $e');
      emit(HistoryError(message: e.toString()));
    }
  }
}
