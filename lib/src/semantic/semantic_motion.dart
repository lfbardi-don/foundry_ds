import 'package:flutter/animation.dart';

class SemanticMotion {
  final Duration fast;
  final Duration normal;
  final Duration slow;

  final Duration delayShort;
  final Duration delayMedium;
  final Duration delayLong;

  final Curve easeOut;
  final Curve easeInOut;
  final Curve emphasized;
  final Curve decelerate;
  final Curve accelerate;

  const SemanticMotion({
    required this.fast,
    required this.normal,
    required this.slow,
    required this.delayShort,
    required this.delayMedium,
    required this.delayLong,
    required this.easeOut,
    required this.easeInOut,
    required this.emphasized,
    required this.decelerate,
    required this.accelerate,
  });
}
