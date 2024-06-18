// lib/feature/offer/data/models/price_model.dart

import 'package:mae_ban/feature/offer/domain/entities/price.dart';

class PriceModel extends Price {
  PriceModel({
    required String id,
    required String name,
    required String codeName,
    required int price,
    required String rec,
  }) : super(
          id: id,
          name: name,
          codeName: codeName,
          price: price,
          rec: rec,
        );

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
      id: json['_id'],
      name: json['name'],
      codeName: json['code_name'],
      price: json['price'],
      rec: json['rec'],
    );
  }
}
