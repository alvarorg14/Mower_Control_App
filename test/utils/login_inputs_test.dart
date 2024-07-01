import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mower_control_app/utils/login_inputs.dart';

void main() {
  group('LoginInputs', () {
    testWidgets('should return a list of two TextFormFields with correct properties', (WidgetTester tester) async {
      final loginInputs = LoginInputs();
      String? username;
      String? password;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return Column(
                  children: loginInputs.getLoginInputs(
                    context,
                    (value) => username = value,
                    (value) => password = value,
                  ),
                );
              },
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsNWidgets(2));

      final usernameFieldFinder = find.widgetWithText(TextFormField, 'Username');
      final usernameField = tester.widget<TextFormField>(usernameFieldFinder);
      expect(usernameField.validator!(''), 'Please enter a valid username');
      expect(usernameField.validator!('testUser'), null);

      final passwordFieldFinder = find.widgetWithText(TextFormField, 'Password');
      expect(passwordFieldFinder, findsOneWidget);
      final passwordField = tester.widget<TextFormField>(passwordFieldFinder);
      expect(passwordField.validator!(''), 'Please enter a valid password');
      expect(passwordField.validator!('testPass'), null);

      await tester.enterText(usernameFieldFinder, 'testUser');
      await tester.enterText(passwordFieldFinder, 'testPass');
      usernameField.onSaved!('testUser');
      passwordField.onSaved!('testPass');

      expect(username, 'testUser');
      expect(password, 'testPass');
    });
  });
}
