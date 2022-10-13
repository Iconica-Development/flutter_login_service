import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_login_service/flutter_login_service.dart';

void main() {
  test('adds one to input values', () {
    final calculator = LoginService();
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
  });
}
