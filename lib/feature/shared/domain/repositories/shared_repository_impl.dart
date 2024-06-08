import 'package:mae_ban/feature/shared/data/services/api_service.dart';
import 'package:mae_ban/feature/shared/domain/entities/service_type.dart';
import 'package:mae_ban/feature/shared/domain/repositories/shared_repository.dart';

class SharedRepositoryImpl implements SharedRepository {
  final ApiServiceGet apiService;

  SharedRepositoryImpl(this.apiService);

  @override
  Future<List<ServiceType>> getServiceTypes() async {
    final response = await apiService.fetchServiceTypes();
    return response
        .map((serviceTypeModel) => serviceTypeModel as ServiceType)
        .toList();
  }
}
