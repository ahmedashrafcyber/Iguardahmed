import 'package:flutter/material.dart';
import 'package:iguard/Screens/SearchPage.dart';
import 'package:iguard/Services/AuthService.dart';
import 'LoginScreen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "/register";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService(baseUrl: 'http://10.0.2.2:8080');
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  void register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    bool success = await authService.register(
      usernameController.text.trim(),
      emailController.text.trim(),
      phoneController.text.trim(),
      passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration successful!"), backgroundColor: Colors.green),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration failed! Please try again."), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: const Text(
                  'Create New Account',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFA9D6E5),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF1F2A37), // Dark navy/charcoal
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color(0xFFA9D6E5), // Bold border color
                    width: 2.5, // Bold border thickness
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildTextField(
                      controller: usernameController,
                      label: "Username",
                      hint: "User Name",
                      validator: (value) => value!.isEmpty ? "Enter a username" : null,
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      controller: emailController,
                      label: "Email",
                      hint: "Email",
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value!.isEmpty || !value.contains('@') ? "Enter a valid email" : null,
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      controller: phoneController,
                      label: "Phone",
                      hint: "Mobile no.",
                      keyboardType: TextInputType.phone,
                      validator: (value) => value!.isEmpty ? "Enter a phone number" : null,
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      controller: passwordController,
                      label: "Password",
                      hint: "Password",
                      obscureText: true,
                      validator: (value) => value!.length < 6 ? "Password must be at least 6 characters" : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: register,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFFA9D6E5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF0E2730),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen())),
                  child: const Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0xFFA9D6E5),
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
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
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String? Function(String?)? validator,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 21,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Color(0xFFA9D6E5), width: 2.0),
            ),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          validator: validator,
        ),
      ],
    );
  }
}