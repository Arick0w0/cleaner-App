class AuthResponseModel {
  final String accessToken;
  final String refreshToken;
  final String role;

  AuthResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.role,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return AuthResponseModel(
      accessToken: data['accessToken'] ?? '',
      refreshToken: data['refreshToken'] ?? '',
      role: data['user']?['role'] ??
          '', // Updated to parse role from nested structure
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'role': role,
    };
  }
}
