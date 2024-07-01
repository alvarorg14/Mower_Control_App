import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mower_control_app/models/incidence.dart';
import 'package:mower_control_app/widgets/incidence_card.dart';
import 'package:mower_control_app/models/client.dart';
import 'package:mower_control_app/models/model.dart';
import 'package:mower_control_app/models/mower.dart';
import 'package:mower_control_app/models/employee.dart';

void main() {
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
      companyId: '67890');

  final mockIncidence = Incidence(
    id: '1',
    code: 12,
    message: 'Test Incidence',
    date: DateTime(2024, 6, 30, 12, 0),
    mower: testMower,
    readed: false,
  );

  void mockShowSnackbar(BuildContext context, Incidence incidence) {}

  testWidgets('IncidenceCard displays the correct content', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: IncidenceCard(
              incidence: mockIncidence,
              showSnackbar: mockShowSnackbar,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Test Incidence'), findsOneWidget);

    final formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(mockIncidence.date);
    expect(find.text(formattedDate), findsOneWidget);

    expect(find.text('Test Mower'), findsOneWidget);
  });
}
