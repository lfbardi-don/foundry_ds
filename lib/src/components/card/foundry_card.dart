import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';

enum FoundryCardVariant { elevated, outlined, flat }

class FoundryCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final FoundryCardVariant variant;

  const FoundryCard({super.key, required this.child, this.padding, this.variant = FoundryCardVariant.elevated});

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final radius = theme.radius;
    final shadows = theme.shadows;

    Color bgColor;
    Color borderColor;
    List<BoxShadow> boxShadow;

    switch (variant) {
      case FoundryCardVariant.elevated:
        bgColor = colors.card.bg;
        borderColor = colors.border.transparent;
        boxShadow = shadows.sm;
        break;
      case FoundryCardVariant.outlined:
        bgColor = colors.bg.canvas;
        borderColor = colors.border.base;
        boxShadow = shadows.none;
        break;
      case FoundryCardVariant.flat:
        bgColor = colors.bg.muted;
        borderColor = colors.border.transparent;
        boxShadow = shadows.none;
        break;
    }

    return Container(
      padding: padding ?? FInsets.md,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(radius.lg),
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
