import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/components/button/foundry_button.dart';
import 'package:foundry_ds/src/theme/theme.dart';

void main() {
  group('FoundryButton', () {
    Widget buildTestWidget(Widget child) {
      return FoundryTheme(
        data: FoundryLightTheme(),
        child: MaterialApp(home: Scaffold(body: child)),
      );
    }

    testWidgets('renders child correctly', (tester) async {
      await tester.pumpWidget(buildTestWidget(FoundryButton(onPressed: null, child: const Text('Click Me'))));

      expect(find.text('Click Me'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildTestWidget(FoundryButton(onPressed: () => tapped = true, child: const Text('Tap'))));

      await tester.tap(find.byType(FoundryButton));
      expect(tapped, isTrue);
    });

    testWidgets('does not call onPressed when disabled', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        buildTestWidget(FoundryButton(onPressed: () => tapped = true, isDisabled: true, child: const Text('Tap'))),
      );

      await tester.tap(find.byType(FoundryButton));
      expect(tapped, isFalse);
    });

    testWidgets('shows loading indicator when isLoading is true', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(FoundryButton(onPressed: null, isLoading: true, child: const Text('Loading'))),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    group('icon-only button', () {
      testWidgets('renders icon without text', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(FoundryButton.icon(onPressed: () {}, tooltip: 'Add item', child: const Icon(Icons.add))),
        );

        expect(find.byIcon(Icons.add), findsOneWidget);
        expect(find.byType(Text), findsNothing);
      });

      testWidgets('wraps icon-only button with tooltip', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(FoundryButton.icon(onPressed: () {}, tooltip: 'Add item', child: const Icon(Icons.add))),
        );

        expect(find.byType(Tooltip), findsOneWidget);
      });

      testWidgets('icon button defaults to ghost variant', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(FoundryButton.icon(onPressed: () {}, tooltip: 'Close', child: const Icon(Icons.close))),
        );

        final button = tester.widget<FoundryButton>(find.byType(FoundryButton));
        expect(button.variant, equals(FoundryButtonVariant.ghost));
      });
    });

    group('expanded button', () {
      testWidgets('expands to fill available width when expanded is true', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            SizedBox(width: 300, child: FoundryButton(onPressed: null, expanded: true, child: const Text('Expanded'))),
          ),
        );

        final row = tester.widget<Row>(find.byType(Row));
        expect(row.mainAxisSize, MainAxisSize.max);
      });

      testWidgets('uses intrinsic width when expanded is false', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(FoundryButton(onPressed: null, expanded: false, child: const Text('Default'))),
        );

        final row = tester.widget<Row>(find.byType(Row));
        expect(row.mainAxisSize, MainAxisSize.min);
      });
    });

    group('accessibility', () {
      testWidgets('wraps button with Semantics widget', (tester) async {
        await tester.pumpWidget(buildTestWidget(FoundryButton(onPressed: () {}, child: const Text('Submit'))));

        expect(find.byType(Semantics), findsWidgets);
      });

      testWidgets('supports custom semanticLabel', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(FoundryButton(onPressed: () {}, semanticLabel: 'Confirm action', child: const Text('OK'))),
        );

        expect(
          find.byWidgetPredicate((widget) => widget is Semantics && widget.properties.label == 'Confirm action'),
          findsOneWidget,
        );
      });

      testWidgets('includes button property in Semantics', (tester) async {
        await tester.pumpWidget(buildTestWidget(FoundryButton(onPressed: () {}, child: const Text('Test'))));

        expect(
          find.byWidgetPredicate((widget) => widget is Semantics && widget.properties.button == true),
          findsOneWidget,
        );
      });
    });

    group('variants', () {
      testWidgets('renders all variants correctly', (tester) async {
        for (final variant in FoundryButtonVariant.values) {
          await tester.pumpWidget(
            buildTestWidget(FoundryButton(onPressed: () {}, variant: variant, child: Text(variant.name))),
          );

          expect(find.text(variant.name), findsOneWidget);
        }
      });
    });

    group('sizes', () {
      testWidgets('renders all sizes correctly', (tester) async {
        for (final size in FoundryButtonSize.values) {
          await tester.pumpWidget(buildTestWidget(FoundryButton(onPressed: () {}, size: size, child: Text(size.name))));

          expect(find.text(size.name), findsOneWidget);
        }
      });
    });

    group('prefixIcon with child', () {
      testWidgets('renders both prefixIcon and child', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            FoundryButton(onPressed: () {}, prefixIcon: const Icon(Icons.add), child: const Text('Add Item')),
          ),
        );

        expect(find.byIcon(Icons.add), findsOneWidget);
        expect(find.text('Add Item'), findsOneWidget);
      });
    });
  });
}
