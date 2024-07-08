import 'package:mae_ban/feature/offer/domain/repositories/choose_repository.dart';

class FetchCleaners {
  final ChooseRepository repository;

  FetchCleaners({required this.repository});

  Future<List<dynamic>> execute(String postJobId) async {
    return await repository.fetchCleaners(postJobId);
  }
}

class ChooseCleaner {
  final ChooseRepository repository;

  ChooseCleaner({required this.repository});

  Future<void> execute(String billCode, String hunterUsername) async {
    await repository.chooseCleaner(billCode, hunterUsername);
  }
}
