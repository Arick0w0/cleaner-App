// // lib/feature/shared/data/repositories/service_type_repository_impl.dart
// import 'package:mae_ban/feature/shared/data/datasources/service_type_remote_data_source.dart';
// import 'package:mae_ban/feature/shared/domain/entities/service_type.dart';
// import 'package:mae_ban/feature/shared/domain/repositories/service_type_repository.dart';

// class ServiceTypeRepositoryImpl implements ServiceTypeRepository {
//   final ServiceTypeRemoteDataSource remoteDataSource;

//   ServiceTypeRepositoryImpl({required this.remoteDataSource});

//   @override
//  Future<List<ServiceType>> getServiceTypes() async {
//     final response = await apiService.fetchServiceTypes();
//     return response.map((service) => service as ServiceType).toList();
//   }
// }
