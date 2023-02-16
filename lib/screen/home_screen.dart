import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api/screen/login_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Service/api.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? token = "";

  Future<String?> _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      token = localStorage.getString('token');
    });
    print(token);

    return token;
  }

  @override
  void initState() {
    _getToken();
    print(token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        actions: [
          IconButton(
              onPressed: () async {
                await CallApi().Logout('login');
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ))
        ],
        title: const Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
                Get.bottomSheet(
                   Container(
                      height: 150,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                      color: Colors.blue
                        ),
                      child: Center(
                          child: Column(
                        children: [TextField(),
                        SizedBox(height: 15,),
                        ElevatedButton(onPressed: (){

                        }, child:const Text(
                          "Add Task"
                        ) ,)],
                      ))))
                ;
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      body: Center(
        child: Text(token!),
      ),
    );
  }
}
