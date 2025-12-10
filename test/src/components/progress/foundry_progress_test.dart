import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/components/progress/foundry_progress.dart';
import 'package:foundry_ds/src/theme/theme.dart';

void main() {
  group('FoundryProgress', () {
    Widget buildTestWidget(Widget child) {
      return FoundryTheme(
        data: FoundryLightTheme(),
        child: MaterialApp(
          home: Scaffold(body: Center(child: child)),
        ),
      );
    }

    group('linear variant', () {
      testWidgets('renders linear progress', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryProgress.linear(value: 0.5)));

        expect(find.byType(FoundryProgress), findsOneWidget);
        final progress = tester.widget<FoundryProgress>(find.byType(FoundryProgress));
        expect(progress.variant, FoundryProgressVariant.linear);
      });

      testWidgets('renders determinate mode with value', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryProgress.linear(value: 0.75)));

        final progress = tester.widget<FoundryProgress>(find.byType(FoundryProgress));
        expect(progress.value, 0.75);
        expect(progress.isIndeterminate, false);
      });

      testWidgets('renders indeterminate mode without value', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryProgress.linear()));

        final progress = tester.widget<FoundryProgress>(find.byType(FoundryProgress));
        expect(progress.value, isNull);
        expect(progress.isIndeterminate, true);
      });
    });

    group('circular variant', () {
      testWidgets('renders circular progress', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryProgress.circular()));

        final progress = tester.widget<FoundryProgress>(find.byType(FoundryProgress));
        expect(progress.variant, FoundryProgressVariant.circular);
      });

      testWidgets('renders determinate circular with value', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryProgress.circular(value: 0.5)));

        final progress = tester.widget<FoundryProgress>(find.byType(FoundryProgress));
        expect(progress.value, 0.5);
      });

      testWidgets('applies custom size', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryProgress.circular(size: 48)));

        final progress = tester.widget<FoundryProgress>(find.byType(FoundryProgress));
        expect(progress.size, 48);
      });

      testWidgets('applies custom strokeWidth', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundryProgress.circular(strokeWidth: 4)));

        final progress = tester.widget<FoundryProgress>(find.byType(FoundryProgress));
        expect(progress.strokeWidth, 4);
      });
    });

    testWidgets('applies custom colors', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const FoundryProgress.linear(value: 0.5, trackColor: Colors.grey, progressColor: Colors.blue)),
      );

      final progress = tester.widget<FoundryProgress>(find.byType(FoundryProgress));
      expect(progress.trackColor, Colors.grey);
      expect(progress.progressColor, Colors.blue);
    });
  });
}
