import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/components/divider/foundry_divider.dart';
import 'package:foundry_ds/src/theme/theme.dart';

void main() {
  group('FoundryDivider', () {
    Widget buildTestWidget(Widget child) {
      return FoundryTheme(
        data: FoundryLightTheme(),
        child: MaterialApp(home: Scaffold(body: child)),
      );
    }

    testWidgets('renders horizontal divider', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryDivider.horizontal()));

      expect(find.byType(FoundryDivider), findsOneWidget);
    });

    testWidgets('renders vertical divider', (tester) async {
      await tester.pumpWidget(buildTestWidget(const SizedBox(height: 100, child: FoundryDivider.vertical())));

      expect(find.byType(FoundryDivider), findsOneWidget);
    });

    testWidgets('defaults to horizontal direction', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryDivider()));

      final divider = tester.widget<FoundryDivider>(find.byType(FoundryDivider));
      expect(divider.direction, Axis.horizontal);
    });

    testWidgets('defaults to solid style', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryDivider()));

      final divider = tester.widget<FoundryDivider>(find.byType(FoundryDivider));
      expect(divider.style, FoundryDividerStyle.solid);
    });

    group('styles', () {
      testWidgets('renders fade style', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryDivider.fade()));

        final divider = tester.widget<FoundryDivider>(find.byType(FoundryDivider));
        expect(divider.style, FoundryDividerStyle.fade);
      });

      testWidgets('renders gradient style', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            const FoundryDivider.withGradient(gradient: LinearGradient(colors: [Colors.red, Colors.blue])),
          ),
        );

        final divider = tester.widget<FoundryDivider>(find.byType(FoundryDivider));
        expect(divider.style, FoundryDividerStyle.gradient);
      });
    });

    testWidgets('applies indent and endIndent', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryDivider.horizontal(indent: 16, endIndent: 16)));

      final divider = tester.widget<FoundryDivider>(find.byType(FoundryDivider));
      expect(divider.indent, 16);
      expect(divider.endIndent, 16);
    });
  });
}
