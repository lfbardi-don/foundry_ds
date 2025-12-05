import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foundry_ds/src/foundations/colors.dart';

void main() {
  group('FColors', () {
    test('Grayscale colors are opaque', () {
      expect(FColors.zinc100.a, 1.0);
      expect(FColors.zinc900.a, 1.0);
    });

    test('Primary colors are opaque', () {
      expect(FColors.blue500.a, 1.0);
    });

    test('Semantic colors map correctly', () {
      // White and Black constants
      expect(FColors.white, const Color(0xFFFFFFFF));
      expect(FColors.black, const Color(0xFF000000));

      // Transparent
      expect(FColors.transparent, const Color(0x00000000));
    });
  });
}
