// Billing State
import 'package:equatable/equatable.dart';

abstract class BillingState extends Equatable {
  const BillingState();

  @override
  List<Object> get props => [];
}

class BillingInitial extends BillingState {}

class BillingLoading extends BillingState {}

class BillingSuccess extends BillingState {
  final String billCode;

  const BillingSuccess({required this.billCode});

  @override
  List<Object> get props => [billCode];
}

class BillingFailure extends BillingState {
  final String error;

  const BillingFailure({required this.error});

  @override
  List<Object> get props => [error];
}
