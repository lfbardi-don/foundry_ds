import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/components/bottom_sheet/foundry_bottom_sheet.dart';
import 'package:foundry_ds/src/theme/theme.dart';

void main() {
  group('FoundryBottomSheet', () {
    Widget buildTestWidget(Widget child) {
      return FoundryTheme(
        data: FoundryLightTheme(),
        child: MaterialApp(home: Scaffold(body: child)),
      );
    }

    testWidgets('renders with content', (tester) async {
      await tester.pumpWidget(buildTestWidget(FoundryBottomSheet(child: const Text('Sheet Content'))));

      expect(find.text('Sheet Content'), findsOneWidget);
    });

    testWidgets('renders with title', (tester) async {
      await tester.pumpWidget(buildTestWidget(FoundryBottomSheet(title: 'Sheet Title', child: const Text('Content'))));

      expect(find.text('Sheet Title'), findsOneWidget);
    });

    testWidgets('shows handle by default', (tester) async {
      await tester.pumpWidget(buildTestWidget(FoundryBottomSheet(child: const Text('Content'))));

      final sheet = tester.widget<FoundryBottomSheet>(find.byType(FoundryBottomSheet));
      expect(sheet.showHandle, true);
    });

    testWidgets('hides handle when showHandle is false', (tester) async {
      await tester.pumpWidget(buildTestWidget(FoundryBottomSheet(showHandle: false, child: const Text('Content'))));

      final sheet = tester.widget<FoundryBottomSheet>(find.byType(FoundryBottomSheet));
      expect(sheet.showHandle, false);
    });

    testWidgets('shows close button by default', (tester) async {
      await tester.pumpWidget(buildTestWidget(FoundryBottomSheet(title: 'Title', child: const Text('Content'))));

      final sheet = tester.widget<FoundryBottomSheet>(find.byType(FoundryBottomSheet));
      expect(sheet.showCloseButton, true);
    });

    testWidgets('hides close button when showCloseButton is false', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(FoundryBottomSheet(title: 'Title', showCloseButton: false, child: const Text('Content'))),
      );

      final sheet = tester.widget<FoundryBottomSheet>(find.byType(FoundryBottomSheet));
      expect(sheet.showCloseButton, false);
    });
  });

  group('FoundryActionSheetItem', () {
    testWidgets('creates action item with label', (tester) async {
      const item = FoundryActionSheetItem<String>(label: 'Action');
      expect(item.label, 'Action');
    });

    testWidgets('creates action item with icon', (tester) async {
      const item = FoundryActionSheetItem<String>(label: 'Action', icon: Icons.edit);
      expect(item.icon, Icons.edit);
    });

    testWidgets('creates destructive action item', (tester) async {
      const item = FoundryActionSheetItem<String>(label: 'Delete', isDestructive: true);
      expect(item.isDestructive, true);
    });
  });
}
