import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_api/screen/home_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/task.dart';
import '../screen/login_screen.dart';
import '../preference.dart';

class CallApi {
  final String _url = "http://10.0.2.2:8000/api/";

  Future<void> postData(data, apiUrl) async {
    try {
      var fullUrl = _url + apiUrl;
      var res = await http.post(Uri.parse(fullUrl),
          body: jsonEncode(data), headers: _setHeaders());
      print(res.statusCode);
      if (res.statusCode == 200) {
        var responseBody = json.decode(res.body);
        print('$responseBody ********************');
        Get.back();
        Get.snackbar(
          'Register ',
          'You have been registered successfully',
        );
      } else {
        var responseBody = json.decode(res.body);

        Get.snackbar(
          'Register ',
          responseBody['message'],
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> Login(data, apiUrl) async {
    try {
      var fullUrl = _url + apiUrl;
      var response = await http.post(Uri.parse(fullUrl),
          body: jsonEncode(data), headers: _setHeaders());
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        print(responseBody);
        SharedPereference.shared(jsonEncode(responseBody['data']['token']));
        Get.toNamed(HomeScreen.routeName);
      } else {
        Get.snackbar('', response.body);
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> Logout(apiUrl) async {
    try {
      var fullUrl = _url + apiUrl + await _getToken();
      await http.get(Uri.parse(fullUrl), headers: _setHeaders());

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
      Get.toNamed(LoginScreen.routeName);
    } catch (e) {
      Get.snackbar('Try Again', '');
      throw Exception(e);
    }
  }

  Future<List<Task>> getTasks(token, apiUrl) async {
    try {
      var fullUrl = _url + apiUrl;
      var response = await http.get(
        Uri.parse(fullUrl),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/vnd.api+json',
          HttpHeaders.acceptHeader: 'application/vnd.api+json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
      );
      final list = <Task>[];
      if (response.statusCode == 200) {
        var tasks = json.decode(response.body)['data'];
        var item;
        for (item in tasks) {
          var m = Task.fromJson(item);
          list.add(m);
        }
      }
      return list;
    } catch (e) {
      throw Exception(e);
    }
  }

   Future<List<Task>> AddTask(token, apiUrl,data) async {
    try {
      var fullUrl = _url + apiUrl;
      var response = await http.post(
        Uri.parse(fullUrl),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/vnd.api+json',
          HttpHeaders.acceptHeader: 'application/vnd.api+json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        body:jsonEncode(data));
      final list = <Task>[];
      if (response.statusCode == 200) {
        var tasks = json.decode(response.body)['data'];
        var item;
        for (item in tasks) {
          var m = Task.fromJson(item);
          list.add(m);
        }
      }
      return list;
    } catch (e) {
      throw Exception(e);
    }
  }
  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    print(token);
    return '?token=$token';
  }
  _setHeaders() => {
        HttpHeaders.contentTypeHeader: 'application/vnd.api+json',
        HttpHeaders.acceptHeader: 'application/vnd.api+json',
      };
}
