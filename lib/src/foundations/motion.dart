import 'package:flutter/animation.dart' show Curve, Cubic, Curves;

class FMotion {
  FMotion._();

  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);

  static const Duration delayShort = Duration(milliseconds: 100);
  static const Duration delayMedium = Duration(milliseconds: 200);
  static const Duration delayLong = Duration(milliseconds: 300);

  /// Duration for pulse/heartbeat animations (e.g., badge notification).
  static const Duration pulse = Duration(milliseconds: 1500);

  /// Duration for snackbar entry animation.
  static const Duration snackbarEntry = Duration(milliseconds: 350);

  static const Curve easeOut = Cubic(0.25, 0.1, 0.25, 1.0);
  static const Curve easeInOut = Cubic(0.42, 0.0, 0.58, 1.0);
  static const Curve emphasized = Cubic(0.2, 0.0, 0.0, 1.0);
  static const Curve decelerate = Cubic(0.0, 0.0, 0.2, 1.0);
  static const Curve accelerate = Cubic(0.4, 0.0, 1.0, 1.0);

  /// Spring curve for pop/bounce animations (radio, snackbar).
  static const Curve spring = Curves.easeOutBack;

  static const Duration slideIn = Duration(milliseconds: 200);

  static const Duration fadeIn = Duration(milliseconds: 250);

  static const Duration tooltip = Duration(milliseconds: 150);

  static const Duration spin = Duration(milliseconds: 1500);

  static const Duration toastDisplay = Duration(seconds: 3);

  static const Duration tooltipDisplay = Duration(seconds: 2);

  /// Default smoothness factor for smooth scroll interpolation.
  ///
  /// Lower values = smoother/slower (e.g., 0.05)
  /// Higher values = snappier (e.g., 0.15)
  static const double scrollSmoothness = 0.1;
}
