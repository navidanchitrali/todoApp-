// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodoapp/core/constants/text_style.dart';
import 'package:mytodoapp/core/services/auth_services.dart';
import 'package:mytodoapp/ui/locator.dart';
import 'package:mytodoapp/ui/screens/HomePage/home_screen.dart';
import 'package:mytodoapp/ui/screens/authentication/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authService = locator<AuthService>();

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  init() async {
    await Future.delayed(Duration(seconds: 3));
    if (authService.isLogin! && authService.appUser != null) {
      Get.to(() => HomeScreen());
    } else {
      Get.to(() => LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Splash Screen',
              style: latoTextStyle.copyWith(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
