import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../Models/user_modal.dart';
import 'globals.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class AuthServices {
  String token;

  AuthServices({
    required this.token,
  });

  factory AuthServices.createObjectResult(Map<String, dynamic> objectResult) {
    return AuthServices(token: objectResult['token']);
  }

  static Future<http.Response> login(String email, String password) async {
    final sharedPref = await SharedPreferences.getInstance();
    Map data = {
      "email": email,
      "password": password,
      "device_name": 'rosilaaa',
    };
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode(data);
    var url = Uri.parse('http://127.0.0.1:8000/api/auth/login');
    http.Response response = await http.post(url, headers: headers, body: body);

    var jsonObject = json.decode(response.body);
    if (response.statusCode == 200) {
      var object = AuthServices.createObjectResult(jsonObject);
      var userData = (jsonObject as Map<String, dynamic>)['data'];

      var user = User.fromMap(userData);
      var userPropertiesList = User.toStrList(user);
      // simpen ke shared pref
      sharedPref.setString('token', object.token);
      sharedPref.setStringList('user', userPropertiesList);
    }

    // Map<String, dynamic> responseJson = json.decode(response.body);

    // // save token use shared preferences
    // SharedPreferences sp = await SharedPreferences.getInstance();

    // sp.setString("token", responseJson['token']);

    // // ignore: avoid_print
    // print(sp.getString("token"));

    // // ignore: avoid_print
    // print(response.body);
    return response;
  }

  static Future<http.Response> logout() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    String? token = sp.getString("token");

    var url = Uri.parse('http://127.0.0.1:8000/api/auth/logout');

    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    http.Response response = await http.post(
      url,
      headers: header,
    );

    if (response.statusCode == 204) {
      sp.remove('token');
      sp.remove('user');
    }

    return response;
  }
}
