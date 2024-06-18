// lib/feature/offer/domain/entities/price.dart

class Price {
  final String id;
  final String name;
  final String codeName;
  final int price;
  final String rec;

  Price({
    required this.id,
    required this.name,
    required this.codeName,
    required this.price,
    required this.rec,
  });
}
