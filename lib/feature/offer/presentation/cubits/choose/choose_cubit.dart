import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/feature/offer/domain/usecases/choose_use_cases.dart';
import 'choose_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';

class ChooseCubit extends Cubit<ChooseState> {
  final FetchCleaners fetchCleaners;
  final ChooseCleaner chooseCleaner;
  final Connectivity connectivity;

  ChooseCubit({
    required this.fetchCleaners,
    required this.chooseCleaner,
    required this.connectivity,
  }) : super(ChooseInitial());

  Future<void> loadCleaners(String postJobId) async {
    emit(ChooseLoading());
    while (true) {
      final connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        emit(const ChooseError('No internet connection.'));
        await Future.delayed(
            const Duration(seconds: 5)); // Retry after 5 seconds
      } else {
        try {
          final cleaners = await fetchCleaners.execute(postJobId);
          if (cleaners.isEmpty) {
            emit(ChooseNoData());
          } else {
            emit(ChooseLoaded(cleaners));
          }
          break;
        } catch (e) {
          if (e is SocketException) {
            emit(const ChooseError('No internet connection.'));
          } else {
            emit(ChooseError(e.toString()));
          }
          break;
        }
      }
    }
  }

  Future<void> chooseCleanerForJob(
      String billCode, String hunterUsername) async {
    try {
      await chooseCleaner.execute(billCode, hunterUsername);
      emit(ChooseCleanerChosen());
    } catch (e) {
      emit(ChooseError(e.toString()));
    }
  }
}
