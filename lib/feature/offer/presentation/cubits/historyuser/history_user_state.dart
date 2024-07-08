// presentation/cubits/historyuser/history_user_state.dart
import 'package:equatable/equatable.dart';
import 'package:mae_ban/feature/offer/domain/entities/booking.dart';

abstract class HistoryUserState extends Equatable {
  const HistoryUserState();

  @override
  List<Object> get props => [];
}

class HistoryUserInitial extends HistoryUserState {}

class HistoryUserLoading extends HistoryUserState {}

class HistoryUserLoaded extends HistoryUserState {
  final List<Booking> bookings;

  const HistoryUserLoaded(this.bookings);

  @override
  List<Object> get props => [bookings];
}

class HistoryUserNoData extends HistoryUserState {}

class HistoryUserError extends HistoryUserState {
  final String message;

  const HistoryUserError({required this.message});

  @override
  List<Object> get props => [message];
}
