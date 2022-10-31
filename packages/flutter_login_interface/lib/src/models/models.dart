// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

class LoginResponse<T> {
  final bool loginSuccessful;

  final T? userObject;

  LoginResponse({
    required this.loginSuccessful,
    required this.userObject,
  });
}

class EmailPasswordLogin {
  String email;
  String password;

  EmailPasswordLogin({
    required this.email,
    required this.password,
  });
}
