import 'package:flutter/material.dart';
import 'package:iguard/Screens/DeepSearchAIPage.dart';
import 'package:iguard/Screens/SavedOutputsScreen.dart';
import 'package:iguard/Screens/ScanYours.dart';
import 'package:iguard/Screens/SearchPage.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);

  static Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5), // Set 50% transparency with a black color
          // You can adjust the opacity level (0.1 - 1.0) for more or less transparency
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF013A62),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center, // Align items vertically
                children: [
                  Image.asset(
                    'lib/images/logo.png', // Path to your logo
                    width: 60,
                    height: 60,
                    color: Colors.white, // Ensures the logo is white
                  ), // White logo (replace with your asset if needed)
                  const SizedBox(width: 15), // Spacing between logo and text
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Center text vertically
                    crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                    children: [
                      Text(
                        'IGuard',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                       // Reduced spacing
                      Text(
                        'Dark Web Protection',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.search,
              title: 'Search',
              routeName: SearchPage.routeName,
            ),
            _buildDrawerItem(
              context,
              icon: Icons.auto_awesome,
              title: 'Deep Search AI',
              routeName: DeepSearchAIPage.routeName,
            ),
            _buildDrawerItem(
              context,
              icon: Icons.bookmark,
              title: 'Saved Outputs',
              routeName: SavedOutputsScreen.routeName,
            ),
            _buildDrawerItem(
              context,
              icon: Icons.security,
              title: 'Scan Yours',
              routeName: ScanYours.routeName,
            ),
            _buildDrawerItem(
              context,
              icon: Icons.person,
              title: 'Profile',
              routeName: '/Profile',
            ),
            // New pages added
            _buildDrawerItem(
              context,
              icon: Icons.feedback,
              title: 'Feedback',
              routeName: '/FeedbackPage',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.contact_mail,
              title: 'Contact Us',
              routeName: '/ContactUsPage',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.subscriptions,
              title: 'Subscription Plan',
              routeName: '/SubscriptionPlanPage',
            ),
          ],
        ),
      ),
    );
  }

  static ListTile _buildDrawerItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String routeName,
      }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: TextStyle(
          color: Color(0xFFA9D6E5), // Set the text color to the desired value
          fontWeight: FontWeight.bold, // Make the text bold
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, routeName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF013A62),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          border: Border(
            bottom: BorderSide(
              color: Colors.blue[900]!,
              width: 4,
            ),
          ),
        ),
        child: AppBar(
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
      ),
    );
  }
}
