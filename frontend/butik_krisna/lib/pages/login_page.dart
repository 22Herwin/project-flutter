import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Add this import
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'register_page.dart';
import 'package:butik_krisna/pages/content/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? errorMessage;
  bool isLoading = false;
  bool _obscurePassword = true;
  bool rememberMe = false;

  // Black button style
  final ButtonStyle blackButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 50),
  );

  Future<void> loginUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:3000/users/login'), // Changed for Android emulator
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final user = responseBody['user'] ?? responseBody;

        if (user is! Map<String, dynamic>) {
          setState(() => errorMessage = 'Invalid user data format');
          return;
        }
        if (rememberMe) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('user', jsonEncode(user));
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomePage(user: user),
          ),
        );
      } else {
        setState(() {
          errorMessage = jsonDecode(response.body)['message'] ?? 'Login failed';
        });
      }
    } catch (e) {
      setState(() => errorMessage = 'Connection error. Please try again.');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
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
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_outline, size: 72),
                const SizedBox(height: 24),
                Text('Welcome Back',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),

                // Error Message
                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      errorMessage!,
                      style: GoogleFonts.poppins(
                        color: Colors.red,
                      ),
                    ),
                  ),

                const SizedBox(height: 32),

                // Email Field
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: GoogleFonts.poppins(),
                  ),
                  style: GoogleFonts.poppins(),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter email';
                    if (!value.contains('@')) return 'Invalid email format';
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Password Field with counter
                TextFormField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  maxLength: 8,
                  style: GoogleFonts.poppins(),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: GoogleFonts.poppins(),
                    counterText: '${passwordController.text.length}/8', // This will update dynamically
                    counterStyle: GoogleFonts.poppins(),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  onChanged: (text) {
                    setState(() {}); // Rebuild widget to update counter text
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter password';
                    if (value.length > 8) return 'Max 8 characters';
                    return null;
                  },
                ),

                // Remember Me Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (v) => setState(() => rememberMe = v!),
                    ),
                    Text('Remember Me', style: GoogleFonts.poppins()),
                  ],
                ),

                const SizedBox(height: 24),

                // Login Button (Black with white text)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: blackButtonStyle,
                    onPressed: isLoading ? null : loginUser,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text('LOGIN',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.white,
                        )),
                  ),
                ),

                const SizedBox(height: 16),

                // Register Button
                TextButton(
                  onPressed: isLoading ? null : () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()),
                  ),
                  child: Text("Don't have an account? Register",
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