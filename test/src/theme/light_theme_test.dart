import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/theme/light_theme.dart';
import 'package:foundry_ds/src/foundations/colors.dart';

void main() {
  group('FoundryLightTheme', () {
    test('themeData returns valid data', () {
      final theme = FoundryLightTheme();

      expect(theme.colors.bg.canvas, FColors.white);
      expect(theme.colors.fg.primary, FColors.zinc950);
      expect(theme.colors.button.primary.bg, FColors.brandPrimary);
    });
  });
}
