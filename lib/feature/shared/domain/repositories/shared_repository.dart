import 'package:mae_ban/feature/shared/domain/entities/service_type.dart';

abstract class SharedRepository {
  Future<List<ServiceType>> getServiceTypes();
}
