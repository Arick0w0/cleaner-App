import 'package:bloc/bloc.dart';
import 'dart:async';

class CountdownCubit extends Cubit<Duration> {
  Timer? _countdownTimer;
  Duration _currentDuration = Duration();
  bool _hasCountdownStarted = false;

  CountdownCubit() : super(Duration());

  void startCountdown(Duration countdownDuration) {
    if (_hasCountdownStarted) return;

    _currentDuration = countdownDuration;
    _hasCountdownStarted = true;

    _countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => _updateCountdown());
  }

  void _updateCountdown() {
    final seconds = _currentDuration.inSeconds - 1;
    if (seconds < 0) {
      _countdownTimer?.cancel();
    } else {
      _currentDuration = Duration(seconds: seconds);
      emit(_currentDuration);
    }
  }

  @override
  Future<void> close() {
    _countdownTimer?.cancel();
    return super.close();
  }
}
