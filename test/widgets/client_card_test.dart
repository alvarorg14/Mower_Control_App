import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mower_control_app/api/mowers.dart';
import 'package:mower_control_app/api/clients.dart';
import 'package:mower_control_app/models/client.dart';
import 'package:mower_control_app/models/model.dart';
import 'package:mower_control_app/models/mower.dart';
import 'package:mower_control_app/models/employee.dart';
import 'package:mower_control_app/widgets/client_card.dart';

import 'client_card_test.mocks.dart';

@GenerateMocks([MowersApi, ClientsApi])
void main() {
  final mockMowersApi = MockMowersApi();
  final mockClientsApi = MockClientsApi();

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

  setUp(() {
    reset(mockMowersApi);
    reset(mockClientsApi);
  });

  testWidgets('ClientCard shows confirmation dialog when swiped', (WidgetTester tester) async {
    when(mockMowersApi.fetchMowersForClient(any, any)).thenAnswer((_) async => [testMower]);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: ClientCard(
              client: testClient,
              clientsApi: mockClientsApi,
              mowersApi: mockMowersApi,
            ),
          ),
        ),
      ),
    );

    await tester.drag(find.byType(ClientCard), const Offset(-500, 0));
    await tester.pumpAndSettle();
    expect(find.text('Are you sure?'), findsOneWidget);
    expect(find.text('This client has mowers assigned to it!'), findsOneWidget);
  });
}
