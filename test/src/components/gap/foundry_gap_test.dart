import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/components/gap/foundry_gap.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:gap/gap.dart';

void main() {
  group('FoundryGap', () {
    testWidgets('renders correct size for tokens', (tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Column(children: [FoundryGap.sm()]),
        ),
      );

      final gapFinder = find.byType(Gap);
      expect(gapFinder, findsOneWidget);

      final gap = tester.widget<Gap>(gapFinder);
      expect(gap.mainAxisExtent, FSpacing.sm);
    });

    testWidgets('renders correct size for md token', (tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Row(children: [FoundryGap.md()]),
        ),
      );

      final gapFinder = find.byType(Gap);
      expect(gapFinder, findsOneWidget);

      final gap = tester.widget<Gap>(gapFinder);
      expect(gap.mainAxisExtent, FSpacing.md);
    });
  });
}
