import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LeakService {
  final String baseUrl;

  LeakService({required this.baseUrl});

  Future<Map<String, dynamic>?> checkLeaks() async {
    final url = Uri.parse('$baseUrl/api/leaks/check');

    // 🔹 Retrieve stored JWT token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    if (token == null) {
      throw Exception('Unauthorized: No token found. Please log in.');
    }

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // 🔒 Attach token for security
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Debug print the response data
        print("API Response: $data");

        return data;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid token or session expired.');
      } else {
        throw Exception('Error ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
