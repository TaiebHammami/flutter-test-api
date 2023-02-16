import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api/screen/register_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Service/api.dart';
import '../preference.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  RxBool isObsucure = true.obs;

  final key = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();
  var api = CallApi();

  void save() async {
    final valid = key.currentState!.validate();
    if (!valid) {
      return;
    }
    var data = {
      'email': emailController.text,
      'password': passwordController.text
    };
    print(data);
    await api.Login(data, 'login');
  }

  @override
  void initState() {
    SharedPereference.getshared();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading:Icon(Icons.login),
          title: Text("Login "),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Form(
                key: key,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (val) {},
                      controller: emailController,
                      validator: (val) {
                        if (val!.toLowerCase().isEmpty ||
                            !val.contains('@gmail.com')) {
                          return "please write your email";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        //labelText: 'email...',
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        hintText: 'email...',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.blueAccent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.blueAccent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.blueAccent)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.blueAccent)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Obx(() => TextFormField(
                          obscureText: isObsucure.value,
                          controller: passwordController,
                          validator: (val) {
                            if (val!.length < 8) {
                              return "please write your password min 8";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            suffixIcon: Obx(
                              () => GestureDetector(
                                onTap: () {
                                  isObsucure.value = !isObsucure.value;
                                },
                                child: Icon(isObsucure.value
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                            //labelText: 'email...',
                            prefixIcon: const Icon(
                              Icons.password,
                              color: Colors.black,
                            ),
                            hintText: 'password...',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.blueAccent)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.blueAccent)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.blueAccent)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.blueAccent)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              save();
                            },
                            child: Text('Sign In',
                                style:
                                    Theme.of(context).textTheme.titleMedium)),
                        TextButton(
                            onPressed: () {
                              Get.to(RegisterScreen(),
                                  transition: Transition.rightToLeft);
                            },
                            child: Text(
                              'Sign Up',
                              style: Theme.of(context).textTheme.titleMedium,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
