import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/components/modal/foundry_modal.dart';
import 'package:foundry_ds/src/theme/theme.dart';

void main() {
  group('FoundryModal', () {
    Widget buildTestWidget(Widget child) {
      return FoundryTheme(
        data: FoundryLightTheme(),
        child: MaterialApp(home: Scaffold(body: child)),
      );
    }

    testWidgets('renders with content', (tester) async {
      await tester.pumpWidget(buildTestWidget(FoundryModal(content: const Text('Modal Content'))));

      expect(find.text('Modal Content'), findsOneWidget);
    });

    testWidgets('renders with title', (tester) async {
      await tester.pumpWidget(buildTestWidget(FoundryModal(title: 'Modal Title', content: const Text('Content'))));

      expect(find.text('Modal Title'), findsOneWidget);
    });

    testWidgets('renders action buttons', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          FoundryModal(
            content: const Text('Content'),
            actions: [
              TextButton(onPressed: () {}, child: const Text('Cancel')),
              TextButton(onPressed: () {}, child: const Text('OK')),
            ],
          ),
        ),
      );

      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('shows close button by default', (tester) async {
      await tester.pumpWidget(buildTestWidget(FoundryModal(title: 'Title', content: const Text('Content'))));

      final modal = tester.widget<FoundryModal>(find.byType(FoundryModal));
      expect(modal.showCloseButton, true);
    });

    testWidgets('hides close button when showCloseButton is false', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(FoundryModal(title: 'Title', content: const Text('Content'), showCloseButton: false)),
      );

      final modal = tester.widget<FoundryModal>(find.byType(FoundryModal));
      expect(modal.showCloseButton, false);
    });

    testWidgets('applies custom maxWidth', (tester) async {
      await tester.pumpWidget(buildTestWidget(FoundryModal(maxWidth: 600, content: const Text('Wide Content'))));

      final modal = tester.widget<FoundryModal>(find.byType(FoundryModal));
      expect(modal.maxWidth, 600);
    });
  });

  group('FoundryConfirmDialog', () {
    testWidgets('shows dialog with title and message', (tester) async {
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => TextButton(
                  onPressed: () {
                    FoundryConfirmDialog.show(context: context, title: 'Confirmation', message: 'Are you sure?');
                  },
                  child: const Text('Show Dialog'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Confirmation'), findsOneWidget);
      expect(find.text('Are you sure?'), findsOneWidget);
    });

    testWidgets('shows Cancel and Confirm buttons', (tester) async {
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => TextButton(
                  onPressed: () {
                    FoundryConfirmDialog.show(context: context, title: 'Confirmation', message: 'Are you sure?');
                  },
                  child: const Text('Show Dialog'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Confirm'), findsOneWidget);
    });
  });
}
