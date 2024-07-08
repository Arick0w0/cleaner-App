import 'package:mae_ban/feature/auth/data/models/address_model.dart';
import 'package:mae_ban/feature/offer/domain/repositories/billing_repository.dart';

class BillingParams {
  final String serviceType;
  final String date;
  final String time;
  final double price;
  final double hours;
  final String placeType;
  final Address address;

  BillingParams({
    required this.serviceType,
    required this.date,
    required this.time,
    required this.price,
    required this.hours,
    required this.placeType,
    required this.address,
  });
}

class GenerateBill {
  final BillingRepository repository;

  GenerateBill(this.repository);

  Future<Map<String, dynamic>> execute(BillingParams params) {
    return repository.generateBill(params);
  }
}
