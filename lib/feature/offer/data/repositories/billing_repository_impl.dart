import '../../domain/repositories/billing_repository.dart';
import '../../domain/usecases/generate_bill.dart';
import '../datasources/bill_remote_data_source.dart';
import 'package:mae_ban/feature/auth/data/local_storage/local_storage_service.dart';

class BillingRepositoryImpl implements BillingRepository {
  final BillRemoteDataSource remoteDataSource;
  final LocalStorageService localStorageService;

  BillingRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorageService,
  });

  @override
  Future<Map<String, dynamic>> generateBill(BillingParams params) async {
    try {
      final token = await localStorageService.getToken();
      if (token == null) throw Exception('Token not found');

      final response = await remoteDataSource.generateBill(
        token: token,
        serviceType: params.serviceType,
        date: params.date,
        time: params.time,
        price: params.price,
        hours: params.hours,
        placeType: params.placeType,
        address: params.address,
      );

      if (response['error'] == true) {
        throw Exception(response['msg']);
      }

      return response;
    } catch (e) {
      print('Error in BillingRepositoryImpl: $e');
      throw Exception('Failed to generate bill');
    }
  }
}
