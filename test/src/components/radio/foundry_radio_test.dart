import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/components/radio/foundry_radio.dart';
import 'package:foundry_ds/src/theme/theme.dart';

void main() {
  group('FoundryRadio', () {
    testWidgets('renders correct state in group', (tester) async {
      int? groupValue = 1;

      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    FoundryRadio<int>(
                      value: 1,
                      groupValue: groupValue,
                      onChanged: (v) => setState(() => groupValue = v),
                      label: 'Option 1',
                    ),
                    FoundryRadio<int>(
                      value: 2,
                      groupValue: groupValue,
                      onChanged: (v) => setState(() => groupValue = v),
                      label: 'Option 2',
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      // Verify Semantics
      expect(
        tester.getSemantics(find.byType(FoundryRadio<int>).first),
        matchesSemantics(
          label: 'Option 1',
          isEnabled: true,
          isInMutuallyExclusiveGroup: true,
          hasTapAction: true,
          hasSelectedState: true,
          isSelected: true,
          hasEnabledState: true,
          isFocusable: true,
          hasFocusAction: true,
        ),
      );

      // Tap second option
      await tester.tap(find.bySemanticsLabel('Option 2'));
      await tester.pumpAndSettle();

      expect(groupValue, 2);
    });

    testWidgets('respects disabled state', (tester) async {
      int groupValue = 1;
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: FoundryRadio<int>(value: 2, groupValue: groupValue, onChanged: (v) {}, isDisabled: true),
          ),
        ),
      );

      await tester.tap(find.byType(FoundryRadio<int>));
      expect(groupValue, 1);
    });
  });
}
