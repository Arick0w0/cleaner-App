import 'package:equatable/equatable.dart';
import 'package:mae_ban/feature/offer/domain/entities/time.dart';

abstract class TimeState extends Equatable {
  const TimeState();

  @override
  List<Object> get props => [];
}

class TimeInitial extends TimeState {}

class TimeLoading extends TimeState {}

class TimeLoaded extends TimeState {
  final List<Time> times;

  const TimeLoaded(this.times);

  @override
  List<Object> get props => [times];
}

class TimeError extends TimeState {
  final String message;

  const TimeError(this.message);

  @override
  List<Object> get props => [message];
}
