import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/foundations/spacing.dart';

void main() {
  group('FSpacing', () {
    test('Spacing values follow 4px grid', () {
      expect(FSpacing.xxs, 2.0);
      expect(FSpacing.xs, 4.0);
      expect(FSpacing.sm, 8.0);
      expect(FSpacing.md, 16.0);
      expect(FSpacing.lg, 24.0);
      expect(FSpacing.xl, 32.0);
      expect(FSpacing.xxl, 48.0);
      expect(FSpacing.xxxl, 64.0);
    });
  });
}
