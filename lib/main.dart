import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_api/Pages/login_screen.dart';
import 'package:flutter_api/Pages/register_screen.dart';
import 'package:flutter_api/Pages/auth_screen.dart';
import 'package:flutter_api/Pages/home_page.dart';
import 'package:flutter_api/Pages/category_screen.dart';
import 'package:flutter_api/Splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => const SplashScreen(),
        // "/listpage": (context) => const ListPage(),
        "/auth": (context) => const AuthScreen(),
        "/home": (context) => const HomePage(),
        "/register": (context) => const RegisterScreen(),
        "/login": (context) => const LoginScreen(),
        "/category": (context) => const CategoryScreen(),
      },
      initialRoute: "/",
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
    );
  }
}
