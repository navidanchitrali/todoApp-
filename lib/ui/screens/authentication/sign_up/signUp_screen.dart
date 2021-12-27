// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mytodoapp/core/constants/text_style.dart';
import 'package:mytodoapp/ui/screens/HomePage/home_screen.dart';
import 'package:mytodoapp/ui/screens/authentication/login/login_screen.dart';
import 'package:mytodoapp/ui/screens/authentication/sign_up/sign_up_view_model.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
      child: Consumer<SignUpViewModel>(builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 80, left: 30, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Sign Up',
                        style: latoTextStyle,
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    TextFormField(
                      validator: (String? val) {
                        if (val!.isEmpty || val.length < 1) {
                          return "Please Enter First Name";
                        }
                        if (val.length > 40) {
                          return "First Name should not be less than 6 ";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'First Name'),
                      controller: model.firstNameTextEditingController,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    TextFormField(
                      validator: (String? val) {
                        if (val!.isEmpty || val.length < 1) {
                          return "Please Enter Last Name";
                        }
                        if (val.length > 40) {
                          return "Last Name should not be less than 6 ";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Last Name'),
                      controller: model.lastNameTextEditingController,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    TextFormField(
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
                      controller: model.emailTextEditingController,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    TextFormField(
                      obscureText: true,
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
                      controller: model.passwordTextEditingController,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    TextFormField(
                      validator: (String? val) {
                        if (val!.isEmpty || val.length < 1) {
                          return "Please Enter Repeat Password";
                        }
                        if (val.length > 40) {
                          return "Repeat password should not be less than 6 ";
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Repeat Password'),
                      controller: model.confirmPasswordTextEditingController,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),

                    ///
                    ///  Sign Up button
                    ///
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await model.createAccount();
                            if (model.authResult!.status!) {
                              Get.offAll(() => HomeScreen());
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Sign Up Error'),
                                  content: Text(
                                      model.authResult!.errorMessage ??
                                          'Sign Up Failed'),
                                ),
                              );
                            }
                          }
                        },
                        child: Text('Sign Up')),
                    SizedBox(
                      height: 30.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(LoginScreen());
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
                            'Go to Login',
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    )
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
