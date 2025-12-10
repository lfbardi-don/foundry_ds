import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/components/page/foundry_page.dart';
import 'package:foundry_ds/src/foundations/layout.dart';
import 'package:foundry_ds/src/theme/theme.dart';

void main() {
  group('FoundryPage', () {
    Widget buildTestWidget(Widget child) {
      return FoundryTheme(
        data: FoundryLightTheme(),
        child: MaterialApp(home: child),
      );
    }

    testWidgets('renders body content', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryPage(body: Text('Page Content'))));

      expect(find.text('Page Content'), findsOneWidget);
    });

    testWidgets('wraps body in Scaffold', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryPage(body: Text('Test'))));

      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('applies max-width constraint', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryPage(body: Text('Constrained'))));

      // Find the ConstrainedBox with maxWidth = FLayout.xl
      final constrainedBox = tester.widget<ConstrainedBox>(
        find.byWidgetPredicate((widget) => widget is ConstrainedBox && widget.constraints.maxWidth == FLayout.xl),
      );
      expect(constrainedBox.constraints.maxWidth, FLayout.xl);
    });

    testWidgets('supports appBar', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          FoundryPage(
            appBar: AppBar(title: const Text('App Title')),
            body: const Text('Content'),
          ),
        ),
      );

      expect(find.text('App Title'), findsOneWidget);
    });

    testWidgets('supports bottomNavigationBar', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          FoundryPage(
            body: const Text('Content'),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('supports floatingActionButton', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          FoundryPage(
            body: const Text('Content'),
            floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
          ),
        ),
      );

      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('applies custom backgroundColor', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryPage(body: Text('Content'), backgroundColor: Colors.red)));

      final page = tester.widget<FoundryPage>(find.byType(FoundryPage));
      expect(page.backgroundColor, Colors.red);
    });

    testWidgets('supports extendBodyBehindAppBar', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          FoundryPage(
            appBar: AppBar(title: const Text('Title')),
            body: const Text('Content'),
            extendBodyBehindAppBar: true,
          ),
        ),
      );

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.extendBodyBehindAppBar, true);
    });
  });
}
