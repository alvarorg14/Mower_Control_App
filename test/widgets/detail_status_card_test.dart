import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mower_control_app/widgets/detail_status_card.dart';

void main() {
  group('MowerDetailStatus', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MowerDetailStatus(
              battery: 80,
              mode: 'MAIN_AREA',
              activity: 'MOWING',
              state: 'PAUSED',
              modelName: '415X',
            ),
          ),
        ),
      );

      expect(find.text('Estado actual'), findsOneWidget);
      expect(find.text('Bateria: 80 %'), findsOneWidget);
      expect(find.text('Modo: Area principal'), findsOneWidget);
      expect(find.text('Acitvidad: Segando'), findsOneWidget);
      expect(find.text('Estado: Pausado'), findsOneWidget);
    });
  });
}
