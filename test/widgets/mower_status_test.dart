import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mower_control_app/utils/status.dart';
import 'package:mower_control_app/widgets/mower_status.dart';
import 'package:mower_control_app/models/client.dart';
import 'package:mower_control_app/models/model.dart';
import 'package:mower_control_app/models/mower.dart';
import 'package:mower_control_app/models/employee.dart';

void main() {
  group('MowerStatus Widget Tests', () {
    final statusUtils = StatusUtils();

    testWidgets('displays correct image and text based on mower status', (WidgetTester tester) async {
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
          mode: 'MAIN_AREA',
          activity: 'MOWING',
          state: 'STOPPED',
          errorCode: 0,
          errorCodeTimestamp: 1625140800,
          assigned: true,
          model: testModel,
          client: testClient,
          employee: testEmployee,
          companyId: '67890');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MowerStatus(mower: testMower),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
      expect(find.image(AssetImage('assets/images/430X.png')), findsOneWidget);

      expect(
        find.text(statusUtils.getTextForActivityAndState(testMower.activity, testMower.state).toUpperCase()),
        findsOneWidget,
      );
    });
  });
}
