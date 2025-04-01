import 'package:flutter/material.dart';
import 'package:iguard/custom_app_bar.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile'),
      drawer: CustomAppBar.buildDrawer(context),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 40),

            // Profile Avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[800],
              child: const Icon(
                Icons.person,
                size: 50,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 20),

            // Profile Title
            Text(
              "Profile",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 40),

            // Profile Details Card
            Card(
              color: Colors.grey[900],
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildProfileDetail(Icons.person_outline, "Username", "Ahmed"),
                    _buildProfileDetail(Icons.email_outlined, "Email", "Ahmed@gmail.com"),
                    _buildProfileDetail(Icons.phone_iphone_outlined, "Phone", "0123456789"),
                    _buildProfileDetail(Icons.card_membership_outlined, "Subscription", "Free"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Delete Account Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle delete account action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA8D4E3),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Delete Account",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Professional profile detail row
  Widget _buildProfileDetail(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Color(0xFFA8D4E3),
            size: 28,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
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