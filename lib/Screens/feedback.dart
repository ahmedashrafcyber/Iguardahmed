import 'package:flutter/material.dart';
import 'package:iguard/custom_app_bar.dart';

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Feedback'),
      drawer: CustomAppBar.buildDrawer(context),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Animated Header Image
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              height: 200,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  const Color(0xFFA8D4E3),
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  'lib/images/feedback.gif',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Feedback Form Card
            Card(
              color: Colors.grey[900],
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildTextField(Icons.person_outline, "Your Name"),
                    const SizedBox(height: 16),
                    _buildTextField(Icons.email_outlined, "Your Email"),
                    const SizedBox(height: 16),
                    _buildTextField(Icons.feedback_outlined, "Your Feedback", maxLines: 4),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA8D4E3),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Submit Feedback",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFFA8D4E3)),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
      ),
    );
  }
}