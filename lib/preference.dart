import 'package:flutter_api/screen/home_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPereference {
  static Future<void> shared(data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', data);
  }

  static Future<void> getshared() async {
    final prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString('token');
    if (token != null) {
        Get.toNamed(HomeScreen.routeName);
    }
  }
}