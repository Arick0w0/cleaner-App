// lib/feature/offer/data/repositories/price_repository_impl.dart

import 'package:mae_ban/feature/offer/domain/entities/price.dart';
import 'package:mae_ban/feature/offer/domain/repositories/price_repository.dart';
import 'package:mae_ban/feature/offer/data/datasources/price_remote_data_source.dart';

class PriceRepositoryImpl implements PriceRepository {
  final PriceRemoteDataSource remoteDataSource;

  PriceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Price>> getPrices() async {
    return await remoteDataSource.getPrices();
  }
}
