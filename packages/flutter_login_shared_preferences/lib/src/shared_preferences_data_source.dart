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
        prefs.setString('${_loginKeyPrefix}current', model.username);
        return LoginResponse(loginSuccessful: true, userObject: model);
      }
    }
    return LoginResponse<BasicLoginModel>(
        loginSuccessful: false, userObject: null);
  }

  @override
  Future<bool> requestPasswordReset(String email) async {
    return false;
  }

  @override
  Future<BasicLoginModel?> getLoggedInUser() async {
    var key = '${_loginKeyPrefix}current';
    var prefs = await _prefs;
    if (prefs.containsKey(key)) {
      var username = prefs.get(key);
      var userKey = '$_loginKeyPrefix$username';
      var raw = jsonDecode(prefs.getString(userKey)!);
      return BasicLoginModel.fromJson(raw);
    } else {
      return null;
    }
  }

  @override
  Future<bool> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
