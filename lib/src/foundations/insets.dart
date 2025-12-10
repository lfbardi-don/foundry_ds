import 'package:flutter/widgets.dart';
import 'spacing.dart';

/// Standardized EdgeInsets tokens for consistent padding and margins.
class FInsets {
  FInsets._();

  static const EdgeInsets xxs = EdgeInsets.all(FSpacing.xxs);
  static const EdgeInsets xs = EdgeInsets.all(FSpacing.xs);
  static const EdgeInsets sm = EdgeInsets.all(FSpacing.sm);
  static const EdgeInsets md = EdgeInsets.all(FSpacing.md);
  static const EdgeInsets lg = EdgeInsets.all(FSpacing.lg);
  static const EdgeInsets xl = EdgeInsets.all(FSpacing.xl);
  static const EdgeInsets xxl = EdgeInsets.all(FSpacing.xxl);
  static const EdgeInsets xxxl = EdgeInsets.all(FSpacing.xxxl);

  static const EdgeInsets hXxs = EdgeInsets.symmetric(horizontal: FSpacing.xxs);
  static const EdgeInsets hXs = EdgeInsets.symmetric(horizontal: FSpacing.xs);
  static const EdgeInsets hSm = EdgeInsets.symmetric(horizontal: FSpacing.sm);
  static const EdgeInsets hMd = EdgeInsets.symmetric(horizontal: FSpacing.md);
  static const EdgeInsets hLg = EdgeInsets.symmetric(horizontal: FSpacing.lg);
  static const EdgeInsets hXl = EdgeInsets.symmetric(horizontal: FSpacing.xl);
  static const EdgeInsets hXxl = EdgeInsets.symmetric(horizontal: FSpacing.xxl);
  static const EdgeInsets hXxxl = EdgeInsets.symmetric(horizontal: FSpacing.xxxl);

  static const EdgeInsets vXxs = EdgeInsets.symmetric(vertical: FSpacing.xxs);
  static const EdgeInsets vXs = EdgeInsets.symmetric(vertical: FSpacing.xs);
  static const EdgeInsets vSm = EdgeInsets.symmetric(vertical: FSpacing.sm);
  static const EdgeInsets vMd = EdgeInsets.symmetric(vertical: FSpacing.md);
  static const EdgeInsets vLg = EdgeInsets.symmetric(vertical: FSpacing.lg);
  static const EdgeInsets vXl = EdgeInsets.symmetric(vertical: FSpacing.xl);
  static const EdgeInsets vXxl = EdgeInsets.symmetric(vertical: FSpacing.xxl);
  static const EdgeInsets vXxxl = EdgeInsets.symmetric(vertical: FSpacing.xxxl);

  static const EdgeInsets topXxs = EdgeInsets.only(top: FSpacing.xxs);

  static EdgeInsets all(double token) => EdgeInsets.all(token);
  static EdgeInsets symmetric({double horizontal = 0, double vertical = 0}) =>
      EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  static EdgeInsets only({double left = 0, double top = 0, double right = 0, double bottom = 0}) =>
      EdgeInsets.only(left: left, top: top, right: right, bottom: bottom);
}
