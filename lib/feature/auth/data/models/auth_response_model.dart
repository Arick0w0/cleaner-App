class AuthResponseModel {
  final String accessToken;
  final String refreshToken;
  final String role;
  final String status; // Add status field
  // final String username; // Add status field

  AuthResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.role,
    required this.status, // Add status to the constructor
    // required this.username, // Add status to the constructor
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return AuthResponseModel(
      accessToken: data['accessToken'] ?? '',
      refreshToken: data['refreshToken'] ?? '',
      role: data['user']?['role'] ?? '',
      // username: data['user']?['username'] ?? '',
      status:
          data['user']?['status'] ?? '', // Parse status from nested structure
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'role': role,
      'status': status, // Add status to JSON
    };
  }
}
