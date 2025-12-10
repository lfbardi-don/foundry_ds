import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/components/input/foundry_input.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return FoundryTheme(
      data: FoundryLightTheme(),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: MaterialApp(
          home: Scaffold(body: Center(child: child)),
        ),
      ),
    );
  }

  group('FoundryInput', () {
    testWidgets('renders initial text', (tester) async {
      final controller = TextEditingController(text: 'Hello');
      await tester.pumpWidget(buildTestWidget(FoundryInput(controller: controller)));

      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('updates text on change', (tester) async {
      String? value;
      await tester.pumpWidget(buildTestWidget(FoundryInput(onChanged: (v) => value = v, placeholder: 'Type here')));

      await tester.enterText(find.byType(TextField), 'Foundry');
      await tester.pump();
      expect(value, 'Foundry');
    });

    testWidgets('renders label', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryInput(label: 'Email')));

      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('renders prefix icon', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryInput(prefixIcon: Icon(LucideIcons.search))));

      expect(find.byIcon(LucideIcons.search), findsOneWidget);
    });

    testWidgets('renders suffix icon', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryInput(suffixIcon: Icon(LucideIcons.x))));

      expect(find.byIcon(LucideIcons.x), findsOneWidget);
    });

    testWidgets('renders helper text', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryInput(helperText: 'Enter your email address')));

      expect(find.text('Enter your email address'), findsOneWidget);
    });

    testWidgets('renders error text over helper text', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(const FoundryInput(helperText: 'Helper text', errorText: 'This field is required')),
      );

      expect(find.text('This field is required'), findsOneWidget);
      expect(find.text('Helper text'), findsNothing);
    });

    testWidgets('disabled state prevents interaction', (tester) async {
      String? value;
      await tester.pumpWidget(buildTestWidget(FoundryInput(enabled: false, onChanged: (v) => value = v)));

      // TextField should be disabled
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, false);
      expect(value, isNull); // onChanged should not have been called
    });

    testWidgets('placeholder is rendered', (tester) async {
      await tester.pumpWidget(buildTestWidget(const FoundryInput(placeholder: 'Enter value')));

      expect(find.text('Enter value'), findsOneWidget);
    });
  });
}
