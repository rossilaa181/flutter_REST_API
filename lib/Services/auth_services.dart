import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'globals.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class AuthServices extends GetxController {
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

    // save token use shared preferences
    SharedPreferences sp = await SharedPreferences.getInstance();

    sp.setString("token", responseJson['token']);

    // ignore: avoid_print
    print(sp.getString("token"));

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
