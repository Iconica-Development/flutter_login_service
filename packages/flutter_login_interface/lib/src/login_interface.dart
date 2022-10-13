import 'package:flutter_data_interface/flutter_data_interface.dart';
import 'package:flutter_login_interface/src/login_default.dart';

abstract class LoginInterface extends DataInterface {
  LoginInterface() : super(token: _token);

  static final Object _token = Object();

  static LoginInterface _instance = LoginDefaultDataProvider();

  static LoginInterface get instance => _instance;

  static set instance(LoginInterface instance) {
    DataInterface.verify(instance, _token);
    _instance = instance;
  }

  // define your interface methods here
  T add<T extends num>(T a, T b);
}
