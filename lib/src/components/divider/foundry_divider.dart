import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';

/// A divider widget that enforces design system tokens.
///
/// Use [FoundryDivider] instead of Flutter's [Divider] to ensure
/// consistent styling across your application.
class FoundryDivider extends StatelessWidget {
  final Axis direction;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;

  const FoundryDivider({
    super.key,
    this.direction = Axis.horizontal,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  });

  /// Horizontal divider (default)
  const FoundryDivider.horizontal({super.key, this.thickness, this.indent, this.endIndent, this.color})
    : direction = Axis.horizontal;

  /// Vertical divider
  const FoundryDivider.vertical({super.key, this.thickness, this.indent, this.endIndent, this.color})
    : direction = Axis.vertical;

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final dividerColor = color ?? colors.border.muted;
    final dividerThickness = thickness ?? FBorderWidth.hairline;

    if (direction == Axis.vertical) {
      return Container(
        width: dividerThickness,
        margin: EdgeInsets.only(top: indent ?? 0, bottom: endIndent ?? 0),
        color: dividerColor,
      );
    }

    return Container(
      height: dividerThickness,
      margin: EdgeInsets.only(left: indent ?? 0, right: endIndent ?? 0),
      color: dividerColor,
    );
  }
}
