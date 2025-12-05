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

        // Tooltip should be in the widget tree
        expect(find.byType(Tooltip), findsOneWidget);
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

        // Verify Semantics widget is in the tree
        expect(find.byType(Semantics), findsWidgets);
      });

      testWidgets('supports custom semanticLabel', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(FoundryButton(onPressed: () {}, label: 'OK', semanticLabel: 'Confirm action')),
        );

        // Find the Semantics widget with our custom label
        expect(
          find.byWidgetPredicate((widget) => widget is Semantics && widget.properties.label == 'Confirm action'),
          findsOneWidget,
        );
      });

      testWidgets('includes button property in Semantics', (tester) async {
        await tester.pumpWidget(buildTestWidget(FoundryButton(onPressed: () {}, label: 'Test')));

        // Find Semantics with button property
        expect(
          find.byWidgetPredicate((widget) => widget is Semantics && widget.properties.button == true),
          findsOneWidget,
        );
      });
    });

    group('variants', () {
      testWidgets('renders primary variant', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(FoundryButton(onPressed: () {}, label: 'Primary', variant: FoundryButtonVariant.primary)),
        );

        expect(find.text('Primary'), findsOneWidget);
      });

      testWidgets('renders secondary variant', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(FoundryButton(onPressed: () {}, label: 'Secondary', variant: FoundryButtonVariant.secondary)),
        );

        expect(find.text('Secondary'), findsOneWidget);
      });

      testWidgets('renders outline variant', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(FoundryButton(onPressed: () {}, label: 'Outline', variant: FoundryButtonVariant.outline)),
        );

        expect(find.text('Outline'), findsOneWidget);
      });

      testWidgets('renders ghost variant', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(FoundryButton(onPressed: () {}, label: 'Ghost', variant: FoundryButtonVariant.ghost)),
        );

        expect(find.text('Ghost'), findsOneWidget);
      });

      testWidgets('renders destructive variant', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(FoundryButton(onPressed: () {}, label: 'Delete', variant: FoundryButtonVariant.destructive)),
        );

        expect(find.text('Delete'), findsOneWidget);
      });
    });

    group('sizes', () {
      testWidgets('renders small size', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(FoundryButton(onPressed: () {}, label: 'Small', size: FoundryButtonSize.small)),
        );

        expect(find.text('Small'), findsOneWidget);
      });

      testWidgets('renders medium size', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(FoundryButton(onPressed: () {}, label: 'Medium', size: FoundryButtonSize.medium)),
        );

        expect(find.text('Medium'), findsOneWidget);
      });

      testWidgets('renders large size', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(FoundryButton(onPressed: () {}, label: 'Large', size: FoundryButtonSize.large)),
        );

        expect(find.text('Large'), findsOneWidget);
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
