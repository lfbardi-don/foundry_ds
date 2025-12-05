import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/components/button/foundry_button.dart';
import 'package:foundry_ds/src/theme/theme.dart';

void main() {
  group('FoundryButton', () {
    testWidgets('renders label correctly', (tester) async {
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: const Directionality(
            textDirection: TextDirection.ltr,
            child: FoundryButton(onPressed: null, label: 'Click Me'),
          ),
        ),
      );

      expect(find.text('Click Me'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: FoundryButton(onPressed: () => tapped = true, label: 'Tap'),
          ),
        ),
      );

      await tester.tap(find.byType(FoundryButton));
      expect(tapped, isTrue);
    });

    testWidgets('does not call onPressed when disabled', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: FoundryButton(onPressed: () => tapped = true, isDisabled: true, label: 'Tap'),
          ),
        ),
      );

      await tester.tap(find.byType(FoundryButton));
      expect(tapped, isFalse);
    });

    testWidgets('shows loading indicator when isLoading is true', (tester) async {
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: const Directionality(
            textDirection: TextDirection.ltr,
            child: FoundryButton(onPressed: null, isLoading: true, label: 'Loading'),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
