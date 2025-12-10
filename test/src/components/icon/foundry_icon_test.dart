import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/components/icon/foundry_icon.dart';
import 'package:foundry_ds/src/foundations/icon_size.dart';
import 'package:foundry_ds/src/theme/theme.dart';

void main() {
  group('FoundryIcon', () {
    Widget buildTestWidget(Widget child) {
      return FoundryTheme(
        data: FoundryLightTheme(),
        child: MaterialApp(home: Scaffold(body: child)),
      );
    }

    testWidgets('renders icon correctly', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryIcon(Icons.star)));

      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('defaults to md size', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryIcon(Icons.star)));

      final foundryIcon = tester.widget<FoundryIcon>(find.byType(FoundryIcon));
      expect(foundryIcon.size, FoundryIconSize.md);

      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.size, FIconSize.md);
    });

    group('size variants', () {
      testWidgets('xs constructor creates xs size', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryIcon.xs(Icons.star)));

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.size, FIconSize.xs);
      });

      testWidgets('sm constructor creates sm size', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryIcon.sm(Icons.star)));

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.size, FIconSize.sm);
      });

      testWidgets('lg constructor creates lg size', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryIcon.lg(Icons.star)));

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.size, FIconSize.lg);
      });

      testWidgets('xl constructor creates xl size', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryIcon.xl(Icons.star)));

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.size, FIconSize.xl);
      });

      testWidgets('xxl constructor creates xxl size', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryIcon.xxl(Icons.star)));

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.size, FIconSize.xxl);
      });
    });

    testWidgets('applies custom color', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryIcon(Icons.star, color: Colors.red)));

      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.color, Colors.red);
    });
  });
}
