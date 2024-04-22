// ignore_for_file: public_member_api_docs, sort_constructors_first
// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login_service/flutter_login_service.dart';

/// A service to handle authentication with Firebase.
/// Takes an instance of [FirebaseAuth] and an
/// optional [LoginServiceTranslations]
class FirebaseLoginService implements LoginServiceInterface {
  FirebaseLoginService({
    required this.auth,
    this.translationsService = const LoginServiceTranslations.empty(),
  });

  /// The [FirebaseAuth] instance to use for authentication.
  final FirebaseAuth auth;

  /// The translations service to use for error messages.
  final LoginServiceTranslations translationsService;

  /// The error response from the last login attempt.
  LoginResponse? loginError;

  /// The error response from the last password reset request.
  RequestPasswordResponse? requestPasswordError;

  /// Get the currently logged in user.
  @override
  Future<User?> getLoggedInUser() async => auth.authStateChanges().first;

  /// Log in with email and password.
  /// Returns a [LoginResponse] with the user object if the login was
  /// successful. If the login was not successful, the response will
  /// contain an [Error] object with the error title and message.
  @override
  Future<LoginResponse> loginWithEmailAndPassword(
    String email,
    String password,
    BuildContext context, {
    // ignore: avoid_annotating_with_dynamic
    Function(dynamic resolver)? onMFA,
  }) async {
    try {
      var credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return LoginResponse(
        loginSuccessful: credential.user != null,
        userObject: credential.user,
      );
    } on FirebaseAuthException catch (e) {
      loginError = switch (e.code) {
        'user-disabled' => LoginResponse(
            userObject: null,
            loginSuccessful: false,
            loginError: Error(
              title: translationsService.userDisabledMessage,
              message: translationsService.userDisabledMessage,
            ),
          ),
        'wrong-password' => LoginResponse(
            userObject: null,
            loginSuccessful: false,
            loginError: Error(
              title: translationsService.wrongPasswordTitle,
              message: translationsService.wrongPasswordMessage,
            ),
          ),
        'too-many-requests' => LoginResponse(
            userObject: null,
            loginSuccessful: false,
            loginError: Error(
              title: translationsService.tooManyRequestsTitle,
              message: translationsService.tooManyRequestsMessage,
            ),
          ),
        'invalid-credential' => LoginResponse(
            userObject: null,
            loginSuccessful: false,
            loginError: Error(
              title: translationsService.invalidCredentialsTitle,
              message: translationsService.invalidCredentialsMessage,
            ),
          ),
        _ => LoginResponse(
            userObject: null,
            loginSuccessful: false,
            loginError: Error(
              title: translationsService.errorMessage,
              message: translationsService.errorMessage,
            ),
          ),
      };
    }
    return loginError!;
  }

  /// Log out the currently logged in user.
  /// Returns `true` if the logout was successful, `false` if it was not.
  @override
  Future<bool> logout(
    BuildContext context,
  ) async {
    try {
      await auth.signOut();
      return true;
    } on FirebaseAuthException catch (_) {
      return false;
    }
  }

  /// Request a password reset for the given email.
  /// Returns a [RequestPasswordResponse] with a boolean indicating
  /// whether the request was successful. If the request was not
  /// successful, the response will contain an [Error] object with
  /// the error title and message.
  @override
  Future<RequestPasswordResponse> requestChangePassword(
    String email,
    BuildContext context,
  ) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return const RequestPasswordResponse(requestSuccesfull: true);
    } on FirebaseAuthException catch (e) {
      requestPasswordError = switch (e.code) {
        'invalid-email' => RequestPasswordResponse(
            requestSuccesfull: false,
            requestPasswordError: Error(
              title: translationsService.changePasswordInvalidEmailTitle,
              message: translationsService.changePasswordInvalidEmailMessage,
            ),
          ),
        'user-not-found' => RequestPasswordResponse(
            requestSuccesfull: false,
            requestPasswordError: Error(
              title: translationsService.changePasswordUserNotFoundTitle,
              message: translationsService.changePasswordUserNotFoundMessage,
            ),
          ),
        _ => RequestPasswordResponse(
            requestSuccesfull: false,
            requestPasswordError: Error(
              title: translationsService.changePasswordErrorTitle,
              message: translationsService.changePasswordErrorMessage,
            ),
          ),
      };
      return requestPasswordError!;
    }
  }
}
