import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';

/// Visual styles for [FoundryDivider].
enum FoundryDividerStyle { solid, fade, gradient }

/// A horizontal or vertical divider line with configurable styling.
class FoundryDivider extends StatelessWidget {
  final Axis direction;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;
  final FoundryDividerStyle style;
  final Gradient? gradient;

  const FoundryDivider({
    super.key,
    this.direction = Axis.horizontal,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
    this.style = FoundryDividerStyle.solid,
    this.gradient,
  });

  const FoundryDivider.horizontal({
    super.key,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
    this.style = FoundryDividerStyle.solid,
    this.gradient,
  }) : direction = Axis.horizontal;

  const FoundryDivider.vertical({
    super.key,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
    this.style = FoundryDividerStyle.solid,
    this.gradient,
  }) : direction = Axis.vertical;

  const FoundryDivider.fade({
    super.key,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
    this.direction = Axis.horizontal,
  }) : style = FoundryDividerStyle.fade,
       gradient = null;

  const FoundryDivider.withGradient({
    super.key,
    this.thickness,
    this.indent,
    this.endIndent,
    required this.gradient,
    this.direction = Axis.horizontal,
  }) : style = FoundryDividerStyle.gradient,
       color = null;

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final dividerColor = color ?? colors.border.muted;
    final dividerThickness = thickness ?? FBorderWidth.hairline;

    if (direction == Axis.vertical) {
      return _buildVertical(dividerColor, dividerThickness);
    }

    return _buildHorizontal(dividerColor, dividerThickness);
  }

  Widget _buildHorizontal(Color dividerColor, double dividerThickness) {
    final margin = EdgeInsets.only(left: indent ?? 0, right: endIndent ?? 0);

    switch (style) {
      case FoundryDividerStyle.solid:
        return Container(height: dividerThickness, margin: margin, color: dividerColor);

      case FoundryDividerStyle.fade:
        return Container(
          height: dividerThickness,
          margin: margin,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                dividerColor.withValues(alpha: 0.0),
                dividerColor,
                dividerColor,
                dividerColor.withValues(alpha: 0.0),
              ],
              stops: const [0.0, 0.15, 0.85, 1.0],
            ),
          ),
        );

      case FoundryDividerStyle.gradient:
        return Container(
          height: dividerThickness,
          margin: margin,
          decoration: BoxDecoration(
            gradient:
                gradient ??
                LinearGradient(
                  colors: [dividerColor.withValues(alpha: 0.0), dividerColor, dividerColor.withValues(alpha: 0.0)],
                ),
          ),
        );
    }
  }

  Widget _buildVertical(Color dividerColor, double dividerThickness) {
    final margin = EdgeInsets.only(top: indent ?? 0, bottom: endIndent ?? 0);

    switch (style) {
      case FoundryDividerStyle.solid:
        return Container(width: dividerThickness, margin: margin, color: dividerColor);

      case FoundryDividerStyle.fade:
        return Container(
          width: dividerThickness,
          margin: margin,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                dividerColor.withValues(alpha: 0.0),
                dividerColor,
                dividerColor,
                dividerColor.withValues(alpha: 0.0),
              ],
              stops: const [0.0, 0.15, 0.85, 1.0],
            ),
          ),
        );

      case FoundryDividerStyle.gradient:
        return Container(
          width: dividerThickness,
          margin: margin,
          decoration: BoxDecoration(
            gradient:
                gradient ??
                LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [dividerColor.withValues(alpha: 0.0), dividerColor, dividerColor.withValues(alpha: 0.0)],
                ),
          ),
        );
    }
  }
}
