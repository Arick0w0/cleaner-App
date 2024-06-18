// // lib/feature/shared/data/datasources/service_type_remote_data_source.dart
// import 'package:mae_ban/feature/shared/data/models/service_type_model.dart';

// abstract class ServiceTypeRemoteDataSource {
//   Future<List<ServiceTypeModel>> getServiceTypes();
// }

// class ServiceTypeRemoteDataSourceImpl implements ServiceTypeRemoteDataSource {
//   final ApiServiceGet apiService;

//   ServiceTypeRemoteDataSourceImpl({required this.apiService});

//   @override
//   Future<List<ServiceTypeModel>> getServiceTypes() async {
//     final response = await apiService.fetchServiceTypes();
//     return (response as List).map((json) => ServiceTypeModel.fromJson(json)).toList();
//   }
// }
