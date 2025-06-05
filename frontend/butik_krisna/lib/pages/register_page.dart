import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Add this import
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:butik_krisna/pages/welcome_page.dart';
import 'package:butik_krisna/pages/content/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool _registerObscurePassword = true;

  // Black button style
  final ButtonStyle blackButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 50),
  );

  Future<void> registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('http://192.168.149.69:3000/users'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      if (!mounted) return;

      if (response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);

        // Add type validation
        if (responseBody is! Map<String, dynamic>) {
          _showErrorSnackbar('Invalid user data format');
          return;
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(responseBody));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => WelcomePage(userName: responseBody['name'], userData: responseBody)),
        );
      } else {
        _handleRegistrationError(response.body); // Handle other status codes
      }
    } catch (e) {
      _showErrorSnackbar('Connection error. Please try again.');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _handleRegistrationError(String responseBody) {
    final message = jsonDecode(responseBody)['message'] ?? 'Registration failed';

    if (message.contains('already in use')) {
      _showErrorSnackbar('Email already registered!');
    } else if (message.contains('already taken')) {
      _showErrorSnackbar('Name already taken!');
    } else {
      _showErrorSnackbar(message);
    }
  }

  void _showErrorSnackbar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.poppins()),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person_add_alt_1_outlined, size: 72),
                const SizedBox(height: 16),
                Text('Create Account',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 32),

                // Name Field
                TextFormField(
                  controller: nameController,
                  style: GoogleFonts.poppins(),
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: GoogleFonts.poppins(),
                  ),
                  validator: (value) => value?.trim().isEmpty ?? true
                      ? 'Please enter your name'
                      : null,
                ),

                const SizedBox(height: 16),

                // Email Field
                TextFormField(
                  controller: emailController,
                  style: GoogleFonts.poppins(),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: GoogleFonts.poppins(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter email';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Invalid email format';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Password Field with counter
                TextFormField(
                  controller: passwordController,
                  obscureText: _registerObscurePassword,
                  style: GoogleFonts.poppins(),
                  maxLength: 8,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: GoogleFonts.poppins(),
                    counterText: '${passwordController.text.length}/8',
                    counterStyle: GoogleFonts.poppins(),
                    suffixIcon: IconButton(
                      icon: Icon(_registerObscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () => setState(
                              () => _registerObscurePassword = !_registerObscurePassword
                      ),
                    ),
                  ),
                  onChanged: (text) {
                    setState(() {}); // Rebuild widget to update counter text
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter password';
                    if (value.length > 8) return 'Max 8 characters';
                    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                      return 'Only letters and numbers';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // Register Button (Black with white text)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: blackButtonStyle,
                    onPressed: isLoading ? null : registerUser,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text('REGISTER',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        )),
                  ),
                ),

                const SizedBox(height: 16),

                // Login Navigation
                TextButton(
                  onPressed: isLoading ? null : () => Navigator.pop(context),
                  child: Text("Already have an account? Login",
                      style: GoogleFonts.poppins()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}