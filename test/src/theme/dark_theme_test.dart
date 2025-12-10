import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/theme/dark_theme.dart';
import 'package:foundry_ds/src/foundations/colors.dart';

void main() {
  group('FoundryDarkTheme', () {
    test('themeData returns valid data', () {
      final theme = FoundryDarkTheme();

      expect(theme.colors.bg.canvas, FColors.zinc950);
      expect(theme.colors.fg.primary, FColors.white);
      expect(theme.colors.button.primary.bg, FColors.brandPrimary);
      expect(theme.colors.button.primary.fg, FColors.brandWhite);
    });
  });
}
