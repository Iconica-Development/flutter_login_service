// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter_data_interface/flutter_data_interface.dart';
import 'package:flutter_login_interface/flutter_login_interface.dart';

abstract class LoginInterface<T> extends DataInterface {
  LoginInterface() : super(token: _token);

  static final Object _token = Object();

  static LoginInterface _instance = LoginDefaultDataProvider();

  static LoginInterface get instance => _instance;

  static set instance(LoginInterface instance) {
    DataInterface.verify(instance, _token);
    _instance = instance;
  }

  Future<LoginResponse<T>> loginWithEmailAndPassword(
    EmailPasswordLogin login,
    {
  // ignore: avoid_annotating_with_dynamic
    Function(dynamic resolver)? onMFA,
  });

  Future<bool> requestPasswordReset(String email);

  Future<bool> logout();

  Future<T?> getLoggedInUser();
}
