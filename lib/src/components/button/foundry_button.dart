import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/utils/utils.dart';
import 'package:foundry_ds/src/components/components.dart';
import 'package:foundry_ds/src/semantic/semantic.dart';

enum FoundryButtonVariant { primary, secondary, outline, ghost, destructive }

enum FoundryButtonSize { small, medium, large }

class _ButtonColors {
  final Color background;
  final Color foreground;
  final Color border;

  const _ButtonColors({required this.background, required this.foreground, required this.border});
}

class _SizeConfig {
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final double iconSize;
  final double iconPadding;

  const _SizeConfig({required this.padding, required this.fontSize, required this.iconSize, required this.iconPadding});
}

/// A [FoundryButton] component with multiple [FoundryButtonVariant], [FoundryButtonSize], and states.
///
/// Supports: primary, secondary, outline, ghost, and destructive variants.
/// Features: loading state, icon support, haptic feedback, accessibility.
///
/// ```dart
/// FoundryButton(label: 'Submit', onPressed: () {})
/// FoundryButton.icon(icon: Icon(Icons.add), onPressed: () {}, tooltip: 'Add')
/// ```
class FoundryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final String? label;
  final Widget? icon;
  final FoundryButtonVariant variant;
  final FoundryButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final bool expanded;
  final bool enableHaptics;
  final String? semanticLabel;
  final String? tooltip;

  const FoundryButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.label,
    this.icon,
    this.variant = FoundryButtonVariant.primary,
    this.size = FoundryButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.expanded = false,
    this.enableHaptics = true,
    this.semanticLabel,
    this.tooltip,
  }) : assert(label != null || icon != null, 'FoundryButton requires either a label or an icon.');

  const FoundryButton.icon({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.onLongPress,
    this.variant = FoundryButtonVariant.ghost,
    this.size = FoundryButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.enableHaptics = true,
    this.semanticLabel,
  }) : label = null,
       expanded = false;

  bool get _isEnabled => !isDisabled && !isLoading && onPressed != null;
  bool get _isIconOnly => label == null && icon != null;

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final typography = theme.typography;
    final spacing = theme.spacing;
    final radius = theme.radius;
    final motion = theme.motion;

    final sizeConfig = _resolveSizeConfig(spacing, typography);

    Widget button = FoundryInteractive(
      enabled: _isEnabled,
      onTap: _isEnabled ? () => _handleTap() : null,
      builder: (isHovered, isFocused, isPressed) {
        final buttonColors = _resolveColors(colors, isHovered, isPressed);

        return GestureDetector(
          onLongPress: _isEnabled ? onLongPress : null,
          child: AnimatedContainer(
            duration: motion.fast,
            curve: motion.easeInOut,
            padding: _isIconOnly ? FInsets.all(sizeConfig.iconPadding) : sizeConfig.padding,
            decoration: BoxDecoration(
              color: buttonColors.background,
              border: Border.all(
                color: isFocused ? colors.border.focus : buttonColors.border,
                width: isFocused ? FBorderWidth.medium : FBorderWidth.hairline,
              ),
              borderRadius: BorderRadius.circular(radius.md),
            ),
            child: Row(
              mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildContent(buttonColors.foreground, sizeConfig),
            ),
          ),
        );
      },
    );

    button = Semantics(button: true, enabled: _isEnabled, label: semanticLabel ?? tooltip ?? label, child: button);

    if (_isIconOnly && tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }

    return button;
  }

  void _handleTap() {
    if (enableHaptics) {
      HapticFeedback.lightImpact();
    }
    onPressed?.call();
  }

  _SizeConfig _resolveSizeConfig(SemanticSpacing spacing, SemanticTypography typography) {
    switch (size) {
      case FoundryButtonSize.small:
        return _SizeConfig(
          padding: FInsets.symmetric(horizontal: spacing.sm, vertical: spacing.xs),
          fontSize: typography.bodySmall,
          iconSize: FIconSize.sm,
          iconPadding: spacing.xs,
        );
      case FoundryButtonSize.medium:
        return _SizeConfig(
          padding: FInsets.symmetric(horizontal: spacing.md, vertical: spacing.sm),
          fontSize: typography.body,
          iconSize: FIconSize.md,
          iconPadding: spacing.sm,
        );
      case FoundryButtonSize.large:
        return _SizeConfig(
          padding: FInsets.symmetric(horizontal: spacing.lg, vertical: spacing.md),
          fontSize: typography.headingSmall,
          iconSize: FIconSize.lg,
          iconPadding: spacing.md,
        );
    }
  }

  _ButtonColors _resolveColors(SemanticColors colors, bool isHovered, bool isPressed) {
    if (!_isEnabled) {
      return _resolveDisabledColors(colors);
    }

    switch (variant) {
      case FoundryButtonVariant.primary:
        return _ButtonColors(
          background: isPressed
              ? colors.accent.active
              : isHovered
              ? colors.accent.hover
              : colors.button.primary.bg,
          foreground: colors.button.primary.fg,
          border: colors.button.primary.border,
        );
      case FoundryButtonVariant.secondary:
        return _ButtonColors(
          background: isPressed
              ? colors.state.active.bg!
              : isHovered
              ? colors.state.hover.bg!
              : colors.button.secondary.bg,
          foreground: colors.button.secondary.fg,
          border: colors.button.secondary.border,
        );
      case FoundryButtonVariant.outline:
        return _ButtonColors(
          background: isPressed
              ? colors.state.active.bg!
              : isHovered
              ? colors.state.hover.bg!
              : colors.bg.canvas,
          foreground: colors.fg.primary,
          border: isPressed || isHovered ? colors.border.strong : colors.border.base,
        );
      case FoundryButtonVariant.ghost:
        return _ButtonColors(
          background: isPressed
              ? colors.state.active.bg!
              : isHovered
              ? colors.state.hover.bg!
              : colors.bg.transparent,
          foreground: colors.fg.primary,
          border: colors.bg.transparent,
        );
      case FoundryButtonVariant.destructive:
        return _ButtonColors(
          background: isPressed || isHovered ? colors.status.negative.main : colors.status.negative.bg,
          foreground: isPressed || isHovered ? colors.fg.inverted : colors.status.negative.fg,
          border: colors.status.negative.border,
        );
    }
  }

  _ButtonColors _resolveDisabledColors(SemanticColors colors) {
    switch (variant) {
      case FoundryButtonVariant.ghost:
        return _ButtonColors(
          background: colors.bg.transparent,
          foreground: colors.state.disabled.fg!,
          border: colors.bg.transparent,
        );
      case FoundryButtonVariant.outline:
        return _ButtonColors(
          background: colors.bg.canvas,
          foreground: colors.state.disabled.fg!,
          border: colors.state.disabled.border!,
        );
      default:
        return _ButtonColors(
          background: colors.state.disabled.bg!,
          foreground: colors.state.disabled.fg!,
          border: colors.state.disabled.border ?? colors.border.muted,
        );
    }
  }

  List<Widget> _buildContent(Color foreground, _SizeConfig sizeConfig) {
    final widgets = <Widget>[];

    if (isLoading) {
      widgets.add(
        SizedBox(
          width: sizeConfig.iconSize,
          height: sizeConfig.iconSize,
          child: CircularProgressIndicator(
            strokeWidth: FBorderWidth.medium,
            valueColor: AlwaysStoppedAnimation<Color>(foreground),
          ),
        ),
      );
      if (label != null) widgets.add(FoundryGap.sm());
    } else if (icon != null) {
      widgets.add(
        IconTheme(
          data: IconThemeData(color: foreground, size: sizeConfig.iconSize),
          child: icon!,
        ),
      );
      if (label != null) widgets.add(FoundryGap.sm());
    }

    if (label != null) {
      widgets.add(
        Text(
          label!,
          style: TextStyle(color: foreground, fontSize: sizeConfig.fontSize, fontWeight: FontWeight.w500),
        ),
      );
    }

    return widgets;
  }
}
