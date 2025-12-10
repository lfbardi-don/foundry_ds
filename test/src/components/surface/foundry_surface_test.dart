import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/components/surface/foundry_surface.dart';
import 'package:foundry_ds/src/theme/theme.dart';

void main() {
  group('FoundrySurface', () {
    Widget buildTestWidget(Widget child) {
      return FoundryTheme(
        data: FoundryLightTheme(),
        child: MaterialApp(home: Scaffold(body: child)),
      );
    }

    testWidgets('renders child correctly', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundrySurface(child: Text('Surface Content'))));

      expect(find.text('Surface Content'), findsOneWidget);
    });

    testWidgets('defaults to raised variant', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundrySurface(child: Text('Test'))));

      final surface = tester.widget<FoundrySurface>(find.byType(FoundrySurface));
      expect(surface.variant, FoundrySurfaceVariant.raised);
    });

    group('variants', () {
      testWidgets('flat constructor creates flat variant', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundrySurface.flat(child: Text('Flat'))));

        final surface = tester.widget<FoundrySurface>(find.byType(FoundrySurface));
        expect(surface.variant, FoundrySurfaceVariant.flat);
      });

      testWidgets('raised constructor creates raised variant', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundrySurface.raised(child: Text('Raised'))));

        final surface = tester.widget<FoundrySurface>(find.byType(FoundrySurface));
        expect(surface.variant, FoundrySurfaceVariant.raised);
      });

      testWidgets('elevated constructor creates elevated variant', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundrySurface.elevated(child: Text('Elevated'))));

        final surface = tester.widget<FoundrySurface>(find.byType(FoundrySurface));
        expect(surface.variant, FoundrySurfaceVariant.elevated);
      });

      testWidgets('overlay constructor creates overlay variant', (tester) async {
        await tester.pumpWidget(buildTestWidget(const FoundrySurface.overlay(child: Text('Overlay'))));

        final surface = tester.widget<FoundrySurface>(find.byType(FoundrySurface));
        expect(surface.variant, FoundrySurfaceVariant.overlay);
      });
    });

    testWidgets('applies custom padding', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const FoundrySurface(padding: EdgeInsets.all(32), child: Text('Padded'))),
      );

      expect(find.text('Padded'), findsOneWidget);
    });

    testWidgets('shows border when showBorder is true', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundrySurface(showBorder: true, child: Text('Bordered'))));

      final surface = tester.widget<FoundrySurface>(find.byType(FoundrySurface));
      expect(surface.showBorder, true);
    });

    testWidgets('applies custom borderRadius', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundrySurface(borderRadius: 24, child: Text('Rounded'))));

      final surface = tester.widget<FoundrySurface>(find.byType(FoundrySurface));
      expect(surface.borderRadius, 24);
    });
  });
}
