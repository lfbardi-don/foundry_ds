import 'package:flutter/widgets.dart';

class SemanticShadows {
  final List<BoxShadow> none;
  final List<BoxShadow> xs;
  final List<BoxShadow> sm;
  final List<BoxShadow> md;
  final List<BoxShadow> lg;
  final List<BoxShadow> xl;

  const SemanticShadows({
    required this.none,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });
}
