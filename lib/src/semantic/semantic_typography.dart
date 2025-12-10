import 'dart:ui';

class SemanticTypography {
  final String primary;
  final String mono;

  final double caption;
  final double bodySmall;
  final double body;
  final double subheading;
  final double headingSmall;
  final double heading;
  final double headingLarge;
  final double display;
  final double displayLarge;

  final FontWeight regular;
  final FontWeight medium;
  final FontWeight semibold;
  final FontWeight bold;

  final double tight;
  final double compact;
  final double snug;
  final double normal;
  final double relaxed;

  const SemanticTypography({
    required this.primary,
    required this.mono,
    required this.caption,
    required this.bodySmall,
    required this.body,
    required this.subheading,
    required this.headingSmall,
    required this.heading,
    required this.headingLarge,
    required this.display,
    required this.displayLarge,
    required this.regular,
    required this.medium,
    required this.semibold,
    required this.bold,
    required this.tight,
    required this.compact,
    required this.snug,
    required this.normal,
    required this.relaxed,
  });
}
