import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mae_ban/feature/auth/data/models/user_model.dart';

class LocalStorageService {
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
    // print('Token saved: $token'); // Debug log
  }

  Future<void> saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);
    // print('Role saved: $role'); // Debug log
  }

  Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    // print('Username saved: $username'); // Debug log
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    // print('Token retrieved: $token'); // Debug log
    return token;
  }

  Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('role');
    // print('Role retrieved: $role'); // Debug log
    return role;
  }

  // Future<String?> getUsername() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final username = prefs.getString('username');
  //   print('Username retrieved: $username'); // Debug log
  //   return username;
  // }

  Future<User?> getUserFromToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      User user = User.fromJson(decodedToken);
      // print('User retrieved from token: ${user.username}'); // Debug log
      return user;
    }
    return null;
  }
}
