import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/foundry_ds.dart';

void main() {
  group('FoundryAlert', () {
    testWidgets('renders correctly in unbounded height constraints', (tester) async {
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [FoundryAlert(title: 'Layout Test', description: 'Testing layout robustness')],
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Layout Test'), findsOneWidget);
    });
  });
}
