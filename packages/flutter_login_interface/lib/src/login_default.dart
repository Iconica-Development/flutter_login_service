import 'package:flutter_login_interface/flutter_login_interface.dart';

class LoginDefaultDataProvider extends LoginInterface {
  LoginDefaultDataProvider();

  @override
  T add<T extends num>(T a, T b) {
    return (a + b) as T;
  }
}
