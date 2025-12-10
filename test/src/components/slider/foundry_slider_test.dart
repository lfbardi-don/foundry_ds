import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/components/slider/foundry_slider.dart';
import 'package:foundry_ds/src/theme/theme.dart';

void main() {
  group('FoundrySlider', () {
    testWidgets('updates value on drag', (tester) async {
      double value = 0.0;
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: MaterialApp(
              home: Scaffold(
                body: StatefulBuilder(
                  builder: (context, setState) {
                    return FoundrySlider(value: value, onChanged: (v) => setState(() => value = v), min: 0, max: 100);
                  },
                ),
              ),
            ),
          ),
        ),
      );

      // Drag to 50%
      await tester.drag(find.byType(FoundrySlider), const Offset(400, 0)); // Assuming 800 width test screen
      await tester.pump();

      expect(value, greaterThan(0));
    });

    testWidgets('respects divisions', (tester) async {
      double value = 0.0;
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: MaterialApp(
              home: Scaffold(
                body: StatefulBuilder(
                  builder: (context, setState) {
                    return FoundrySlider(
                      value: value,
                      onChanged: (v) => setState(() => value = v),
                      min: 0,
                      max: 10,
                      divisions: 10,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );

      // Tap near the middle
      await tester.tapAt(tester.getCenter(find.byType(FoundrySlider)));
      await tester.pump();

      // Should be exactly integer because of divisions (0-10, 10 divisions = integers)
      expect(value % 1 == 0, isTrue);
    });
  });
}
