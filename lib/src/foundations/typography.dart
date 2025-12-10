import 'dart:ui';

class FTypography {
  FTypography._();

  static const String primary = 'Inter';
  static const String mono = 'JetBrains Mono';

  static const double caption = 12.0;
  static const double bodySmall = 14.0;
  static const double body = 16.0;
  static const double subheading = 18.0;
  static const double headingSmall = 20.0;
  static const double heading = 24.0;
  static const double headingLarge = 30.0;
  static const double display = 36.0;
  static const double displayLarge = 48.0;

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  static const double tight = 1.0;

  /// Compact line height for dense UI elements like badges.
  static const double compact = 1.2;
  static const double snug = 1.25;
  static const double normal = 1.5;
  static const double relaxed = 1.75;
}
