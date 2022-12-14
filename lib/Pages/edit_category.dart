// ignore_for_file: unused_import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_api/Services/auth_services.dart';
import 'package:flutter_api/Services/category_services.dart';
import 'package:flutter_api/partials/color_pickers.dart';
import 'package:flutter_api/partials/font_pickers.dart';
import 'package:flutter_api/Pages/edit_category.dart';
import 'package:flutter_api/Pages/login_screen.dart';
import 'package:flutter_api/Pages/home_page.dart';
import 'package:flutter_api/Models/category_model.dart';

import 'package:http/http.dart' as http;

class EditCategoryScreen extends StatefulWidget {
  EditCategoryScreen({
    super.key,
    this.category,
  });

  Category? category;

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  final TextEditingController editTextController = TextEditingController();
  String? editCategoryError;

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
    editTextController.text = widget.category!.name;

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
                          'Have a nice day ????',
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
                      onPressed: () {
                        Navigator.pushNamed(context, '/category');
                      },
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
                              'Edit Categories',
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
                            keyboardType: TextInputType.text,
                            controller: editTextController,
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(25.0),
                              //   borderSide: BorderSide.none,
                              // ),
                              filled: true,
                              // fillColor: Colors.grey[100],
                              hintText: "Category Name",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.grey[600],
                              ),
                              errorText: editCategoryError,
                              errorStyle: const TextStyle(
                                fontSize: 16.0,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 1.0),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                editCategoryError = null;
                              });
                            },
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
                              CategoryService.requestUpdate(
                                      widget.category!, editTextController.text)
                                  .then((response) {
                                if (response.statusCode == 200) {
                                  editTextController.clear();
                                  Navigator.pushNamed(context, '/category');
                                } else if (response.statusCode == 422) {
                                  var jsonObj = json.decode(response.body);
                                  var errors = jsonObj['errors'];
                                  setState(() {
                                    editCategoryError = errors['name'][0];
                                  });
                                }
                              });
                            },
                            child: const Text(
                              'Update',
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
          ],
        ),
      ),
    );
  }
}
