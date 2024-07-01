import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mower_control_app/widgets/battery.dart';

void main() {
  testWidgets('Battery widget test', (WidgetTester tester) async {
    // Arrange
    const batteryLevel = 75;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Battery(
            battery: batteryLevel,
          ),
        ),
      ),
    );

    // Assert
    expect(find.text('$batteryLevel %'), findsOneWidget);
  });
}
