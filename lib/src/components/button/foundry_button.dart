import 'package:flutter/material.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/utils/utils.dart';
import 'package:foundry_ds/src/components/components.dart';

enum FoundryButtonVariant { primary, secondary, outline, ghost, destructive }

enum FoundryButtonSize { small, medium, large }

class FoundryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? label;
  final Widget? icon;
  final FoundryButtonVariant variant;
  final FoundryButtonSize size;
  final bool isLoading;
  final bool isDisabled;

  const FoundryButton({
    super.key,
    required this.onPressed,
    this.label,
    this.icon,
    this.variant = FoundryButtonVariant.primary,
    this.size = FoundryButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
  });

  bool get _isEnabled => !isDisabled && !isLoading && onPressed != null;

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final typography = theme.typography;
    final spacing = theme.spacing;
    final radius = theme.radius;
    final motion = theme.motion;

    // Determine padding and text style based on size
    EdgeInsetsGeometry padding;
    double fontSize;
    double iconSize;

    switch (size) {
      case FoundryButtonSize.small:
        padding = FInsets.symmetric(horizontal: spacing.sm, vertical: spacing.xs);
        fontSize = typography.bodySmall;
        iconSize = FIconSize.sm;
        break;
      case FoundryButtonSize.medium:
        padding = FInsets.symmetric(horizontal: spacing.md, vertical: spacing.sm);
        fontSize = typography.body;
        iconSize = FIconSize.md;
        break;
      case FoundryButtonSize.large:
        padding = FInsets.symmetric(horizontal: spacing.lg, vertical: spacing.md);
        fontSize = typography.headingSmall;
        iconSize = FIconSize.lg;
        break;
    }

    return FoundryInteractive(
      enabled: _isEnabled,
      onTap: onPressed,
      builder: (isHovered, isFocused) {
        // Calculate colors based on variant and state
        Color bgColor;
        Color fgColor;
        Color borderColor;

        switch (variant) {
          case FoundryButtonVariant.primary:
            if (!_isEnabled) {
              bgColor = colors.state.disabled.bg!;
              fgColor = colors.state.disabled.fg!;
              borderColor = colors.state.disabled.border ?? colors.button.primary.border;
            } else if (isHovered) {
              bgColor = colors.accent.hover;
              fgColor = colors.button.primary.fg;
              borderColor = colors.button.primary.border;
            } else {
              bgColor = colors.button.primary.bg;
              fgColor = colors.button.primary.fg;
              borderColor = colors.button.primary.border;
            }
            break;
          case FoundryButtonVariant.secondary:
            if (!_isEnabled) {
              bgColor = colors.state.disabled.bg!;
              fgColor = colors.state.disabled.fg!;
              borderColor = colors.state.disabled.border ?? colors.button.secondary.border;
            } else if (isHovered) {
              bgColor = colors.state.hover.bg!;
              fgColor = colors.button.secondary.fg;
              borderColor = colors.button.secondary.border;
            } else {
              bgColor = colors.button.secondary.bg;
              fgColor = colors.button.secondary.fg;
              borderColor = colors.button.secondary.border;
            }
            break;
          case FoundryButtonVariant.outline:
            if (!_isEnabled) {
              bgColor = colors.bg.canvas;
              fgColor = colors.state.disabled.fg!;
              borderColor = colors.state.disabled.border!;
            } else if (isHovered) {
              bgColor = colors.state.hover.bg!;
              fgColor = colors.fg.primary;
              borderColor = colors.border.strong;
            } else {
              bgColor = colors.bg.canvas;
              fgColor = colors.fg.primary;
              borderColor = colors.border.base;
            }
            break;
          case FoundryButtonVariant.ghost:
            if (!_isEnabled) {
              bgColor = colors.bg.transparent;
              fgColor = colors.state.disabled.fg!;
              borderColor = colors.bg.transparent;
            } else if (isHovered) {
              bgColor = colors.state.hover.bg!;
              fgColor = colors.fg.primary;
              borderColor = colors.bg.transparent;
            } else {
              bgColor = colors.bg.transparent;
              fgColor = colors.fg.primary;
              borderColor = colors.bg.transparent;
            }
            break;
          case FoundryButtonVariant.destructive:
            if (!_isEnabled) {
              bgColor = colors.state.disabled.bg!;
              fgColor = colors.state.disabled.fg!;
              borderColor = colors.state.disabled.border ?? colors.status.negative.border;
            } else if (isHovered) {
              bgColor = colors.status.negative.main;
              fgColor = colors.fg.inverted;
              borderColor = colors.status.negative.border;
            } else {
              bgColor = colors.status.negative.bg;
              fgColor = colors.status.negative.fg;
              borderColor = colors.status.negative.border;
            }
            break;
        }

        return AnimatedContainer(
          duration: motion.fast,
          curve: motion.easeInOut,
          padding: padding,
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(
              color: isFocused ? colors.border.focus : borderColor,
              width: isFocused ? FBorderWidth.medium : FBorderWidth.hairline,
            ),
            borderRadius: BorderRadius.circular(radius.md),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading) ...[
                SizedBox(
                  width: iconSize,
                  height: iconSize,
                  child: CircularProgressIndicator(
                    strokeWidth: FBorderWidth.medium,
                    valueColor: AlwaysStoppedAnimation<Color>(fgColor),
                  ),
                ),
                if (label != null) FoundryGap.sm(),
              ] else if (icon != null) ...[
                IconTheme(
                  data: IconThemeData(color: fgColor, size: iconSize),
                  child: icon!,
                ),
                if (label != null) FoundryGap.sm(),
              ],
              if (label != null)
                Text(
                  label!,
                  style: TextStyle(
                    color: fgColor,
                    fontSize: fontSize,
                    fontWeight: typography.medium,
                    fontFamily: typography.primary,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
