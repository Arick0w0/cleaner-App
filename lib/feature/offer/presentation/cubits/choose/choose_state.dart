import 'package:equatable/equatable.dart';

abstract class ChooseState extends Equatable {
  const ChooseState();

  @override
  List<Object?> get props => [];
}

class ChooseInitial extends ChooseState {}

class ChooseLoading extends ChooseState {}

class ChooseLoaded extends ChooseState {
  final List<dynamic> cleaners;

  const ChooseLoaded(this.cleaners);

  @override
  List<Object?> get props => [cleaners];
}

class ChooseError extends ChooseState {
  final String message;

  const ChooseError(this.message);

  @override
  List<Object?> get props => [message];
}

class ChooseNoData extends ChooseState {}

class ChooseCleanerChosen extends ChooseState {}
