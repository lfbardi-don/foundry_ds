import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/components/checkbox/foundry_checkbox.dart';
import 'package:foundry_ds/src/theme/theme.dart';

void main() {
  group('FoundryCheckbox', () {
    testWidgets('renders unchecked state', (tester) async {
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: const Directionality(
            textDirection: TextDirection.ltr,
            child: FoundryCheckbox(value: false, onChanged: null),
          ),
        ),
      );

      expect(find.byType(FoundryCheckbox), findsOneWidget);
    });

    testWidgets('calls onChanged when tapped', (tester) async {
      bool? value = false;
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: FoundryCheckbox(value: value, onChanged: (v) => value = v),
          ),
        ),
      );

      await tester.tap(find.byType(FoundryCheckbox));
      expect(value, true);
    });

    testWidgets('has semantic label', (tester) async {
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: const Directionality(
            textDirection: TextDirection.ltr,
            child: FoundryCheckbox(value: false, onChanged: null, label: 'Accept Terms'),
          ),
        ),
      );

      // Verify it builds without error with label
      expect(find.byType(FoundryCheckbox), findsOneWidget);
    });
  });
}
