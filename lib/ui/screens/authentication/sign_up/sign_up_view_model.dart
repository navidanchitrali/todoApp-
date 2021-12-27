import 'package:flutter/material.dart';
import 'package:mytodoapp/core/enums/view_state.dart';
import 'package:mytodoapp/core/models/app_user.dart';
import 'package:mytodoapp/core/models/custom_auth_result.dart';
import 'package:mytodoapp/core/services/auth_services.dart';
import 'package:mytodoapp/core/view_model/base_view_model.dart';

import '../../../locator.dart';

class SignUpViewModel extends BaseViewModel {
  AppUser appUser = AppUser();
  final _authService = locator<AuthService>();
  // final _dbService = DatabaseService();
  CustomAuthResult? authResult;
  TextEditingController firstNameTextEditingController =
      TextEditingController();
  TextEditingController lastNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  createAccount() async {
    appUser.firstName = firstNameTextEditingController.text;
    appUser.lastName = lastNameTextEditingController.text;
    appUser.email = emailTextEditingController.text;
    appUser.password = passwordTextEditingController.text;
    appUser.confirmPassword = confirmPasswordTextEditingController.text;
    print('@ViewModel/createAccount');
    setState(ViewState.busy);
    try {
      authResult = await _authService.signUpWithEmailPassword(appUser);
    } catch (e, s) {
      print("@SignUp View Model createAccount Exception $e");
    }
    setState(ViewState.idle);
  }
}
