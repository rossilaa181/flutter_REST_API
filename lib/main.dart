import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_api/Pages/login_screen.dart';
import 'package:flutter_api/Pages/register_page.dart';
import 'package:flutter_api/Pages/login_page.dart';
import 'package:flutter_api/Pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => const LoginScreen(),
        // "/listpage": (context) => const ListPage(),
        "/homepage": (context) => const HomePage(),
      },
      initialRoute: "/",
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
    );
  }
}
