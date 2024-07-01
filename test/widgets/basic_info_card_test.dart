import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mower_control_app/widgets/basic_info_card.dart';

void main() {
  testWidgets('BasicInfoCard test', (WidgetTester tester) async {
    const mowerName = 'Test Mower';
    const serialNumber = 123456;
    const modelName = '430';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BasicInformation(
            mowerName: mowerName,
            serialNumber: serialNumber,
            modelName: modelName,
          ),
        ),
      ),
    );

    expect(find.text('Datos básicos'), findsOneWidget);
    expect(find.text('Nombre: $mowerName'), findsOneWidget);
    expect(find.text('Número de serie: $serialNumber'), findsOneWidget);
    expect(find.text('Modelo: $modelName'), findsOneWidget);
  });
}
