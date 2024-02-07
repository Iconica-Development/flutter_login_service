// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter_login_interface/flutter_login_interface.dart';

class LoginDefaultDataProvider extends LoginInterface<String> {
  LoginDefaultDataProvider();

  bool loggedIn = false;

  @override
  Future<LoginResponse<String>> loginWithEmailAndPassword(
    EmailPasswordLogin login, {
    // ignore: avoid_annotating_with_dynamic
    Function(dynamic resolver)? onMFA,
  }) async {
    loggedIn = true;
    return LoginResponse(
      loginSuccessful: true,
      userObject: 'test',
    );
  }

  @override
  Future<bool> requestPasswordReset(String email) async => true;

  @override
  Future<String?> getLoggedInUser() async {
    if (loggedIn) {
      return 'test';
    }
    return null;
  }

  @override
  Future<bool> logout() async {
    loggedIn = false;
    return true;
  }
}
