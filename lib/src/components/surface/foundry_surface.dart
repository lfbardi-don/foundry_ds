import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';

/// Elevation levels for [FoundrySurface].
enum FoundrySurfaceVariant { flat, raised, elevated, overlay }

/// A container with configurable elevation and background.
class FoundrySurface extends StatelessWidget {
  final Widget child;
  final FoundrySurfaceVariant variant;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? borderColor;
  final bool showBorder;

  const FoundrySurface({
    super.key,
    required this.child,
    this.variant = FoundrySurfaceVariant.raised,
    this.padding,
    this.borderRadius,
    this.borderColor,
    this.showBorder = false,
  });

  const FoundrySurface.flat({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.borderColor,
    this.showBorder = false,
  }) : variant = FoundrySurfaceVariant.flat;

  const FoundrySurface.raised({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.borderColor,
    this.showBorder = false,
  }) : variant = FoundrySurfaceVariant.raised;

  const FoundrySurface.elevated({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.borderColor,
    this.showBorder = false,
  }) : variant = FoundrySurfaceVariant.elevated;

  const FoundrySurface.overlay({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.borderColor,
    this.showBorder = false,
  }) : variant = FoundrySurfaceVariant.overlay;

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final radius = theme.radius;
    final shadows = theme.shadows;
    final spacing = theme.spacing;

    Color bgColor;
    List<BoxShadow> boxShadow;

    switch (variant) {
      case FoundrySurfaceVariant.flat:
        bgColor = colors.layout.subtle;
        boxShadow = shadows.none;
        break;
      case FoundrySurfaceVariant.raised:
        bgColor = colors.layout.surface;
        boxShadow = shadows.sm;
        break;
      case FoundrySurfaceVariant.elevated:
        bgColor = colors.layout.elevated;
        boxShadow = shadows.md;
        break;
      case FoundrySurfaceVariant.overlay:
        bgColor = colors.layout.surface;
        boxShadow = shadows.lg;
        break;
    }

    return Container(
      padding: padding ?? FInsets.all(spacing.md),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius ?? radius.lg),
        boxShadow: boxShadow,
        border: showBorder ? Border.all(color: borderColor ?? colors.border.base) : null,
      ),
      child: child,
    );
  }
}
