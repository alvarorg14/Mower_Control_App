import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mower_control_app/models/mower.dart';
import 'package:mower_control_app/models/model.dart';
import 'package:mower_control_app/widgets/unassigned_mower_card.dart';

void main() {
  testWidgets('UnassignedMowerCard displays mower details', (WidgetTester tester) async {
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
        client: null,
        employee: null,
        companyId: '67890');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UnassignedMowerCard(mower: testMower),
        ),
      ),
    );

    expect(find.text('Test Mower'), findsOneWidget);
    expect(find.text('Modelo: 430X'), findsOneWidget);
    expect(find.text('Número de serie: 67890'), findsOneWidget);
  });
}
