import 'package:mae_ban/feature/offer/domain/entities/service_type.dart';

abstract class ServiceTypeRepository {
  Future<List<ServiceType>> getServiceTypes();
}
