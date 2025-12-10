import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/foundry_ds.dart';

void main() {
  group('FoundryBadge', () {
    testWidgets('renders correctly with label', (tester) async {
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: MaterialApp(
            home: Scaffold(
              body: Center(child: FoundryBadge(label: 'Test Badge')),
            ),
          ),
        ),
      );

      expect(find.text('Test Badge'), findsOneWidget);
    });

    testWidgets('renders count correctly', (tester) async {
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: MaterialApp(
            home: Scaffold(body: Center(child: FoundryBadge(count: 5))),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
    });
  });
}
