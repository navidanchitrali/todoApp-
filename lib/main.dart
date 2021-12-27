import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mytodoapp/ui/locator.dart';
import 'package:mytodoapp/ui/screens/add%20task/add_task_view_model.dart';
import 'package:mytodoapp/ui/screens/authentication/login/login_view_model.dart';
import 'package:mytodoapp/ui/screens/authentication/sign_up/sign_up_view_model.dart';
import 'package:mytodoapp/ui/screens/splash/splash_screen.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // ignore: prefer_const_constructors
      designSize: Size(375, 812),
      builder: () => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AddTaskViewModel()),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My Todo App',
          home: SplashScreen(),
        ),
      ),
    );
  }
}
