// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:flutter/material.dart';

import 'package:flutter_api/Services/auth_services.dart';
import 'package:flutter_api/Services/category_services.dart';
import 'package:flutter_api/partials/color_pickers.dart';
import 'package:flutter_api/partials/font_pickers.dart';
import 'package:flutter_api/Pages/login_screen.dart';
import 'package:flutter_api/Pages/home_page.dart';
import 'package:flutter_api/Pages/addCategory_services.dart';
import 'package:flutter_api/Models/category_model.dart';
import 'package:flutter_api/Widgets/categoryCard.dart';

import 'package:http/http.dart' as http;

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String? token;
  List<String> user = [];
  List<Category> categories = [];
  int selectedIndex = 0;
  int currentPage = 1;
  int lastPage = 0;
  bool isLoading = true;

  final ScrollController scrollController = ScrollController();

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

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

  fetchData() {
    CategoryService.getCategories(currentPage.toString()).then((resultList) {
      setState(() {
        categories = resultList[0];
        lastPage = resultList[1];
        isLoading = false;
      });
    });
  }

  addMoreData() {
    CategoryService.getCategories(currentPage.toString()).then((resultList) {
      setState(() {
        categories.addAll(resultList[0]);
        lastPage = resultList[1];
        isLoading = false;
      });
    });
  }

  deleteData(Category category) {
    CategoryService.requestDelete(category).then((response) {
      if (response.statusCode == 204) {
        setState(() {
          currentPage = 1;
        });
        fetchData();
      }
    });
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

    scrollController.addListener(() {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        if (currentPage < lastPage) {
          setState(() {
            isLoading = false;
            currentPage++;
            addMoreData();
          });
        }
      }
    });

    fetchData();
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
      key: _scaffoldkey,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.data_array),
            label: 'Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_card_sharp),
            label: 'Add',
          ),
        ],
        selectedItemColor: const Color(0xff6777ef),
        currentIndex: selectedIndex,
        onTap: isLoading
            ? null
            : (int index) {
                setState(() {
                  selectedIndex = index;
                });
              },
      ),
      body: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        decoration: const BoxDecoration(
            color: ColorPicker.primary,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 50.0,
                  right: 25.0,
                  left: 25.0,
                  bottom: 20.0,
                ),
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
                          isLoading ? 'Loading...' : user[0],
                          style: const TextStyle(
                              fontFamily: FontPicker.bold,
                              fontSize: 20,
                              color: ColorPicker.white),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        isLoading ? 'Loading...' : user[1],
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
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Have a nice day 😊',
                        style: TextStyle(
                            fontFamily: FontPicker.medium,
                            fontSize: 14,
                            color: ColorPicker.white),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
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
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     CircleAvatar(
                    //       backgroundImage:
                    //           Image.asset('assets/images/avatar-1.png').image,
                    //     ),
                    //     const Text(
                    //       'Dashboard',
                    //       style: TextStyle(
                    //         fontSize: 24.0,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //     GestureDetector(
                    //       onTap: () async {
                    //         AuthServices.logout().then((response) {
                    //           if (response.statusCode == 204) {
                    //             Navigator.pushNamed(context, '/login');
                    //           }
                    //         });
                    //       },
                    //       child: const Icon(
                    //         Icons.logout_outlined,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Row(
                    //       children: [
                    //         const Text(
                    //           'Hello, ',
                    //           style: TextStyle(
                    //             fontSize: 20.0,
                    //             color: Colors.white,
                    //           ),
                    //         ),
                    //         Text(
                    //           isLoading ? 'Loading...' : user[0],
                    //           style: const TextStyle(
                    //             fontSize: 20.0,
                    //             color: Colors.white,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.only(
                    //         top: 4.0,
                    //       ),
                    //       child: Text(
                    //         isLoading ? 'Loading...' : user[1],
                    //         style: const TextStyle(
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.w100,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: (selectedIndex == 0)
                    ? isLoading
                        ? CircularPercentIndicator(
                            radius: 60.0,
                            lineWidth: 10.0,
                            percent: 1.0,
                            animation: true,
                            center: const Text('Loading'),
                            progressColor: const Color(0xff6777ef),
                          )
                        : Column(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text(
                                    'Categories Data',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff6777ef),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: GridView.builder(
                                  controller: scrollController,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 25.0,
                                  ),
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent:
                                        MediaQuery.of(context).size.width / 2,
                                    childAspectRatio: 2 / 2,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemCount: categories.length,
                                  itemBuilder: (context, index) => CategoryCard(
                                    alertContext: _scaffoldkey.currentContext!,
                                    category: categories[index],
                                    deleteData: deleteData,
                                  ),
                                ),
                              ),
                            ],
                          )
                    : const AddCategory(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
