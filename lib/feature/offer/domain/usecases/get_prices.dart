// lib/feature/offer/domain/usecases/get_prices.dart

import 'package:mae_ban/feature/offer/domain/entities/price.dart';
import 'package:mae_ban/feature/offer/domain/repositories/price_repository.dart';

class GetPrices {
  final PriceRepository repository;

  GetPrices(this.repository);

  Future<List<Price>> call() async {
    return await repository.getPrices();
  }
}
