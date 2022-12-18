import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'globals.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'package:flutter_api/Pages/category_screen.dart';
import 'package:flutter_api/Services/header_helper.dart';

class AuthServices extends GetxController {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  // final String _deviceName = 'handphone';

  static Future<http.Response> login(
      String email, String password, String device_name) async {
    Map data = {
      "email": email,
      "password": password,
      "device_name": device_name,
    };
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode(data);
    var url = Uri.parse('http://10.0.2.2:8000/api/auth/login');
    http.Response response = await http.post(url, headers: headers, body: body);

    Map<String, dynamic> responseJson = json.decode(response.body);

    if (responseJson['code'] == 0) {
      var token = responseJson['token'];
      var name = responseJson['data']['name'];

      final SharedPreferences prefs = await _prefs;
      await prefs.setString('token', token);
      await prefs.setString('name', name);

      Get.off(const HomeScreen());
    } else if (responseJson['code'] == 1) {
      throw jsonDecode(response.body)['errors'];
    }

    // save token use shared preferences
    SharedPreferences sp = await SharedPreferences.getInstance();

    sp.setString("token", responseJson['token']);
    // sp.setString("name", responseJson['body']['email']);

    // ignore: avoid_print
    print(sp.getString("token"));
    // print(sp.getString("name"));

    // ignore: avoid_print
    print(response.body);
    return response;
  }

  static Future<http.Response> logout() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    String? token = sp.getString("token");

    var url = Uri.parse('http://10.0.2.2:8000/api/auth/logout');

    final header = {
      'Authorization': 'Bearer $token',
    };

    http.Response response = await http.post(
      url,
      headers: header,
    );

    sp.remove("token");

    return response;
  }
}
