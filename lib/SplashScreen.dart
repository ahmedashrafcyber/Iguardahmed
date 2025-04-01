import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _logoAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );

    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();

    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/LoginScreen');
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FadeTransition(
          opacity: _logoAnimation,
          child: ScaleTransition(
            scale: _logoAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/images/logo.png',
                  width: 120,
                ),
                SizedBox(height: 20),
                Text(
                  'IGuard',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlueAccent,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Unmask',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.lightBlueAccent,
                  ),
                ),
                Text(
                  'The Hidden Web',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
