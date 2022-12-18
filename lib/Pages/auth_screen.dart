import 'package:flutter_api/partials/color_pickers.dart';
import 'package:flutter_api/partials/font_pickers.dart';
import 'package:flutter_api/Pages/login_screen.dart';
import 'package:flutter_api/Pages/register_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var isLogin = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(36),
          child: Center(
            child: Obx(
              () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const AuthScreen(),
                                    ));
                              },
                              child: Image.asset(
                                'assets/images/logo.png', // On click should redirect to an URL
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          child: Text(
                            'Stisla Apps',
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: FontPicker.bold,
                              color: ColorPicker.dark,
                            ),
                          ),
                        ),
                        Container(
                          width: 300,
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            'Merupakan STARTING APP FLUTTER sederhana untuk memenuhi tugas akhir mata kuliah Mobile',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: FontPicker.medium,
                                color: ColorPicker.grey,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.all(0),
                      width: double.infinity,
                      // color: ColorPicker.bg,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: isLogin.value
                                    ? Colors.white
                                    : ColorPicker.primary,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color(0xffeeeeee),
                                      offset: Offset(0, 4),
                                      blurRadius: 7)
                                ],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const RegisterScreen(),
                                      ));
                                },
                                child: Center(
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      fontFamily: FontPicker.semibold,
                                      color: !isLogin.value
                                          ? Colors.white
                                          : ColorPicker.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: !isLogin.value
                                    ? Colors.white
                                    : ColorPicker.primary,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color(0xffeeeeee),
                                      offset: Offset(0, 4),
                                      blurRadius: 7)
                                ],
                              ),
                              child: TextButton(
                                // height: 50,
                                // minWidth: 170,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const LoginScreen(),
                                      ));
                                },
                                child: Center(
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: isLogin.value
                                            ? ColorPicker.white
                                            : ColorPicker.primary,
                                        fontFamily: FontPicker.semibold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
