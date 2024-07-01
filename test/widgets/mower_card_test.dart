import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mower_control_app/models/mower.dart';
import 'package:mower_control_app/widgets/mower_card.dart';
import 'package:mower_control_app/models/client.dart';
import 'package:mower_control_app/models/model.dart';
import 'package:mower_control_app/models/employee.dart';

void main() {
  group('MowerCard Widget Tests', () {
    final testClient = Client(
      id: '1',
      name: 'Test Client',
      address: '123 Test St',
      phoneNumber: 987654321,
      companyId: '1',
    );

    final testEmployee = Employee(
      id: 'emp123',
      name: 'John',
      surname1: 'Doe',
      surname2: 'Smith',
      username: 'johndoe',
      password: 'password123',
      companyId: 'comp123',
    );

    final testModel = Model(modelId: '1', name: '430X');

    Mower testMower = Mower(
      id: '12345',
      serialNumber: 67890,
      name: 'Test Mower',
      battery: 100,
      mode: 'Auto',
      activity: 'Mowing',
      state: 'Active',
      errorCode: 0,
      errorCodeTimestamp: 1625140800,
      assigned: true,
      model: testModel,
      client: testClient,
      employee: testEmployee,
      companyId: '67890',
    );

    testWidgets('MowerCard displays correct information', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MowerCard(mower: testMower),
          ),
        ),
      );

      expect(find.text('Test Client'), findsOneWidget);
      expect(find.text('Test Mower'), findsOneWidget);
      expect(find.text('430X - 67890'), findsOneWidget);
    });
  });
}
