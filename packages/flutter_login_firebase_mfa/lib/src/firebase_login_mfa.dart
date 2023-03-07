// SPDX-FileCopyrightText: 2023 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_login_interface/flutter_login_interface.dart';

class FirebaseMFALogin extends LoginInterface<User> {
  final FirebaseApp app;

  FirebaseMFALogin(this.app);

  @override
  Future<LoginResponse<User>> loginWithEmailAndPassword(
      EmailPasswordLogin login,
      {Function(dynamic resolver)? onMFA}) async {
    var auth = FirebaseAuth.instanceFor(app: app);
    try {
      var credential = await auth.signInWithEmailAndPassword(
        email: login.email,
        password: login.password,
      );
      return LoginResponse(
        loginSuccessful: credential.user != null,
        userObject: credential.user,
      );
    } on FirebaseAuthMultiFactorException catch (e) {
      debugPrint("MFA required implement with [onMFA]");
      onMFA?.call(e);
      return LoginResponse(loginSuccessful: false, userObject: null);
    } on FirebaseAuthException catch (_) {
      return LoginResponse(loginSuccessful: false, userObject: null);
    }
  }

  @override
  Future<bool> requestPasswordReset(String email) async {
    var auth = FirebaseAuth.instanceFor(app: app);
    try {
      await auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<User?> getLoggedInUser() {
    var auth = FirebaseAuth.instanceFor(app: app);
    return auth.authStateChanges().first;
  }

  @override
  Future<bool> logout() async {
    var auth = FirebaseAuth.instanceFor(app: app);
    try {
      await auth.signOut();
      return true;
    } catch (_) {
      return false;
    }
  }
}
