import 'package:flutter/cupertino.dart';
import 'package:mytodoapp/core/enums/view_state.dart';
import 'package:mytodoapp/core/models/app_user.dart';
import 'package:mytodoapp/core/models/custom_auth_result.dart';
import 'package:mytodoapp/core/services/auth_services.dart';
import 'package:mytodoapp/core/services/database_services.dart';
import 'package:mytodoapp/core/view_model/base_view_model.dart';

import '../../../locator.dart';

class LoginViewModel extends BaseViewModel {
  AppUser appUser = AppUser();
  final _authService = locator<AuthService>();
  final _dbService = DatabaseService();
  late CustomAuthResult authResult;

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  ///
  /// Login with Email and Password Functions
  ///

  // ignore: todo
  /// TODO: MAKE SURE WRAP ALL FUNCTION OR LOGIC IN TRY CATCH
  loginWithEmailPassword() async {
    setState(ViewState.busy);
    appUser.email = emailTextEditingController.text;
    appUser.password = passwordTextEditingController.text;
    authResult = await _authService.loginWithEmailPassword(
        email: appUser.email, password: appUser.password);
    if (authResult.status!) {}
    setState(ViewState.idle);
  }
}
