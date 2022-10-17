import 'dart:convert';

import 'package:flutter_login_shared_preferences/src/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_login_interface/flutter_login_interface.dart';

class LoginSharedPreferencesDataProvider
    extends LoginInterface<BasicLoginModel> {
  LoginSharedPreferencesDataProvider();

  SharedPreferences? _instance;

  static const _loginKeyPrefix = '_login_';

  Future<SharedPreferences> get _prefs async =>
      _instance ??= await SharedPreferences.getInstance();

  @override
  Future<LoginResponse<BasicLoginModel>> loginWithEmailAndPassword(
      EmailPasswordLogin login) async {
    var prefs = await _prefs;
    var value = prefs.getString('$_loginKeyPrefix${login.email}');
    if (value != null) {
      var raw = jsonDecode(value);
      var model = BasicLoginModel.fromJson(raw);
      if (model.passwordMatches(login.password)) {
        return LoginResponse(loginSuccessful: true, userObject: model);
      }
    }
    return LoginResponse<BasicLoginModel>(
        loginSuccessful: false, userObject: null);
  }

  @override
  Future<bool> requestPasswordReset(String email) {
    throw UnimplementedError();
  }
}
