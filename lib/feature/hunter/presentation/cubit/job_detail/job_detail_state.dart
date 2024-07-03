part of 'job_detail_cubit.dart';

abstract class JobDetailState extends Equatable {
  const JobDetailState();

  @override
  List<Object?> get props => [];
}

class JobDetailInitial extends JobDetailState {}

class JobDetailLoading extends JobDetailState {}

class JobDetailLoaded extends JobDetailState {
  final Map<String, dynamic> jobDetail;

  const JobDetailLoaded({required this.jobDetail});

  @override
  List<Object?> get props => [jobDetail];
}

class JobDetailError extends JobDetailState {
  final String message;

  const JobDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}
