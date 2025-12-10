import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/components/tooltip/foundry_tooltip.dart';
import 'package:foundry_ds/src/theme/theme.dart';

void main() {
  group('FoundryTooltip', () {
    testWidgets('shows overlay on long press', (tester) async {
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: Directionality(
            // Removed const
            textDirection: TextDirection.ltr,
            child: Overlay(
              initialEntries: [
                OverlayEntry(
                  builder: (context) => const Center(
                    child: FoundryTooltip(message: 'Tooltip Message', child: Text('Hold Me')),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // Verify tooltip is not visible initially
      expect(find.text('Tooltip Message'), findsNothing);

      // Long press to show tooltip
      await tester.longPress(find.text('Hold Me'));
      await tester.pump(); // Start animation
      await tester.pump(const Duration(milliseconds: 200)); // Finish animation

      expect(find.text('Tooltip Message'), findsOneWidget);
    });

    testWidgets('hides after duration', (tester) async {
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: Directionality(
            // Removed const
            textDirection: TextDirection.ltr,
            child: Overlay(
              initialEntries: [
                OverlayEntry(
                  builder: (context) => const Center(
                    child: FoundryTooltip(
                      message: 'Tooltip Message',
                      showDuration: Duration(milliseconds: 500),
                      child: Text('Hold Me'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.longPress(find.text('Hold Me'));
      await tester.pumpAndSettle();

      expect(find.text('Tooltip Message'), findsOneWidget);

      // Wait for duration
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();

      expect(find.text('Tooltip Message'), findsNothing);
    });
  });
}
