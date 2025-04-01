import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iguard/Services/AISearchService.dart';
import 'package:iguard/Services/SavedOutputService.dart';
import 'package:iguard/custom_app_bar.dart';


class DeepSearchAIPage extends StatefulWidget {
  static const String routeName = '/DeepSearchAIPage';

  @override
  _DeepSearchAIPageState createState() => _DeepSearchAIPageState();
}

class _DeepSearchAIPageState extends State<DeepSearchAIPage> {
  final TextEditingController _controller = TextEditingController();
  final Aisearchservice aiService = Aisearchservice(baseUrl: 'http://10.0.2.2:8080');
  final SavedOutputService savedOutputService = SavedOutputService(baseUrl: 'http://10.0.2.2:8080');

  List<Map<String, dynamic>> _results = [];
  bool _isLoading = false;
  String? id; // Retrieved from authentication

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('id');
    });
  }

  Future<void> _performDeepSearch() async {
    final query = _controller.text.trim();
    if (query.isEmpty) {
      setState(() {
        _results = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _results = [];
    });

    try {
      final response = await aiService.performDeepSearch(query);
      setState(() {
        _isLoading = false;
        _results = response.isNotEmpty ? response : [];
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _results = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  Future<void> _saveOutput(Map<String, dynamic> result) async {
    try {
      bool success = await savedOutputService.saveOutput(result);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(success ? "Saved successfully!" : "Failed to save output")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }


  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Onion link copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(title: 'AI Search'),
      drawer: CustomAppBar.buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Search on the dark web',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: const Color(0xFF1F1F1F),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Color(0xFF00FF7F), width: 2.0),
                ),
                labelStyle: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _performDeepSearch,
              child: Container(
                width: 200,
                height: 55,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF121212), Color(0xFF00FF7F)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00CED1).withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                      : const Text(
                    'Perform Deep Search',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                      shadows: [
                        Shadow(
                          blurRadius: 6.0,
                          color: Color(0xFF00FF7F),
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: SingleChildScrollView(
                child: _results.isEmpty
                    ? const Center(
                  child: Column(
                    children: [
                      Text(
                        'Deep Search by AI uses advanced algorithms',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      Text(
                        'To explore the hidden layers of the web',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      )
                    ],
                  ),
                )
                    : Column(
                  children: _results.map((result) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 8.0,
                        color: const Color(0xFF1F1F1F),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Category: ${result['category'] ?? 'No Category'}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.bookmark, color: Colors.white),
                                    onPressed: () => _saveOutput(result),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Info: ${result['title'] ?? 'No Title'}',
                                style: const TextStyle(fontSize: 18, color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Description: ${result['description'] ?? 'No Description'}',
                                style: const TextStyle(fontSize: 16, color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              Text('Onion Link:', style: const TextStyle(color: Colors.grey)),
                              Text(
                                result['link'] ?? 'No Link',
                                style: const TextStyle(fontSize: 16, color: Colors.grey, decoration: TextDecoration.underline),
                              ),
                              const SizedBox(height: 8),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                                ),
                                onPressed: () => _copyToClipboard(result['link'] ?? ''),
                                child: const Text(
                                  'Copy Onion Link',
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
