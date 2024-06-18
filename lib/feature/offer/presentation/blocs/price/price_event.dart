import 'package:flutter/material.dart';
import 'package:mae_ban/feature/offer/domain/entities/price.dart';

@immutable
abstract class PriceEvent {}

class FetchPrices extends PriceEvent {}

abstract class PriceState {}

class PriceInitial extends PriceState {}

class PriceLoading extends PriceState {}

class PriceLoaded extends PriceState {
  final List<Price> prices;

  PriceLoaded(this.prices);
}
