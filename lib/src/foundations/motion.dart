import 'package:flutter/animation.dart' show Curve, Cubic;

class FMotion {
  FMotion._();

  // Durations
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);

  // Delays
  static const Duration delayShort = Duration(milliseconds: 100);
  static const Duration delayMedium = Duration(milliseconds: 200);
  static const Duration delayLong = Duration(milliseconds: 300);

  // Curves
  static const Curve easeOut = Cubic(0.25, 0.1, 0.25, 1.0);
  static const Curve easeInOut = Cubic(0.42, 0.0, 0.58, 1.0);
  static const Curve emphasized = Cubic(0.2, 0.0, 0.0, 1.0);
  static const Curve decelerate = Cubic(0.0, 0.0, 0.2, 1.0);
  static const Curve accelerate = Cubic(0.4, 0.0, 1.0, 1.0);

  // Animation durations
  /// Slide in/out animation for overlays (200ms)
  static const Duration slideIn = Duration(milliseconds: 200);

  /// Fade in/out animation for overlays (250ms)
  static const Duration fadeIn = Duration(milliseconds: 250);

  /// Tooltip show animation (150ms)
  static const Duration tooltip = Duration(milliseconds: 150);

  /// Spinner/loader full rotation (1500ms)
  static const Duration spin = Duration(milliseconds: 1500);

  // Display durations
  /// How long toast notifications display (3s)
  static const Duration toastDisplay = Duration(seconds: 3);

  /// How long tooltips display (2s)
  static const Duration tooltipDisplay = Duration(seconds: 2);
}
