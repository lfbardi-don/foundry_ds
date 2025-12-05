import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/utils/utils.dart';
import 'package:foundry_ds/src/theme/theme.dart';

void main() {
  group('FoundryContext', () {
    testWidgets('extensions provide access to theme data', (tester) async {
      await tester.pumpWidget(
        FoundryTheme(
          data: FoundryLightTheme(),
          child: Builder(
            builder: (context) {
              expect(context.foundry, isNotNull);
              expect(context.foundryColors, isNotNull);
              expect(context.foundryTypography, isNotNull);
              expect(context.foundrySpacing, isNotNull);
              expect(context.foundryRadius, isNotNull);
              expect(context.foundryShadows, isNotNull);
              expect(context.foundryMotion, isNotNull);
              expect(context.foundryLayout, isNotNull);

              // Verify precise value mapping
              expect(context.foundryColors.bg.canvas, isA<Color>());
              return const SizedBox();
            },
          ),
        ),
      );
    });
  });
}
