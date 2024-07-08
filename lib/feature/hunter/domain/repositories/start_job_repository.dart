abstract class StartJobRepository {
  Future<Map<String, dynamic>> fetchStartJobDetail(String startJobId);
  Future<void> submitStatusProcess(String startJobId, String newStatus);
  Future<void> submitStatusProcessOffer(String startJobId, String newStatus);
}
