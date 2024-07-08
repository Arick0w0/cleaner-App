import 'package:equatable/equatable.dart';

abstract class JobState extends Equatable {
  const JobState();

  @override
  List<Object> get props => [];
}

class JobInitial extends JobState {}

class JobLoading extends JobState {}

class JobSuccess extends JobState {
  final String postJobId;

  const JobSuccess({required this.postJobId});

  @override
  List<Object> get props => [postJobId];
}

class JobFailure extends JobState {
  final String error;

  const JobFailure({required this.error});

  @override
  List<Object> get props => [error];
}
