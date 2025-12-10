import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/components/switch/foundry_switch.dart';
import 'package:foundry_ds/src/theme/theme.dart';

void main() {
  group('FoundrySwitch', () {
    testWidgets('toggles state on tap', (tester) async {
      bool value = false;
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: StatefulBuilder(
              builder: (context, setState) {
                return FoundrySwitch(value: value, onChanged: (v) => setState(() => value = v), label: 'Toggle Me');
              },
            ),
          ),
        ),
      );

      expect(find.byType(FoundrySwitch), findsOneWidget);

      // Verify Semantics
      expect(
        tester.getSemantics(find.byType(FoundrySwitch)),
        matchesSemantics(
          label: 'Toggle Me',
          isToggled: false,
          hasEnabledState: true,
          isEnabled: true,
          hasTapAction: true,
          hasToggledState: true,
          isFocusable: true,
          hasFocusAction: true,
        ),
      );

      await tester.tap(find.byType(FoundrySwitch));
      await tester.pumpAndSettle();

      expect(value, true);
    });

    testWidgets('disabled switch does not toggle', (tester) async {
      bool value = false;
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: FoundrySwitch(value: value, onChanged: (v) => value = v, isDisabled: true),
          ),
        ),
      );

      await tester.tap(find.byType(FoundrySwitch));
      expect(value, false);
    });
  });
}
