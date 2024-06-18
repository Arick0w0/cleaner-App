import 'package:mae_ban/feature/offer/domain/entities/time.dart';
import 'package:mae_ban/feature/offer/domain/repositories/time_repository.dart';

class GetTimes {
  final TimeRepository repository;

  GetTimes(this.repository);

  Future<List<Time>> call() async {
    return await repository.getTimes();
  }
}
