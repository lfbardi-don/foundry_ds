import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/foundry_ds.dart';

void main() {
  group('FoundrySnackbar', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      FoundrySnackbar.show(context: context, message: 'Test Snackbar');
                    },
                    child: const Text('Show Snackbar'),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Snackbar'));
      await tester.pumpAndSettle();

      expect(find.text('Test Snackbar'), findsOneWidget);
    });
  });
}
