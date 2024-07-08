import '../usecases/generate_bill.dart';

abstract class BillingRepository {
  Future<Map<String, dynamic>> generateBill(BillingParams params);
}
