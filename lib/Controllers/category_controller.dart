// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:get/get.dart';
// import 'package:flutter_api/Models/category_model.dart';
// import 'package:flutter_api/utils/api_endpoints.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_api/utils/headers_helper.dart';
// import 'package:flutter_api/views/home/home.dart';

// class CategoryController extends GetxController {
//   var isLoading = true.obs;
//   var categoryList = <CategoryModel>[].obs;
//   String controller = '';
//   TextEditingController nameController = TextEditingController();

//   @override
//   void onInit() {
//     fetchData();
//     changeController();
//     super.onInit();
//   }

//   void changeController() {
//     nameController.text = (controller == '') ? '' : controller;
//   }

//   void confirmAlert(id) {
//     Widget cancelButton = TextButton(
//       child: const Text("Cancel"),
//       onPressed: () {
//         Get.back();
//       },
//     );
//     Widget deletButton = TextButton(
//       child: const Text("Delete"),
//       onPressed: () {
//         try {
//           isLoading(true);
//           deleteData(id);
//           onInit();
//         } finally {
//           isLoading(false);
//         }
//       },
//     );

//     showDialog(
//         context: Get.context!,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Confirmation'),
//             contentPadding: const EdgeInsets.all(20),
//             content: const Text("Are you sure to delete data?"),
//             actions: [
//               cancelButton,
//               deletButton,
//             ],
//           );
//         });
//   }

//   void fetchData() async {
//     try {
//       isLoading(true);
//       var categories = await getList();
//       if (categories != null) {
//         categoryList.assignAll(categories);
//       }
//     } finally {
//       isLoading(false);
//     }
//   }

//   static Future<List<CategoryModel>?> getList() async {
//     // ignore: no_leading_underscores_for_local_identifiers
//     final SharedPreferences _prefs = await SharedPreferences.getInstance();
//     var token = _prefs.getString('token');
//     try {
//       var url = Uri.parse(ApiEndPoints.baseUrl +
//           ApiEndPoints.authEndpoints.getUri('categories'));

//       http.Response response =
//           await http.get(url, headers: HeadersHelper().getHeaders(token));

//       print(response.statusCode);
//       print(jsonDecode(response.body));

//       if (response.statusCode == 200) {
//         var jsonString = response.body;
//         return categoryModelFromJson(jsonString);
//       }
//     } catch (error) {
//       Get.back();

//       showDialog(
//           context: Get.context!,
//           builder: (context) {
//             return SimpleDialog(
//               title: const Text('Error'),
//               contentPadding: const EdgeInsets.all(20),
//               children: [Text(error.toString())],
//             );
//           });
//     }
//     return null;
//   }

//   Future<void> addData() async {
//     final SharedPreferences _prefs = await SharedPreferences.getInstance();
//     var token = _prefs.getString('token');

//     try {
//       isLoading(true);
//       var url = Uri.parse(ApiEndPoints.baseUrl +
//           ApiEndPoints.authEndpoints.getUri('categories'));
//       Map body = {'name': nameController.text};
//       http.Response response = await http.post(url,
//           body: jsonEncode(body), headers: HeadersHelper().getHeaders(token));

//       print(response.statusCode);
//       if (response.statusCode == 201) {
//         nameController.clear();
//         onInit();
//         var message = 'Insert successfully!';
//         Get.back();
//         showDialog(
//             context: Get.context!,
//             builder: (context) {
//               return SimpleDialog(
//                 title: const Text('Success'),
//                 contentPadding: const EdgeInsets.all(20),
//                 children: [Text(message.toString())],
//               );
//             });
//       }
//     } finally {
//       isLoading(false);
//     }
//   }

//   Future<void> updateData(int id) async {
//     final SharedPreferences _prefs = await SharedPreferences.getInstance();
//     var token = _prefs.getString('token');

//     try {
//       isLoading(true);
//       var url = Uri.parse(ApiEndPoints.baseUrl +
//           ApiEndPoints.authEndpoints.getUri('categories/$id'));
//       Map body = {'name': nameController.text};
//       http.Response response = await http.put(url,
//           body: jsonEncode(body), headers: HeadersHelper().getHeaders(token));

//       print(response.statusCode);
//       print(response.body);
//       if (response.statusCode == 200) {
//         controller = '';
//         nameController.clear();
//         Get.offAll(const HomeScreen());
//         onInit();
//         var message = 'Update successfully!';
//         Get.back();
//         showDialog(
//             context: Get.context!,
//             builder: (context) {
//               return SimpleDialog(
//                 title: const Text('Success'),
//                 contentPadding: const EdgeInsets.all(20),
//                 children: [Text(message.toString())],
//               );
//             });
//       }
//     } finally {
//       isLoading(false);
//     }
//   }

//   static Future<void> deleteData(id) async {
//     final SharedPreferences _prefs = await SharedPreferences.getInstance();
//     var token = _prefs.getString('token');

//     var url = Uri.parse(ApiEndPoints.baseUrl +
//         ApiEndPoints.authEndpoints.getUri('categories/$id'));
//     http.Response response =
//         await http.delete(url, headers: HeadersHelper().getHeaders(token));

//     print(response.statusCode);
//     if (response.statusCode == 204) {
//       var message = 'Delete successfully!';
//       Get.back();
//       showDialog(
//           context: Get.context!,
//           builder: (context) {
//             return SimpleDialog(
//               title: const Text('Success'),
//               contentPadding: const EdgeInsets.all(20),
//               children: [Text(message.toString())],
//             );
//           });
//     }
//   }
// }
