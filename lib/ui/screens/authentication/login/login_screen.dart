// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mytodoapp/core/constants/text_style.dart';
import 'package:mytodoapp/ui/screens/HomePage/home_screen.dart';
import 'package:mytodoapp/ui/screens/authentication/login/login_view_model.dart';
import 'package:mytodoapp/ui/screens/authentication/sign_up/signUp_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Consumer<LoginViewModel>(builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 180, left: 30, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Log In',
                        style: latoTextStyle,
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    TextFormField(
                        controller: model.emailTextEditingController,
                        validator: (String? val) {
                          if (val!.isEmpty || val.length < 1) {
                            return "Please Enter Email";
                          }
                          if (val.length > 40) {
                            return "Email should valid ";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: 'Email'),
                        onChanged: (value) {}),
                    SizedBox(
                      height: 25.h,
                    ),
                    TextFormField(
                        obscureText: true,
                        controller: model.passwordTextEditingController,
                        validator: (String? val) {
                          if (val!.isEmpty || val.length < 1) {
                            return "Please Enter Password";
                          }
                          if (val.length > 40) {
                            return "password should not be less than 6 ";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: 'Password'),
                        onChanged: (value) {}),
                    SizedBox(
                      height: 25.h,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await model.loginWithEmailPassword();

                            if (model.authResult.status!) {
                              Get.offAll(() => HomeScreen());
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Sign Up Error'),
                                  content: Text(model.authResult.errorMessage ??
                                      'Sign Up Failed'),
                                ),
                              );
                            }
                          }
                        },
                        child: Text('Log In')),
                    SizedBox(
                      height: 30.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(SignUpScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            'Go to Sign Up',
                            style: TextStyle(
                                color: Color.fromARGB(255, 34, 135, 218)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
