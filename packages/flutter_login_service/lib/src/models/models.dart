// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

/// A [LoginResponse] object is returned from a login attempt.
/// If the login was successful, [loginSuccessful] will be true and
/// [userObject] will contain the user object. If the login was not
/// successful, [loginSuccessful] will be false and [loginError] will
/// contain an [Error] object with the error title and message.
class LoginResponse<T> {
  const LoginResponse({
    required this.loginSuccessful,
    required this.userObject,
    this.loginError,
  });
  final bool loginSuccessful;

  final T? userObject;
  final Error? loginError;
}

class EmailPasswordLogin {
  const EmailPasswordLogin({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}

/// A [Error] object contains the title and message of an error.
class Error {
  const Error({
    required this.title,
    required this.message,
  });
  final String title;
  final String message;
}

/// A [RequestPasswordResponse] object is returned from a password
/// reset request. If the request was successful, [requestSuccesfull]
/// will be true. If the request was not successful, [requestSuccesfull]
/// will be false and [requestPasswordError] will contain an [Error]
/// object with the error title and message.
class RequestPasswordResponse<T> {
  const RequestPasswordResponse({
    required this.requestSuccesfull,
    this.requestPasswordError,
  });
  final bool requestSuccesfull;

  final Error? requestPasswordError;
}
