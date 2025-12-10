import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/components/card/foundry_card.dart';
import 'package:foundry_ds/src/theme/theme.dart';

void main() {
  group('FoundryCard', () {
    Widget buildTestWidget(Widget child) {
      return FoundryTheme(
        data: FoundryLightTheme(),
        child: MaterialApp(home: Scaffold(body: child)),
      );
    }

    testWidgets('renders child correctly', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryCard(child: Text('Card Content'))));

      expect(find.text('Card Content'), findsOneWidget);
    });

    testWidgets('defaults to elevated variant', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryCard(child: Text('Test'))));

      final card = tester.widget<FoundryCard>(find.byType(FoundryCard));
      expect(card.variant, FoundryCardVariant.elevated);
    });

    group('variants', () {
      testWidgets('renders all variants correctly', (tester) async {
        for (final variant in FoundryCardVariant.values) {
          await tester.pumpWidget(buildTestWidget(FoundryCard(variant: variant, child: Text(variant.name))));
          expect(find.text(variant.name), findsOneWidget);
        }
      });
    });

    testWidgets('applies custom padding', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryCard(padding: EdgeInsets.all(32), child: Text('Padded'))));

      expect(find.text('Padded'), findsOneWidget);
    });
  });
}
