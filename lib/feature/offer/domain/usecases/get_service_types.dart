import 'package:mae_ban/feature/offer/domain/entities/service_type.dart';
import 'package:mae_ban/feature/offer/domain/repositories/service_type_repository.dart';

class GetServiceTypes {
  final ServiceTypeRepository repository;

  GetServiceTypes({required this.repository});

  Future<List<ServiceType>> call() async {
    return await repository.getServiceTypes();
  }
}
