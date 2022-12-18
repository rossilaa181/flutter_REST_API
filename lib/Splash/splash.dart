import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_api/partials/color_pickers.dart';
import 'package:flutter_api/partials/font_pickers.dart';
import 'package:flutter_api/Pages/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AuthScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(0),
      color: ColorPicker.primary,
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: ColorPicker.primary),
            ),
          ),
          Positioned(
            right: -50,
            top: 100,
            child: Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: ColorPicker.primaryShape),
            ),
          ),
          Positioned(
            left: -50,
            bottom: 50,
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: ColorPicker.primaryLight),
            ),
          ),
          Positioned(
            left: -75,
            bottom: 200,
            child: Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: ColorPicker.primaryShape),
            ),
          ),
          const Center(
            child: Text(
              'Stisla Apps',
              style: TextStyle(
                  color: ColorPicker.white,
                  fontFamily: FontPicker.bold,
                  fontSize: 40,
                  decoration: TextDecoration.none),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 50),
            child: const Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'By Rosi Latansa Salsabela',
                style: TextStyle(
                    color: ColorPicker.white,
                    fontFamily: FontPicker.regular,
                    fontSize: 10,
                    decoration: TextDecoration.none),
              ),
            ),
          )
        ],
      ),
    );
  }
}
