import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';

/// Elevation variants for surfaces.
enum FoundrySurfaceVariant {
  /// Flat surface with no elevation (uses muted background)
  flat,

  /// Raised surface with subtle shadow (default card style)
  raised,

  /// Elevated surface with more prominent shadow
  elevated,

  /// Overlay surface for modals and dialogs
  overlay,
}

/// A foundational container widget that applies consistent styling.
///
/// Use [FoundrySurface] as the base for cards, sheets, sections, and other
/// container elements to ensure consistent elevation, padding, and styling.
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

  /// Flat surface for subtle backgrounds
  const FoundrySurface.flat({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.borderColor,
    this.showBorder = false,
  }) : variant = FoundrySurfaceVariant.flat;

  /// Raised surface with shadow (default card style)
  const FoundrySurface.raised({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.borderColor,
    this.showBorder = false,
  }) : variant = FoundrySurfaceVariant.raised;

  /// Elevated surface with prominent shadow
  const FoundrySurface.elevated({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.borderColor,
    this.showBorder = false,
  }) : variant = FoundrySurfaceVariant.elevated;

  /// Overlay surface for modals
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
