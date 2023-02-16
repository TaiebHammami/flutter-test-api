import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api/Service/api.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RxBool isObsucure = true.obs;
  RxBool isObsucureC = true.obs;
  final key = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordControllerConfirmation  = TextEditingController();


  void save() async {
    final valid = key.currentState!.validate();
    if (!valid) {
      return;
    }
    var data = {
      'name' : nameController.text,
      'email' : emailController.text,
      'password' : passwordController.text,
      'password_confirmation' : passwordControllerConfirmation.text
    };
    print(nameController.text);
    await CallApi().postData(data , 'register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register"
        ),
      ),
        body: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          SizedBox(height : 50),
          Form(
            key: key,
            child: Column(
              children: [
                TextFormField(
                  onSaved: (val) {},
                  controller: nameController,
                  validator: (val) {
                    if (val!.isEmpty ||
                        val.length<2) {
                      return "please verified your name";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    //labelText: 'email...',
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    hintText: 'name...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blueAccent)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blueAccent)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blueAccent)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blueAccent)),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
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
                        borderSide: const BorderSide(color: Colors.blueAccent)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blueAccent)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blueAccent)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blueAccent)),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
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
                          passwordControllerConfirmation.text = ''  ;
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
                SizedBox(
                  height: 30,
                ),
                 Obx(() => TextFormField(
                      obscureText: isObsucureC.value,
                      controller: passwordControllerConfirmation,
                      validator: (val) {
                        if (passwordController.text != val) {
                          return "please confirmed your password ";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        suffixIcon: Obx(
                          () => GestureDetector(
                            onTap: () {
                              isObsucureC.value = !isObsucureC.value;
                            },
                            child: Icon(isObsucureC.value
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
                          print(passwordControllerConfirmation.text);
                        },
                        child: Text('Sign In',
                            style: Theme.of(context).textTheme.titleMedium)),
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
