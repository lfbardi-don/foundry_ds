import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/components/input/foundry_input.dart';
import 'package:foundry_ds/src/theme/theme.dart';

void main() {
  group('FoundryInput', () {
    testWidgets('renders initial text', (tester) async {
      final controller = TextEditingController(text: 'Hello');
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: MaterialApp(
              home: Scaffold(
                body: Center(child: FoundryInput(controller: controller)),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('updates text on change', (tester) async {
      String? value;
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: MaterialApp(
              home: Scaffold(
                body: Center(
                  child: FoundryInput(onChanged: (v) => value = v, placeholder: 'Type here'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Foundry');
      await tester.pump();
      expect(value, 'Foundry');
    });
  });
}
