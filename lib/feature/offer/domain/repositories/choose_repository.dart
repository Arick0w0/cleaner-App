abstract class ChooseRepository {
  Future<List<dynamic>> fetchCleaners(String postJobId);
  Future<void> chooseCleaner(String billCode, String hunterUsername);
}
