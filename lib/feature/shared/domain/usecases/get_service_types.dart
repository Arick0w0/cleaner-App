import 'package:mae_ban/feature/shared/domain/entities/service_type.dart';
import 'package:mae_ban/feature/shared/domain/repositories/shared_repository.dart';

class GetServiceTypes {
  final SharedRepository repository;

  GetServiceTypes(this.repository);

  Future<List<ServiceType>> call() async {
    return await repository.getServiceTypes();
  }
}
