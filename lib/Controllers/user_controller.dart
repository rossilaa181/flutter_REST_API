// import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String?> getToken() async {
    final prefs = await _prefs;
    return prefs.getString('token');
  }

  Future<String?> getName() async {
    final prefs = await _prefs;
    return prefs.getString('name');
  }
}
