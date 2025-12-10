import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/components/tabs/foundry_tabs.dart';
import 'package:foundry_ds/src/theme/theme.dart';

void main() {
  group('FoundryTabs', () {
    Widget buildTestWidget(Widget child) {
      return FoundryTheme(
        data: FoundryLightTheme(),
        child: MaterialApp(home: Scaffold(body: child)),
      );
    }

    testWidgets('renders all tabs', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          FoundryTabs(
            selectedIndex: 0,
            onChanged: (_) {},
            tabs: const [
              FoundryTab(label: 'Tab 1'),
              FoundryTab(label: 'Tab 2'),
              FoundryTab(label: 'Tab 3'),
            ],
          ),
        ),
      );

      expect(find.text('Tab 1'), findsOneWidget);
      expect(find.text('Tab 2'), findsOneWidget);
      expect(find.text('Tab 3'), findsOneWidget);
    });

    testWidgets('calls onChanged when tab is tapped', (tester) async {
      int? selectedIndex;
      await tester.pumpWidget(
        buildTestWidget(
          FoundryTabs(
            selectedIndex: 0,
            onChanged: (index) => selectedIndex = index,
            tabs: const [
              FoundryTab(label: 'Tab 1'),
              FoundryTab(label: 'Tab 2'),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Tab 2'));
      expect(selectedIndex, 1);
    });

    testWidgets('renders tab with icon', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          FoundryTabs(
            selectedIndex: 0,
            onChanged: (_) {},
            tabs: const [
              FoundryTab(label: 'Home', icon: Icons.home),
              FoundryTab(label: 'Settings', icon: Icons.settings),
            ],
          ),
        ),
      );

      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('renders tabs without labels (icon only)', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          FoundryTabs(
            selectedIndex: 0,
            onChanged: (_) {},
            tabs: const [
              FoundryTab(icon: Icons.home),
              FoundryTab(icon: Icons.settings),
            ],
          ),
        ),
      );

      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });
  });

  group('FoundryTabView', () {
    Widget buildTestWidget(Widget child) {
      return FoundryTheme(
        data: FoundryLightTheme(),
        child: MaterialApp(home: Scaffold(body: child)),
      );
    }

    testWidgets('renders with tabs and children', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          FoundryTabView(
            tabs: const [
              FoundryTab(label: 'Tab 1'),
              FoundryTab(label: 'Tab 2'),
            ],
            children: const [Text('Content 1'), Text('Content 2')],
          ),
        ),
      );

      expect(find.text('Tab 1'), findsOneWidget);
      expect(find.text('Tab 2'), findsOneWidget);
      expect(find.text('Content 1'), findsOneWidget);
    });

    testWidgets('switches content when tab is tapped', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          FoundryTabView(
            tabs: const [
              FoundryTab(label: 'Tab 1'),
              FoundryTab(label: 'Tab 2'),
            ],
            children: const [Text('Content 1'), Text('Content 2')],
          ),
        ),
      );

      expect(find.text('Content 1'), findsOneWidget);
      expect(find.text('Content 2'), findsNothing);

      await tester.tap(find.text('Tab 2'));
      await tester.pumpAndSettle();

      expect(find.text('Content 1'), findsNothing);
      expect(find.text('Content 2'), findsOneWidget);
    });

    testWidgets('respects initialIndex', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          FoundryTabView(
            initialIndex: 1,
            tabs: const [
              FoundryTab(label: 'Tab 1'),
              FoundryTab(label: 'Tab 2'),
            ],
            children: const [Text('Content 1'), Text('Content 2')],
          ),
        ),
      );

      final stack = tester.widget<IndexedStack>(find.byType(IndexedStack));
      expect(stack.index, 1);
    });
  });
}
