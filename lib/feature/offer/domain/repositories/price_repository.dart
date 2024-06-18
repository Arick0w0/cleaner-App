// lib/feature/offer/domain/repositories/price_repository.dart

import 'package:mae_ban/feature/offer/domain/entities/price.dart';

abstract class PriceRepository {
  Future<List<Price>> getPrices();
}
