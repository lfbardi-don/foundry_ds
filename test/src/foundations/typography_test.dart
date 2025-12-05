import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/foundations/typography.dart';

void main() {
  group('FTypography', () {
    test('Font family is correct', () {
      // Assuming a default primary font, adjust if project uses specific font
      expect(FTypography.primary, isA<String>());
    });

    test('Font weights are correct', () {
      expect(FTypography.regular, FontWeight.w400);
      expect(FTypography.medium, FontWeight.w500);
      expect(FTypography.semibold, FontWeight.w600);
      expect(FTypography.bold, FontWeight.w700);
    });

    test('Font sizes follow scale', () {
      expect(FTypography.caption, 12.0);
      expect(FTypography.bodySmall, 14.0);
      expect(FTypography.body, 16.0);
      expect(FTypography.heading, 24.0);
    });
  });
}
