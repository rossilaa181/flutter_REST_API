// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

import 'package:flutter_api/Services/auth_services.dart';
import 'package:flutter_api/partials/color_pickers.dart';
import 'package:flutter_api/partials/font_pickers.dart';
import 'package:flutter_api/Pages/login_screen.dart';
import 'package:flutter_api/Pages/home_page.dart';

import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  bool _isBack = true;

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

  back() {
    if (_isBack == true) {
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
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(0),
                  height: 380,
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
                  top: 80,
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
                      onPressed: back,
                      child: const Text(
                        'Back',
                        style: TextStyle(
                            fontFamily: FontPicker.semibold,
                            color: ColorPicker.primary),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 160,
                  left: 25,
                  right: 25,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorPicker.white,
                        boxShadow: const [
                          BoxShadow(
                              color: ColorPicker.hintText,
                              offset: Offset(0, 1),
                              blurRadius: 9)
                        ]),
                    child: Column(
                      children: [
                        const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Add Categories',
                              style: TextStyle(
                                  color: ColorPicker.dark,
                                  fontFamily: FontPicker.semibold,
                                  fontSize: 16),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorPicker.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: ColorPicker.hintText,
                                    blurRadius: 7,
                                    offset: Offset(0, 1))
                              ]),
                          child: TextFormField(
                            // controller: ,
                            decoration: const InputDecoration(
                                hintText: "Category", border: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.all(0),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorPicker.primary,
                              boxShadow: const [
                                BoxShadow(
                                    color: ColorPicker.hintText,
                                    blurRadius: 7,
                                    offset: Offset(0, 1))
                              ]),
                          child: TextButton(
                            onPressed: () {
                              // addCategory
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                  color: ColorPicker.white,
                                  fontFamily: FontPicker.semibold,
                                  fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(0),
                    child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "List Categories",
                          style: TextStyle(
                              color: ColorPicker.dark,
                              fontSize: 18,
                              fontFamily: FontPicker.semibold),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // show category list
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 10, right: 0),
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 60,
                    decoration: BoxDecoration(
                        color: ColorPicker.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: ColorPicker.hintText,
                              offset: Offset(0, 1),
                              blurRadius: 7)
                        ]),
                    child: ListTile(
                        title: const Text(
                          'Dummy',
                          style: TextStyle(
                            color: ColorPicker.grey,
                            fontFamily: FontPicker.medium,
                            fontSize: 13,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            color: ColorPicker.danger,
                          ),
                          onPressed: () {},
                        )),
                  ),
                  // Show list Category
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
