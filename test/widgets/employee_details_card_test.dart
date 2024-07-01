import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mower_control_app/widgets/employee_details_card.dart';

void main() {
  group('EmployeeDetails Widget Tests', () {
    testWidgets('renders correctly with all details', (WidgetTester tester) async {
      // Arrange
      const name = 'John';
      const surname1 = 'Doe';
      const surname2 = 'Smith';
      const username = 'john.doe';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmployeeDetails(
              name: name,
              surname1: surname1,
              surname2: surname2,
              username: username,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Empleado'), findsOneWidget);
      expect(find.text('Nombre y apellidos: John Doe Smith'), findsOneWidget);
      expect(find.text('Usuario: john.doe'), findsOneWidget);
    });

    testWidgets('renders correctly without second surname', (WidgetTester tester) async {
      // Arrange
      const name = 'Jane';
      const surname1 = 'Doe';
      const surname2 = null;
      const username = 'jane.doe';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmployeeDetails(
              name: name,
              surname1: surname1,
              surname2: surname2,
              username: username,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Empleado'), findsOneWidget);
      expect(find.text('Nombre y apellidos: Jane Doe '), findsOneWidget);
      expect(find.text('Usuario: jane.doe'), findsOneWidget);
    });
  });
}
