import 'package:flutter/material.dart';
import 'package:iguard/custom_app_bar.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Contact Us'),
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
                  'lib/images/contact_us.gif',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Contact Information Card
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
                    _buildContactRow(Icons.email_outlined, "Email", "support@iguard.com"),
                    const Divider(color: Colors.white24, height: 20),
                    _buildContactRow(Icons.phone_outlined, "Phone", "+1 234 567 890"),
                    const Divider(color: Colors.white24, height: 20),
                    _buildContactRow(Icons.language_outlined, "Website", "www.iguard.com"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Contact Support Button
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
                  "Contact Support",
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

  Widget _buildContactRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFFA8D4E3),
            size: 28,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}