import 'package:flutter/material.dart';
import 'package:iguard/custom_app_bar.dart';

class SubscriptionPlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Subscription Plan'),
      drawer: CustomAppBar.buildDrawer(context),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Header
            const Text(
              "Choose Your Plan",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              "Select the plan that fits your security needs",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Plan Cards
            _buildPlanCard(
                "Free Plan",
                "\$0",
                "/month",
                [
                  "Basic protection",
                  "Limited features",
                  "Standard support"
                ],
                false
            ),
            const SizedBox(height: 20),

            _buildPlanCard(
                "Premium Plan",
                "\$9.99",
                "/month",
                [
                  "Advanced protection",
                  "Priority support",
                  "Additional features"
                ],
                true
            ),
            const SizedBox(height: 20),

            _buildPlanCard(
                "Pro Plan",
                "\$19.99",
                "/month",
                [
                  "Complete security suite",
                  "24/7 premium support",
                  "All features included"
                ],
                false
            ),

            const SizedBox(height: 40),

            // Subscribe Button
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
                  "Subscribe Now",
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

  Widget _buildPlanCard(String title, String price, String period, List<String> features, bool isFeatured) {
    return Card(
      color: Colors.grey[900],
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isFeatured ? const Color(0xFFA8D4E3) : Colors.grey[800]!,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: price,
                    style: const TextStyle(
                      color: Color(0xFFA8D4E3),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: period,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ...features.map((feature) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: const Color(0xFFA8D4E3),
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      feature,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}