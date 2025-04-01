import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Normalsearchservice {
  final String baseUrl;

  Normalsearchservice({required this.baseUrl});

  // 🔹 Fetch JWT Token from local storage
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    print('🔹 Retrieved JWT Token: $token'); // Debugging
    return token;
  }


  // 🔹 Search Ahmia (Existing method)
  Future<List<dynamic>> searchAhmia(String query) async {
    final url = Uri.parse('$baseUrl/api/ahmia/scrape');

    try {
      final token = await getToken();
      if (token == null) throw Exception("User not authenticated");

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Include JWT token
      };

      print('🔹 Request Headers: $headers'); // Debugging

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({'query': query}),
      );

      print('🔹 API Response Status: ${response.statusCode}');
      print('🔹 API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as List<dynamic>;
      } else {
        throw Exception('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('🔴 Search Error: $e');
      throw Exception('An error occurred: $e');
    }
  }
}
