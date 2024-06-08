import 'package:equatable/equatable.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();

  @override
  List<Object> get props => [];
}

class FetchData extends DataEvent {}

class FetchAreasByProvince extends DataEvent {
  final String provinceCodeName;

  const FetchAreasByProvince(this.provinceCodeName);

  @override
  List<Object> get props => [provinceCodeName];
}
