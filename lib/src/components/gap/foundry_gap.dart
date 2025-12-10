import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';

/// A spacing widget using the design system's spacing scale.
class FoundryGap extends StatelessWidget {
  final double size;

  const FoundryGap(this.size, {super.key});

  const FoundryGap.xxs({super.key}) : size = FSpacing.xxs;

  const FoundryGap.xs({super.key}) : size = FSpacing.xs;

  const FoundryGap.sm({super.key}) : size = FSpacing.sm;

  const FoundryGap.md({super.key}) : size = FSpacing.md;

  const FoundryGap.lg({super.key}) : size = FSpacing.lg;

  const FoundryGap.xl({super.key}) : size = FSpacing.xl;

  const FoundryGap.xxl({super.key}) : size = FSpacing.xxl;

  const FoundryGap.xxxl({super.key}) : size = FSpacing.xxxl;

  @override
  Widget build(BuildContext context) {
    return Gap(size);
  }
}
