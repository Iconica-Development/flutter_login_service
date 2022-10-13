import 'package:flutter_login_interface/flutter_login_interface.dart';

/// A Calculator.
class LoginService {
  LoginService([LoginInterface? source])
      : dataSource = source ?? LoginInterface.instance;

  LoginInterface dataSource;

  /// Returns [value] plus 1.
  int addOne(int value) => dataSource.add<int>(value, 1);
}
