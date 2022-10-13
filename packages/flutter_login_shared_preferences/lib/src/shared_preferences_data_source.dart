import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_login_interface/flutter_login_interface.dart';

class LoginSharedPreferencesDataProvider extends LoginInterface {
  LoginSharedPreferencesDataProvider();

  SharedPreferences? _instance;

  Future<SharedPreferences>? _prefGetter;

  SharedPreferences? get _prefs {
    if (_instance == null) {
      (_prefGetter ??= SharedPreferences.getInstance())
          .then((value) => _instance = value);
    }
    return _instance;
  }

  @override
  T add<T extends num>(T a, T b) {
    var cached = _prefs?.getDouble('${a.toDouble()}+${b.toDouble()}');
    if (cached != null) {
      return cached as T;
    }
    var result = a + b;
    _prefs?.setDouble('${a.toDouble()}+${b.toDouble()}', result.toDouble());
    return result as T;
  }
}
