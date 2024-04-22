// SPDX-FileCopyrightText: 2023 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_service/flutter_login_service.dart';

/// A service to handle authentication with Firebase.
/// Takes an instance of [FirebaseAuth] and an
/// optional [LoginServiceTranslations]
class FirebaseMFALoginService implements LoginServiceInterface {
  FirebaseMFALoginService({
    required this.auth,
    this.translationsService = const LoginServiceTranslations.empty(),
  });

  final FirebaseAuth auth;
  final LoginServiceTranslations translationsService;

  /// The error response from the last password reset request.
  RequestPasswordResponse? requestPasswordError;

  /// The error response from the last login attempt.
  LoginResponse? loginError;

  /// Get the currently logged in user.
  @override
  Future getLoggedInUser() => auth.authStateChanges().first;

  /// Log in with email and password.
  /// Returns a [LoginResponse] with the user object if the login was
  /// successful. If the login was not successful, the response will
  /// contain an [Error] object with the error title and message.
  /// If the login attempt requires multi-factor authentication,
  /// the [onMFA] function will be called with the
  /// [FirebaseAuthMultiFactorException]. The function should
  /// resolve the MFA challenge and return a [LoginResponse].
  /// If the MFA challenge is not resolved, the login attempt
  /// will fail.
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
    } on FirebaseAuthMultiFactorException catch (e) {
      debugPrint('[onMFA] is required for this login attempt.');
      onMFA?.call(e);
      return const LoginResponse(loginSuccessful: false, userObject: null);
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
      return loginError!;
    }
  }

  /// Log out the currently logged in user.
  /// Returns `true` if the logout was successful, `false` if it was not.
  @override
  Future<bool> logout(BuildContext context) async {
    try {
      await auth.signOut();
      return true;
    } on FirebaseAuthException catch (_) {
      return false;
    }
  }

  /// Request a password reset email for the given email address.
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
