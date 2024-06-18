import 'package:mae_ban/feature/offer/domain/entities/time.dart';

abstract class TimeRepository {
  Future<List<Time>> getTimes();
}
