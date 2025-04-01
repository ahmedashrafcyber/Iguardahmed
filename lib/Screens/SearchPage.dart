import 'package:flutter/material.dart';
import 'package:iguard/Services/NormalSearchService.dart';
import 'package:iguard/Screens/DeepSearchAIPage.dart';
import 'package:iguard/Screens/ScanYours.dart';
import 'package:iguard/custom_app_bar.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = '/SearchPage';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final Normalsearchservice apiService = Normalsearchservice(baseUrl: 'http://10.0.2.2:8080');
  String _results = '';
  bool _isLoading = false;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _performSearch() async {
    final query = _controller.text.trim();
    if (query.isEmpty) {
      setState(() {
        _results = 'Please enter a search query.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _results = '';
    });

    try {
      final results = await apiService.searchAhmia(query);
      setState(() {
        _isLoading = false;
        if (results.isNotEmpty) {
          _results = results.map((r) {
            String title = r['title'] ?? 'No title';
            String link = r['link'] ?? 'No link';
            return '$title|$link';
          }).join('||');
          _fadeController.forward();
        } else {
          _results = 'No results found for "$query".';
          _fadeController.forward();
        }
      });
    } catch (e) {
      setState(() {
        _results = 'An error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(title: 'Search'),
      drawer: CustomAppBar.buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 25),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Search on the dark web',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none, // Added to match original style
                ),
                filled: true,
                fillColor: const Color(0xFF1F1F1F), // Your exact color
                contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20), // Keeping original padding
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Color(0xFFA8D4E3), width: 2.0),
                ),
                labelStyle: const TextStyle(color: Colors.grey, fontSize: 15), // Your exact style
                floatingLabelBehavior: FloatingLabelBehavior.never, // Added to keep hint stationary
              ),
              style: const TextStyle(color: Colors.white), // Your exact text color
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _performSearch,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA8D4E3),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                        : const Text(
                      'Search',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DeepSearchAIPage()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        width: 2.0,
                        color: const Color(0xFFA8D4E3), // Border color same as button color
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text(
                      'Go Deeper by AI',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFA8D4E3), // Text color same as border
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: AnimatedBuilder(
                animation: _fadeController,
                builder: (_, child) => Opacity(
                  opacity: _fadeAnimation.value,
                  child: _results.isEmpty
                      ? const Center(
                    child: Text(
                      'Enter a keyword to search',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                      : SingleChildScrollView(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: _results.split('||').map((result) {
                        List<String> parts = result.split('|');
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: const Color(0xFF1F1F1F),
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(
                              "Info: ${parts[0]}", // Title with label
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              parts.length > 1 ? "Onion link: ${parts[1]}" : 'Description: ',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ScanYours()),
          );
        },
        backgroundColor: Color(0xFFA8D4E3),
        icon: Icon(Icons.qr_code_scanner, color: Colors.black),
        label: Text(
          "Scan Yours",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
