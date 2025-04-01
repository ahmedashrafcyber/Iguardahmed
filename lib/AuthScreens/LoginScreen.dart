import 'package:flutter/material.dart';
import 'package:iguard/Screens/SearchPage.dart';
import 'package:iguard/Services/AuthService.dart';
import 'RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService(baseUrl: 'http://10.0.2.2:8080');

  void login() async {
    bool success = await authService.login(emailController.text, passwordController.text);
    if (success) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login failed!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Pure black background
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            const Text(
              'Welcome to the ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const Text(
              'IGuard',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFFA9D6E5),
              ),
            ),
            const Text(
              'Dark Web Monitoring',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFA9D6E5),
              ),
            ),
            const SizedBox(height: 40),

            // Email Label
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Email Field
            _buildTextField(emailController, "Email", "Enter your email", false),
            const SizedBox(height: 20),

            // Password Label
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Password Field
            _buildTextField(passwordController, "Password", "Enter your password", true),
            const SizedBox(height: 10),

            // Forgot Password (Aligned right + italic, bold underlining)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFFA9D6E5),
                    decoration: TextDecoration.underline,
                    decorationThickness: 2, // Bold underline
                    decorationColor: Color(0xFFA9D6E5),
                  ),
                ),
              ),
            ),

            // Dark blue separator line
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 40), // Equal spacing above & below
              child: Center(
                child: Container(
                  width: 300, // Shorter width
                  height: 1.5, // Line thickness
                  color: const Color(0xFF01497C), // Dark blue
                ),
              ),
            ),

            // Login Button (Reduced width & height)
            _buildButton("Login", login, filled: true),
            const SizedBox(height: 20),

            // Continue with Google Button (Transparent fill, blue text & border, NO logo)
            const SizedBox(height: 20),

            // "Don't have an account?" with "Sign up" (Bold underlining)
            Center(
              child: TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen())),
                child: const Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white, // White text
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Color(0xFFA9D6E5), // Blue text
                          decoration: TextDecoration.underline,
                          decorationThickness: 2, // Bold underline
                          decorationColor: Color(0xFFA9D6E5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Updated text field widget to match SearchPage style
  Widget _buildTextField(TextEditingController controller, String label, String hint, bool obscureText) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFFA9D6E5), width: 2.0),
        ),
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 15),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed, {bool filled = true}) {
    return Center(
      child: SizedBox(
        width: 260, // Reduced width
        height: 50, // Reduced height
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            backgroundColor: filled ? const Color(0xFFA9D6E5) : Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: filled ? BorderSide.none : const BorderSide(color: Color(0xFFA9D6E5), width: 2),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: filled ? const Color(0xFF0E2730) : const Color(0xFFA9D6E5),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }}