import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_api/Pages/login_screen.dart';
import 'package:flutter_api/Pages/register_screen.dart';
import 'package:flutter_api/Pages/auth_screen.dart';
import 'package:flutter_api/Pages/home_page.dart';
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
        "/authpage": (context) => const AuthScreen(),
        "/homepage": (context) => const HomePage(),
        "/registerpage": (context) => const RegisterScreen(),
        "/loginpage": (context) => const LoginScreen(),
      },
      initialRoute: "/",
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
    );
  }
}
