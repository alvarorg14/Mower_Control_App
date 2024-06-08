import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mower_control_app/widgets/client_details_card.dart';

void main() {
  testWidgets('ClientDetails widget test', (WidgetTester tester) async {
    // Define the test data
    const name = 'John Doe';
    const address = '123 Main St';
    const phoneNumber = 1234567890;

    // Build the ClientDetails widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ClientDetails(
            name: name,
            address: address,
            phoneNumber: phoneNumber,
          ),
        ),
      ),
    );

    // Verify the text is displayed correctly
    expect(find.text('Cliente'), findsOneWidget);
    expect(find.text('Nombre y apellidos: $name'), findsOneWidget);
    expect(find.text('Dirección: $address'), findsOneWidget);
    expect(find.text('Teléfono / Móvil: $phoneNumber'), findsOneWidget);
  });
}
