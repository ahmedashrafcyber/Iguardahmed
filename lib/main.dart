import 'package:flutter/material.dart';
import 'package:iguard/AuthScreens/LoginScreen.dart';
import 'package:iguard/AuthScreens/RegisterScreen.dart';
import 'package:iguard/Screens/DeepSearchAIPage.dart';
import 'package:iguard/Screens/Profile.dart';
import 'package:iguard/Screens/SavedOutputsScreen.dart';
import 'package:iguard/Screens/ScanYours.dart';
import 'package:iguard/Screens/SearchPage.dart';
import 'package:iguard/Screens/Sub_plan.dart';
import 'package:iguard/Screens/contact_us.dart';
import 'package:iguard/Screens/feedback.dart';
import 'package:iguard/SplashScreen.dart';

// Import new pages



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/SearchPage',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/SearchPage': (context) => SearchPage(),
        '/LoginScreen': (context) => LoginScreen(),
        '/RegisterScreen': (context) => RegisterScreen(),
        '/DeepSearchAIPage': (context) => DeepSearchAIPage(),
        '/SavedOutputsScreen': (context) => SavedOutputsScreen(),
        '/ScanYours': (context) => ScanYours(),
        '/FeedbackPage': (context) => FeedbackPage(),
        '/ContactUsPage': (context) => ContactUsPage(),
        '/SubscriptionPlanPage': (context) => SubscriptionPlanPage(),
        '/Profile': (context) => ProfilePage(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('Route not found: ${settings.name}'),
            ),
          ),
        );
      },
    );
  }
}
