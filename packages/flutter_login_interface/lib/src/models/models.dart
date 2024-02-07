// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

class LoginResponse<T> {
  LoginResponse({
    required this.loginSuccessful,
    required this.userObject,
  });
  final bool loginSuccessful;

  final T? userObject;
}

class EmailPasswordLogin {
  EmailPasswordLogin({
    required this.email,
    required this.password,
  });
  String email;
  String password;
}
