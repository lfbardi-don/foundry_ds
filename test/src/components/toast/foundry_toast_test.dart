import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/foundry_ds.dart';

void main() {
  group('FoundryToast', () {
    testWidgets('renders correctly in unbounded height constraints', (tester) async {
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Builder(
                      builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            FoundryToast.show(context: context, message: 'Test Toast', title: 'Layout Test');
                          },
                          child: const Text('Show Toast'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Toast'));
      await tester.pump(); // Start animation
      await tester.pump(const Duration(milliseconds: 500)); // Advance animation

      expect(find.text('Test Toast'), findsOneWidget);
    });
  });
}
