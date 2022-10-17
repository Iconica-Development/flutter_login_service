import 'package:flutter_login_interface/flutter_login_interface.dart';

class LoginDefaultDataProvider extends LoginInterface<String> {
  LoginDefaultDataProvider();

  @override
  Future<LoginResponse<String>> loginWithEmailAndPassword(
      EmailPasswordLogin login) async {
    return LoginResponse(
      loginSuccessful: true,
      userObject: 'test',
    );
  }

  @override
  Future<bool> requestPasswordReset(String email) async {
    return true;
  }
}
