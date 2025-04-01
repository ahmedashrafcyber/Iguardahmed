import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl;

  AuthService({required this.baseUrl});

  // 🔹 Register user and store JWT token
    Future<bool> register(String username, String email, String phone, String password) async {
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'phone': phone,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Registration Error: ${response.body}'); // Debugging
        return false;
      }
    }


  // 🔹 Login and store JWT token
  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    print("🔹 Server Response: ${response.body}"); // Debugging

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final token = data['accessToken'];
      final userId = data['id']; // ✅ Extract user ID

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', token);
      await prefs.setInt('id', userId); // ✅ Store user ID

      print("✅ User logged in: ID = $userId, Token = $token"); // Debugging
      return true;
    } else {
      print("❌ Login failed: ${response.body}"); // Debugging
      return false;
    }
  }

}
