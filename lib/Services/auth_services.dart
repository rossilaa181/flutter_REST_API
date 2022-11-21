import 'dart:convert';

import 'globals.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  static Future<http.Response> register(
      String name, String email, String password) async {
    Map data = {
      "name": name,
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse('http://10.0.2.2:8000/api/auth/register');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    // ignore: avoid_print
    print(response.body);
    return response;
  }

  static Future<http.Response> login(
      String email, String password, String device_name) async {
    Map data = {
      "email": email,
      "password": password,
      "device_name": device_name,
    };
    var body = json.encode(data);
    var url = Uri.parse('http://10.0.2.2:8000/api/auth/login');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    // ignore: avoid_print
    print(response.body);
    return response;
  }
}
