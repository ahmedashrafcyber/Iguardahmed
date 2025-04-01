import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SavedOutputService {
  final String baseUrl;

  SavedOutputService({required this.baseUrl});

  // 🔹 Fetch saved outputs for the logged-in user
  Future<List<Map<String, dynamic>>> getUserSavedOutputs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // ✅ Debugging: Print stored values
    print("📌 Debug: Checking SharedPreferences values...");
    print("🔹 Stored Keys: ${prefs.getKeys()}");
    print("🔹 Stored Access Token: ${prefs.getString('accessToken') ?? 'NULL'}");
    print("🔹 Stored User ID: ${prefs.getInt('id') ?? 'NULL'}");

    String? token = prefs.getString('accessToken');
    int? userId = prefs.getInt('id');

    if (token == null || userId == null) {
      print("❌ ERROR: User not authenticated. Please log in.");
      throw Exception("User not authenticated. Please log in.");
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/saved-outputs/user/$userId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        print("✅ Success: Retrieved saved outputs.");
        return List<Map<String, dynamic>>.from(json.decode(response.body));
      } else {
        print("❌ ERROR: Failed to load saved outputs. Response: ${response.body}");
        throw Exception("Failed to load saved outputs.");
      }
    } catch (e) {
      print("⚠️ Exception: $e");
      throw Exception("Network error while fetching saved outputs.");
    }
  }

  // 🔹 Save a new output
  Future<bool> saveOutput(Map<String, dynamic> outputData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // ✅ Debugging: Print stored values
    print("📌 Debug: Checking SharedPreferences values...");
    print("🔹 Stored Keys: ${prefs.getKeys()}");
    print("🔹 Stored Access Token: ${prefs.getString('accessToken') ?? 'NULL'}");
    print("🔹 Stored User ID: ${prefs.getInt('id') ?? 'NULL'}");

    String? token = prefs.getString('accessToken');
    int? userId = prefs.getInt('id');

    if (token == null || userId == null) {
      print("❌ ERROR: User ID not found. Please log in.");
      throw Exception("User ID not found. Please log in.");
    }

    // ✅ Debugging: Print user ID before making API call
    print("🔹 Saving output for User ID: $userId");

    // Ensure the output data includes the correct `id`
    outputData['id'] = userId;

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/saved-outputs/save/$userId'), // 🔹 Fixed API path
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(outputData),
      );

      if (response.statusCode == 200) {
        print("✅ Output saved successfully.");
        return true;
      } else {
        print("❌ ERROR: Failed to save output. Response: ${response.body}");
        return false;
      }
    } catch (e) {
      print("⚠️ Exception: $e");
      return false;
    }
  }

  // 🔹 Delete a saved output
  Future<bool> deleteOutput(int outputId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // ✅ Debugging: Print stored values
    print("📌 Debug: Checking SharedPreferences values...");
    print("🔹 Stored Keys: ${prefs.getKeys()}");
    print("🔹 Stored Access Token: ${prefs.getString('accessToken') ?? 'NULL'}");
    print("🔹 Stored User ID: ${prefs.getInt('id') ?? 'NULL'}");

    String? token = prefs.getString('accessToken');

    if (token == null) {
      print("❌ ERROR: User not authenticated. Please log in.");
      throw Exception("User not authenticated. Please log in.");
    }

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/saved-outputs/delete/$outputId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        print("✅ Output deleted successfully.");
        return true;
      } else {
        print("❌ ERROR: Failed to delete output. Response: ${response.body}");
        return false;
      }
    } catch (e) {
      print("⚠️ Exception: $e");
      return false;
    }
  }
}
