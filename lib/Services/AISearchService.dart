import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Aisearchservice {
  final String baseUrl;

  Aisearchservice({required this.baseUrl});

  Future<List<Map<String, dynamic>>> performDeepSearch(String query) async {
    final url = Uri.parse('$baseUrl/api/ai/scrape');

    // 🔹 Retrieve stored JWT token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    if (token == null) {
      throw Exception('Unauthorized: No token found. Please log in.');
    }

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // 🔒 Attach token for security
        },
        body: jsonEncode({'query': query}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Debug print the response data
        print("API Response: $data");

        // Ensure the response is a list of maps
        return List<Map<String, dynamic>>.from(data);
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
