// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_login_service/src/models/models.dart';

/// A service to handle authentication.
/// Implement this class to create a custom login service.
abstract class LoginServiceInterface {
  /// [loginWithEmailAndPassword] is used to login a user with email and
  /// password. If the login is successful, the response will contain
  /// a [LoginResponse] with the user object. If the login is not
  /// successful, the response will contain an [Error] object with
  /// the error title and message.
  /// Optionally, you can provide an [onMFA] function to handle
  /// multi-factor authentication.
  Future<LoginResponse> loginWithEmailAndPassword(
    String email,
    String password,
    BuildContext context, {
    // ignore: avoid_annotating_with_dynamic
    Function(dynamic resolver)? onMFA,
  });

  /// [requestChangePassword] is used to request a password reset.
  /// If the request is successful, the response will contain a
  /// [RequestPasswordResponse] with [requestSuccesfull] set to true.
  Future<RequestPasswordResponse> requestChangePassword(
    String email,
    BuildContext context,
  );

  /// [logout] is used to log out the currently logged in user.
  Future<bool> logout(BuildContext context);

  /// [getLoggedInUser] is used to get the currently logged in user.
  Future getLoggedInUser();
}

/// A local login service for testing purposes.
class LocalLoginService implements LoginServiceInterface {
  @override
  Future getLoggedInUser() async => true;

  @override
  Future<LoginResponse> loginWithEmailAndPassword(
    String email,
    String password,
    BuildContext context, {
    // ignore: avoid_annotating_with_dynamic
    Function(dynamic resolver)? onMFA,
  }) async =>
      const LoginResponse(loginSuccessful: true, userObject: null);

  @override
  Future<bool> logout(BuildContext context) async => true;

  @override
  Future<RequestPasswordResponse> requestChangePassword(
    String email,
    BuildContext context,
  ) async =>
      const RequestPasswordResponse(
        requestSuccesfull: true,
      );
}
