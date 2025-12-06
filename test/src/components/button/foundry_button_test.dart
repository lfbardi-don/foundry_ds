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

    testWidgets('renders label correctly', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryButton(onPressed: null, label: 'Click Me')));

      expect(find.text('Click Me'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildTestWidget(FoundryButton(onPressed: () => tapped = true, label: 'Tap')));

      await tester.tap(find.byType(FoundryButton));
      expect(tapped, isTrue);
    });

    testWidgets('does not call onPressed when disabled', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        buildTestWidget(FoundryButton(onPressed: () => tapped = true, isDisabled: true, label: 'Tap')),
      );

      await tester.tap(find.byType(FoundryButton));
      expect(tapped, isFalse);
    });

    testWidgets('shows loading indicator when isLoading is true', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryButton(onPressed: null, isLoading: true, label: 'Loading')));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    group('icon-only button', () {
      testWidgets('renders icon without label', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(FoundryButton.icon(icon: const Icon(Icons.add), onPressed: () {}, tooltip: 'Add item')),
        );

        expect(find.byIcon(Icons.add), findsOneWidget);
        expect(find.byType(Text), findsNothing);
      });

      testWidgets('wraps icon-only button with tooltip', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(FoundryButton.icon(icon: const Icon(Icons.add), onPressed: () {}, tooltip: 'Add item')),
        );

        expect(find.byType(Tooltip), findsOneWidget);
      });

      testWidgets('icon button defaults to ghost variant', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(FoundryButton.icon(icon: const Icon(Icons.close), onPressed: () {}, tooltip: 'Close')),
        );

        final button = tester.widget<FoundryButton>(find.byType(FoundryButton));
        expect(button.variant, equals(FoundryButtonVariant.ghost));
      });
    });

    group('expanded button', () {
      testWidgets('expands to fill available width when expanded is true', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            const SizedBox(width: 300, child: FoundryButton(onPressed: null, label: 'Expanded', expanded: true)),
          ),
        );

        final row = tester.widget<Row>(find.byType(Row));
        expect(row.mainAxisSize, MainAxisSize.max);
      });

      testWidgets('uses intrinsic width when expanded is false', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(const FoundryButton(onPressed: null, label: 'Default', expanded: false)),
        );

        final row = tester.widget<Row>(find.byType(Row));
        expect(row.mainAxisSize, MainAxisSize.min);
      });
    });

    group('onLongPress', () {
      testWidgets('calls onLongPress when long pressed', (tester) async {
        var longPressed = false;
        await tester.pumpWidget(
          buildTestWidget(
            FoundryButton(onPressed: () {}, onLongPress: () => longPressed = true, label: 'Long Press Me'),
          ),
        );

        await tester.longPress(find.byType(FoundryButton));
        expect(longPressed, isTrue);
      });

      testWidgets('does not call onLongPress when disabled', (tester) async {
        var longPressed = false;
        await tester.pumpWidget(
          buildTestWidget(
            FoundryButton(
              onPressed: () {},
              onLongPress: () => longPressed = true,
              isDisabled: true,
              label: 'Long Press Me',
            ),
          ),
        );

        await tester.longPress(find.byType(FoundryButton));
        expect(longPressed, isFalse);
      });
    });

    group('accessibility', () {
      testWidgets('wraps button with Semantics widget', (tester) async {
        await tester.pumpWidget(buildTestWidget(FoundryButton(onPressed: () {}, label: 'Submit')));

        expect(find.byType(Semantics), findsWidgets);
      });

      testWidgets('supports custom semanticLabel', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(FoundryButton(onPressed: () {}, label: 'OK', semanticLabel: 'Confirm action')),
        );

        expect(
          find.byWidgetPredicate((widget) => widget is Semantics && widget.properties.label == 'Confirm action'),
          findsOneWidget,
        );
      });

      testWidgets('includes button property in Semantics', (tester) async {
        await tester.pumpWidget(buildTestWidget(FoundryButton(onPressed: () {}, label: 'Test')));

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
            buildTestWidget(FoundryButton(onPressed: () {}, label: variant.name, variant: variant)),
          );

          expect(find.text(variant.name), findsOneWidget);
        }
      });
    });

    group('sizes', () {
      testWidgets('renders all sizes correctly', (tester) async {
        for (final size in FoundryButtonSize.values) {
          await tester.pumpWidget(buildTestWidget(FoundryButton(onPressed: () {}, label: size.name, size: size)));

          expect(find.text(size.name), findsOneWidget);
        }
      });
    });

    group('icon with label', () {
      testWidgets('renders both icon and label', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(FoundryButton(onPressed: () {}, label: 'Add Item', icon: const Icon(Icons.add))),
        );

        expect(find.byIcon(Icons.add), findsOneWidget);
        expect(find.text('Add Item'), findsOneWidget);
      });
    });
  });
}
