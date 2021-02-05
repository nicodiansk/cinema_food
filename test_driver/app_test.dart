// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Cinema Food', () {
    //login screen
    final emailField = find.byValueKey('s_email');
    final passwordField = find.byValueKey('s_password');
    final signInButton = find.byValueKey('s_button');
    final createAccountButton = find.byValueKey('s_button_reg');

    //register
    final nameFieldr = find.byValueKey('r_name');
    final emailFieldr = find.byValueKey('r_email');
    final passwordFieldr1 = find.byValueKey('r_password1');
    final passwordFieldr2 = find.byValueKey('r_password2');
    final registerInButton = find.byValueKey('r_button');
    final createAccountButtonr = find.byValueKey('r_button_signin');
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    /*test('create account', () async {
      await driver.tap(createAccountButton);

      await driver.tap(nameFieldr);
      await driver.enterText("nicholas");

      await driver.tap(emailFieldr);
      await driver.enterText("nick0@gmail.com");

      await driver.tap(passwordFieldr1);
      await driver.enterText("123456");

      await driver.tap(passwordFieldr2);
      await driver.enterText("123456");

      await driver.tap(registerInButton);
      await driver.waitFor(find.text("Tutti"));
    });*/

    /*test('create account wrong', () async {
      await driver.tap(createAccountButton);

      await driver.tap(nameFieldr);
      await driver.enterText("nicholas");

      await driver.tap(emailFieldr);
      await driver.enterText("nick@gmail");

      await driver.tap(passwordFieldr1);
      await driver.enterText("123456");

      await driver.tap(passwordFieldr2);
      await driver.enterText("123456");

      await driver.tap(registerInButton);
      await driver.waitFor(find.text("NOME COMPLETO"));
    });*/

    test('login', () async {
      await driver.tap(emailField);
      await driver.enterText("nick@gmail.com");

      await driver.tap(passwordField);
      await driver.enterText("123456");

      await driver.tap(signInButton);
      await driver.waitFor(find.text("Tutti"));
    });
  });
}
