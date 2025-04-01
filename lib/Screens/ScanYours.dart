import 'package:flutter/material.dart';
import 'package:iguard/Services/LeakService.dart';
import 'package:iguard/custom_app_bar.dart';

class ScanYours extends StatefulWidget {
  static const String routeName = '/ScanYours';

  const ScanYours({super.key});

  @override
  _ScanYoursState createState() => _ScanYoursState();
}

class _ScanYoursState extends State<ScanYours> with SingleTickerProviderStateMixin {
  final LeakService _leakService = LeakService(baseUrl: 'http://10.0.2.2:8080');
  Future<Map<String, dynamic>?>? _leakResults;
  bool _isScanning = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startScan() {
    setState(() {
      _isScanning = true;
      _leakResults = _leakService.checkLeaks();
    });
  }

  Widget _buildScanButton() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Text(
            "Dark Web Scan",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Start searching for leaks on the dark web",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: _isScanning ? null : _startScan,
            child: ScaleTransition(
              scale: Tween<double>(begin: 1.0, end: 1.1).animate(_animationController),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFA8D4E3),
                    width: 2,
                  ),
                ),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    const Color(0xFFA8D4E3),
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    'lib/images/logo.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            "Scan with your registered information",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStatusCard({required IconData icon, required Color color, required String title, required String message}) {
    return Center(
      child: Card(
        color: Colors.grey[900],
        elevation: 4,
        margin: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 60),
              const SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(title: 'Scan Yours'),
      drawer: CustomAppBar.buildDrawer(context),
      body: _isScanning
          ? FutureBuilder<Map<String, dynamic>?>(
        future: _leakResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    color: Color(0xFFA8D4E3),
                    strokeWidth: 4,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Scanning dark web for leaks...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return _buildStatusCard(
              icon: Icons.error_outline,
              color: Colors.orange,
              title: "Error Occurred!",
              message: "Something went wrong. Please try again later.",
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _buildStatusCard(
              icon: Icons.verified_outlined,
              color: Colors.green,
              title: "You are safe!",
              message: "Great job! Keep using strong passwords and enable 2FA.",
            );
          } else {
            return _buildStatusCard(
              icon: Icons.warning_amber_outlined,
              color: Colors.red,
              title: "Potential Leak Detected!",
              message: "Your data has been found on the dark web. Change all passwords immediately!",
            );
          }
        },
      )
          : _buildScanButton(),
    );
  }
}