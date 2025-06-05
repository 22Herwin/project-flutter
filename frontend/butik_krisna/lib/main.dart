import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:butik_krisna/models/cart_item.dart';
import 'pages/login_page.dart';
import 'package:butik_krisna/pages/content/home_page.dart';
import 'package:butik_krisna/pages/content/cart_page.dart';
import 'pages/profile_page.dart';
import 'package:butik_krisna/models/product.dart';
import 'pages/content/product_detail_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final String? userJson = prefs.getString('user');
  runApp(MyApp(userJson: userJson));
}

class MyApp extends StatelessWidget {
  final String? userJson;
  const MyApp({super.key, required this.userJson});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (_) => userJson != null
                  ? WelcomeBridgePage(user: jsonDecode(userJson!))
                  : const LoginPage(),
            );
          case '/cart':
            final args = settings.arguments as List<CartItem>;
            return MaterialPageRoute(
              builder: (_) => CartPage(cartItems: args),
            );
          case '/profile':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => ProfilePage(user: args),
            );
          case '/productDetail':
            final product = settings.arguments as Product;
            return MaterialPageRoute(
              builder: (_) => ProductDetailPage(product: product),
            );
          default:
            return MaterialPageRoute(
              builder: (_) => const Scaffold(
                body: Center(child: Text('Page not found')),
              ),
            );
        }
      },
    );
  }
}

class WelcomeBridgePage extends StatelessWidget {
  final Map<String, dynamic> user;
  const WelcomeBridgePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomePage(user: user),
        ),
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 72, color: Colors.green),
            const SizedBox(height: 24),
            Text('Welcome, ${user['name']}!',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}