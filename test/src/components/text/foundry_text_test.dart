import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/components/text/foundry_text.dart';
import 'package:foundry_ds/src/theme/theme.dart';

void main() {
  group('FoundryText', () {
    Widget buildTestWidget(Widget child) {
      return FoundryTheme(
        data: FoundryLightTheme(),
        child: MaterialApp(home: Scaffold(body: child)),
      );
    }

    testWidgets('renders text content', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryText('Hello World')));

      expect(find.text('Hello World'), findsOneWidget);
    });

    testWidgets('defaults to body variant', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryText('Test')));

      final foundryText = tester.widget<FoundryText>(find.byType(FoundryText));
      expect(foundryText.variant, FoundryTextVariant.body);
    });

    group('variant constructors', () {
      testWidgets('displayLarge constructor', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryText.displayLarge('Display Large')));

        final foundryText = tester.widget<FoundryText>(find.byType(FoundryText));
        expect(foundryText.variant, FoundryTextVariant.displayLarge);
      });

      testWidgets('display constructor', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryText.display('Display')));

        final foundryText = tester.widget<FoundryText>(find.byType(FoundryText));
        expect(foundryText.variant, FoundryTextVariant.display);
      });

      testWidgets('headingLarge constructor', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryText.headingLarge('Heading Large')));

        final foundryText = tester.widget<FoundryText>(find.byType(FoundryText));
        expect(foundryText.variant, FoundryTextVariant.headingLarge);
      });

      testWidgets('heading constructor', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryText.heading('Heading')));

        final foundryText = tester.widget<FoundryText>(find.byType(FoundryText));
        expect(foundryText.variant, FoundryTextVariant.heading);
      });

      testWidgets('headingSmall constructor', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryText.headingSmall('Heading Small')));

        final foundryText = tester.widget<FoundryText>(find.byType(FoundryText));
        expect(foundryText.variant, FoundryTextVariant.headingSmall);
      });

      testWidgets('subheading constructor', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryText.subheading('Subheading')));

        final foundryText = tester.widget<FoundryText>(find.byType(FoundryText));
        expect(foundryText.variant, FoundryTextVariant.subheading);
      });

      testWidgets('body constructor', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryText.body('Body')));

        final foundryText = tester.widget<FoundryText>(find.byType(FoundryText));
        expect(foundryText.variant, FoundryTextVariant.body);
      });

      testWidgets('bodySmall constructor', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryText.bodySmall('Body Small')));

        final foundryText = tester.widget<FoundryText>(find.byType(FoundryText));
        expect(foundryText.variant, FoundryTextVariant.bodySmall);
      });

      testWidgets('caption constructor', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryText.caption('Caption')));

        final foundryText = tester.widget<FoundryText>(find.byType(FoundryText));
        expect(foundryText.variant, FoundryTextVariant.caption);
      });
    });

    testWidgets('applies custom color', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryText('Colored', color: Colors.red)));

      final text = tester.widget<Text>(find.byType(Text));
      expect(text.style?.color, Colors.red);
    });

    testWidgets('applies mono font when isMono is true', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryText('Mono', isMono: true)));

      final foundryText = tester.widget<FoundryText>(find.byType(FoundryText));
      expect(foundryText.isMono, true);
    });

    testWidgets('applies text alignment', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryText('Centered', textAlign: TextAlign.center)));

      final text = tester.widget<Text>(find.byType(Text));
      expect(text.textAlign, TextAlign.center);
    });

    testWidgets('applies maxLines and overflow', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const FoundryText('Long text that should be truncated', maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
      );

      final text = tester.widget<Text>(find.byType(Text));
      expect(text.maxLines, 1);
      expect(text.overflow, TextOverflow.ellipsis);
    });
  });
}
