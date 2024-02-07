// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter_login_interface/flutter_login_interface.dart';

/// A Calculator.
class LoginService<T> {
  LoginService._(LoginInterface<T> data) : dataSource = data;
  static LoginService<T> forDatasource<T>({
    required LoginInterface<T> dataSource,
  }) =>
      LoginService<T>._(dataSource);

  static LoginService<String> standard() =>
      LoginService._(LoginDefaultDataProvider());

  LoginInterface<T> dataSource;

  Future<T?> loginWithEmailAndPassword(
    String email,
    String password, {
    // ignore: avoid_annotating_with_dynamic
    Function(dynamic resolver)? onMFA,
  }) async {
    var result = await dataSource.loginWithEmailAndPassword(
      EmailPasswordLogin(email: email, password: password),
      onMFA: onMFA,
    );
    if (result.loginSuccessful) {
      return result.userObject;
    }
    return null;
  }

  Future<bool> requestChangePassword(String email) =>
      dataSource.requestPasswordReset(email);

  Future<T?> getLoggedInUser() => dataSource.getLoggedInUser();

  Future<bool> logout() => dataSource.logout();
}
