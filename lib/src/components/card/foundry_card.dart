import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';

/// Visual variants for [FoundryCard].
enum FoundryCardVariant { elevated, outlined, flat }

/// A container surface with configurable elevation and border styles.
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
    final motion = theme.motion;

    Color bgColor;
    Color borderColor;
    double borderWidth;
    List<BoxShadow> boxShadow;

    switch (variant) {
      case FoundryCardVariant.elevated:
        bgColor = colors.card.bg;
        borderColor = colors.border.transparent;
        borderWidth = FBorderWidth.none;
        boxShadow = shadows.sm;
        break;
      case FoundryCardVariant.outlined:
        bgColor = colors.bg.canvas;
        borderColor = colors.border.base;
        borderWidth = FBorderWidth.hairline;
        boxShadow = shadows.none;
        break;
      case FoundryCardVariant.flat:
        bgColor = colors.bg.muted;
        borderColor = colors.border.transparent;
        borderWidth = FBorderWidth.none;
        boxShadow = shadows.none;
        break;
    }

    return AnimatedContainer(
      duration: motion.normal,
      curve: motion.easeInOut,
      padding: padding ?? FInsets.md,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor, width: borderWidth),
        borderRadius: BorderRadius.circular(radius.lg),
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
