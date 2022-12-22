import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/category_model.dart';

class CategoryService {
  static String endPoint = "http://127.0.0.1:8000";

  static Future<List<dynamic>> getCategories(String page) async {
    var apiUrl =
        Uri.parse('${CategoryService.endPoint}/api/categories?page=$page');
    final sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString('token');

    List<Category> categories = [];
    List<dynamic> categoryServices = [];

    var response = await http.get(
      apiUrl,
      headers: {
        'Content-Type': 'application/json',      
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      List<dynamic> listCategories =
          (jsonObject as Map<String, dynamic>)['data'];

      var page = jsonObject['meta'];

      List listPage = page.values.toList();

      for (var category in listCategories) {
        categories.add(Category.fromMap(category));
      }

      categoryServices.add(categories);
      categoryServices.add(listPage[2]);
    }

    return categoryServices;
  }

  static Future requestAddCategory(String name) async {
    var apiUrl = Uri.parse('${CategoryService.endPoint}/api/categories');

    final sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString('token');

    final response = await http.post(
      apiUrl,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
      body: {
        "name": name,
      },
    );

    return response;
  }

  static Future requestUpdate(Category category, String newCategoryName) async {
    var apiUrl =
        Uri.parse('${CategoryService.endPoint}/api/categories/${category.id}');

    final sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString('token');

    final response = await http.put(
      apiUrl,
      headers: {
        "Accept": "application/json",       
        "Authorization": "Bearer $token",
      },
      body: {
        "name": newCategoryName,
      },
    );

    return response;
  }

  static Future requestDelete(Category category) async {
    var apiUrl =
        Uri.parse('${CategoryService.endPoint}/api/categories/${category.id}');

    final sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString('token');

    final response = await http.delete(
      apiUrl,
      headers: {
        "Accept": "application/json",       
        "Authorization": "Bearer $token",
      },
    );

    return response;
  }
}
