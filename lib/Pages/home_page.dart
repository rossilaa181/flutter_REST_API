// ignore_for_file: unused_import, unused_field, use_build_context_synchronously

import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

import 'package:flutter_api/Services/auth_services.dart';
import 'package:flutter_api/Pages/login_screen.dart';
import 'package:flutter_api/Pages/category_screen.dart';
import 'package:flutter_api/partials/color_pickers.dart';
import 'package:flutter_api/partials/font_pickers.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? token;
  List<String> user = [];

  Future<String> getToken() async {
    final sharedPref = await SharedPreferences.getInstance();

    String token = sharedPref.getString('token')!;

    return token;
  }

  Future<List<String>> getUser() async {
    final sharedPref = await SharedPreferences.getInstance();

    List<String> user = sharedPref.getStringList('user')!;

    return user;
  }

  @override
  void initState() {
    super.initState();

    getToken().then((value) {
      setState(() {
        token = value;
      });
    });

    getUser().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  bool _isHome = true;

  logoutPressed() async {
    http.Response response = await AuthServices.logout();

    if (response.statusCode == 204) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen(),
        ),
        (route) => false,
      );
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const HomePage(),
          ));
    }
  }

  home() async {
    if (_isHome == true) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const HomePage(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(0),
                  height: 280,
                  width: double.infinity,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 200,
                  decoration: const BoxDecoration(
                      color: ColorPicker.primary,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(80))),
                ),
                Positioned(
                  left: 25,
                  top: 83,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Hai ',
                            style: TextStyle(
                                fontFamily: FontPicker.bold,
                                fontSize: 20,
                                color: ColorPicker.white),
                          ),
                          Text(
                            user[0],
                            style: const TextStyle(
                                fontFamily: FontPicker.bold,
                                fontSize: 20,
                                color: ColorPicker.white),
                          ),
                        ],
                      ),
                      Align(
                        child: Text(
                          user[1],
                          style: const TextStyle(
                              fontFamily: FontPicker.medium,
                              fontSize: 12,
                              color: ColorPicker.white),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Align(
                        child: Text(
                          'Have a nice day 😊',
                          style: TextStyle(
                              fontFamily: FontPicker.medium,
                              fontSize: 14,
                              color: ColorPicker.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 10,
                  top: -30,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: ColorPicker.primaryShape,
                        borderRadius: BorderRadius.circular(80)),
                  ),
                ),
                Positioned(
                  right: 25,
                  top: 80,
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorPicker.white),
                    child: TextButton(
                      onPressed: home,
                      child: const Text(
                        'Home',
                        style: TextStyle(
                            fontFamily: FontPicker.semibold,
                            color: ColorPicker.primary),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              margin: EdgeInsets.all(15.0),
              width: 300,
              height: 40,
              // convert button
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CategoryScreen()),
                  );
                },
                child: Text('Category List'),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15.0),
              width: 300,
              height: 40,
              // convert button
              child: ElevatedButton(
                onPressed: logoutPressed,
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // Background color
                ),
                child: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
