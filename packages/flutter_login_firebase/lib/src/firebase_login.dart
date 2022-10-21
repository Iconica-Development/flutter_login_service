import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_login_interface/flutter_login_interface.dart';

class FirebaseLogin extends LoginInterface<User> {
  final FirebaseApp app;

  FirebaseLogin(this.app);

  @override
  Future<LoginResponse<User>> loginWithEmailAndPassword(
      EmailPasswordLogin login) async {
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
