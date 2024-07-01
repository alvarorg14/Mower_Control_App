import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mower_control_app/widgets/remote_control_card.dart';

void main() {
  testWidgets('RemoteControl widget displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: RemoteControl(mowerId: 'test_mower_id'),
          ),
        ),
      ),
    );

    expect(find.text('Control remoto'), findsOneWidget);
    expect(find.text('Aparcar'), findsOneWidget);
    expect(find.text('Pausar'), findsOneWidget);
    expect(find.text('Segar'), findsOneWidget);
    expect(find.byIcon(Icons.stop), findsOneWidget);
    expect(find.byIcon(Icons.pause), findsOneWidget);
    expect(find.byIcon(Icons.play_arrow), findsOneWidget);
  });
}
