import 'package:flutter/material.dart';
import '../Services/SavedOutputService.dart';
import 'package:iguard/custom_app_bar.dart';


class SavedOutputsScreen extends StatefulWidget {
  static const String routeName = '/SavedOutputsScreen';

  const SavedOutputsScreen({Key? key}) : super(key: key);

  @override
  _SavedOutputsScreenState createState() => _SavedOutputsScreenState();
}

class _SavedOutputsScreenState extends State<SavedOutputsScreen> {
  final SavedOutputService _savedOutputService =
  SavedOutputService(baseUrl: 'http://10.0.2.2:8080');

  List<Map<String, dynamic>> _savedOutputs = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchSavedOutputs();
  }

  Future<void> _fetchSavedOutputs() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Map<String, dynamic>> outputs =
      await _savedOutputService.getUserSavedOutputs();
      setState(() {
        _savedOutputs = outputs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching saved outputs: $e")),
      );
    }
  }

  Future<void> _deleteOutput(int id) async {
    bool success = await _savedOutputService.deleteOutput(id);
    if (success) {
      _fetchSavedOutputs(); // Refresh list
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to delete output")),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Saved Outputs'),
      drawer: CustomAppBar.buildDrawer(context),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _savedOutputs.isEmpty
          ? const Center(child: Text("No saved outputs"))
          : ListView.builder(
        itemCount: _savedOutputs.length,
        itemBuilder: (context, index) {
          var output = _savedOutputs[index];
          return ListTile(
            title: Text(output['title'] ?? 'No Title'),
            subtitle: Text(output['description'] ?? 'No Description'),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteOutput(output['id']),
            ),
          );
        },
      ),
    );
  }
}
