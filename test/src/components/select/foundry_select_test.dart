import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/components/select/foundry_select.dart';
import 'package:foundry_ds/src/theme/theme.dart';

void main() {
  group('FoundrySelect', () {
    testWidgets('opens dropdown and selects option', (tester) async {
      String? selectedValue;

      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: MaterialApp(
              home: Scaffold(
                body: StatefulBuilder(
                  builder: (context, setState) {
                    return FoundrySelect<String>(
                      value: selectedValue,
                      options: const [
                        FoundrySelectOption(value: 'a', label: 'Option A'),
                        FoundrySelectOption(value: 'b', label: 'Option B'),
                      ],
                      onChanged: (v) => setState(() => selectedValue = v),
                      placeholder: 'Select...',
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Select...'), findsOneWidget);
      expect(find.text('Option A'), findsNothing);

      // Open Dropdown
      await tester.tap(find.byType(FoundrySelect<String>));
      await tester.pumpAndSettle();

      expect(find.text('Option A'), findsOneWidget);

      // Select Option B
      await tester.tap(find.text('Option B').last);
      await tester.pumpAndSettle();

      expect(selectedValue, 'b');
      expect(find.text('Option B'), findsOneWidget); // Displayed in select box
    });
  });
}
