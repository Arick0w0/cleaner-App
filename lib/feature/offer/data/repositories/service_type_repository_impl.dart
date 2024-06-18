// lib/feature/joboffer/data/repositories/service_type_repository_impl.dart

import 'package:mae_ban/feature/offer/data/datasources/service_remote_data_source.dart';
import 'package:mae_ban/feature/offer/domain/entities/service_type.dart';
import 'package:mae_ban/feature/offer/domain/repositories/service_type_repository.dart';

class ServiceTypeRepositoryImpl implements ServiceTypeRepository {
  final ServiceTypeRemoteDataSource remoteDataSource;

  ServiceTypeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ServiceType>> getServiceTypes() async {
    final serviceTypeModels = await remoteDataSource.fetchServiceTypes();
    return serviceTypeModels
        .map((model) => ServiceType(
              id: model.id,
              imageType: model.imageType,
              serviceType: model.serviceType,
              serviceCodeName: model.serviceCodeName,
            ))
        .toList();
  }
}
