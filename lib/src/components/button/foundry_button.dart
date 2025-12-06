import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/utils/utils.dart';
import 'package:foundry_ds/src/components/components.dart';
import 'package:foundry_ds/src/semantic/semantic.dart';

import '_button_colors.dart';
import '_button_sizes.dart';

enum FoundryButtonVariant { primary, secondary, outline, ghost, destructive }

enum FoundryButtonSize { small, medium, large }

/// A [FoundryButton] component with multiple [FoundryButtonVariant], [FoundryButtonSize], and states.
///
/// Supports: primary, secondary, outline, ghost, and destructive variants.
/// Features: loading state, icon support (prefix/suffix), haptic feedback, accessibility.
///
/// ```dart
/// // Basic button
/// FoundryButton(label: 'Submit', onPressed: () {})
///
/// // With prefix and suffix icons
/// FoundryButton(
///   label: 'Download',
///   prefixIcon: Icon(LucideIcons.download),
///   suffixIcon: Icon(LucideIcons.arrowDown),
///   onPressed: () {},
/// )
///
/// // With minimum width
/// FoundryButton(label: 'OK', onPressed: () {}, minWidth: 120)
///
/// // Custom loading content
/// FoundryButton(
///   label: 'Submit',
///   onPressed: () {},
///   isLoading: true,
///   loadingContent: Text('Submitting...'),
/// )
///
/// // Icon-only button
/// FoundryButton.icon(icon: Icon(Icons.add), onPressed: () {}, tooltip: 'Add')
/// ```
class FoundryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? label;
  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FoundryButtonVariant variant;
  final FoundryButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final bool expanded;
  final bool enableHaptics;
  final double? minWidth;
  final Widget? loadingContent;

  final String? semanticLabel;
  final String? tooltip;

  const FoundryButton({
    super.key,
    required this.onPressed,
    this.label,
    this.icon,
    this.prefixIcon,
    this.suffixIcon,
    this.variant = FoundryButtonVariant.primary,
    this.size = FoundryButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.expanded = false,
    this.enableHaptics = true,
    this.minWidth,
    this.loadingContent,
    this.semanticLabel,
    this.tooltip,
  }) : assert(
         label != null || icon != null || prefixIcon != null || suffixIcon != null,
         'FoundryButton requires at least a label or icon.',
       );

  const FoundryButton.icon({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.variant = FoundryButtonVariant.ghost,
    this.size = FoundryButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.enableHaptics = true,
    this.minWidth,
    this.loadingContent,
    this.semanticLabel,
  }) : label = null,
       prefixIcon = null,
       suffixIcon = null,
       expanded = false;

  bool get _isEnabled => !isDisabled && !isLoading && onPressed != null;
  bool get _isIconOnly =>
      label == null &&
      (icon != null || prefixIcon != null || suffixIcon != null) &&
      (prefixIcon == null || suffixIcon == null);

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final typography = theme.typography;
    final spacing = theme.spacing;
    final radius = theme.radius;
    final motion = theme.motion;

    final sizeConfig = ButtonSizeConfig.forSize(size, spacing, typography);

    Widget button = FoundryInteractive(
      enabled: _isEnabled,
      onTap: _isEnabled ? () => _handleTap() : null,
      builder: (isHovered, isFocused, isPressed) {
        final effectiveHovered = isLoading ? false : isHovered;
        final effectivePressed = isLoading ? false : isPressed;

        final buttonColors = ButtonColorResolver.resolve(
          variant: variant,
          colors: colors,
          isEnabled: !isDisabled,
          isHovered: effectiveHovered,
          isPressed: effectivePressed,
        );

        final shouldAnimateColor =
            variant != FoundryButtonVariant.ghost &&
            buttonColors.background != colors.bg.transparent &&
            buttonColors.background.a > 0;

        final container = AnimatedContainer(
          duration: shouldAnimateColor ? motion.fast : Duration.zero,
          curve: motion.easeInOut,
          padding: _isIconOnly ? FInsets.all(sizeConfig.iconPadding) : sizeConfig.padding,
          decoration: BoxDecoration(
            color: buttonColors.background,
            border: Border.fromBorderSide(
              BorderSide(
                color: isFocused ? colors.border.focus : buttonColors.border,
                width: isFocused ? FBorderWidth.medium : FBorderWidth.hairline,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
            borderRadius: BorderRadius.circular(radius.md),
          ),
          child: Row(
            mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildContent(buttonColors.foreground, sizeConfig, typography),
          ),
        );

        return container;
      },
    );

    if (minWidth != null) {
      button = ConstrainedBox(
        constraints: BoxConstraints(minWidth: minWidth!),
        child: button,
      );
    }

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

  List<Widget> _buildContent(Color foreground, ButtonSizeConfiguration sizeConfig, SemanticTypography typography) {
    final widgets = <Widget>[];

    if (isLoading) {
      widgets.add(
        loadingContent ??
            SizedBox(
              width: sizeConfig.iconSize,
              height: sizeConfig.iconSize,
              child: CircularProgressIndicator(
                strokeWidth: FBorderWidth.medium,
                valueColor: AlwaysStoppedAnimation<Color>(foreground),
              ),
            ),
      );
    } else {
      final effectivePrefixIcon = icon ?? prefixIcon;

      if (effectivePrefixIcon != null) {
        widgets.add(
          IconTheme(
            data: IconThemeData(color: foreground, size: sizeConfig.iconSize),
            child: effectivePrefixIcon,
          ),
        );
        if (label != null || suffixIcon != null) widgets.add(FoundryGap.sm());
      }

      if (label != null) {
        widgets.add(
          Flexible(
            child: Text(
              label!,
              style: TextStyle(
                color: foreground,
                fontSize: sizeConfig.fontSize,
                fontWeight: typography.medium,
                height: typography.tight,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        );
        if (suffixIcon != null) widgets.add(FoundryGap.sm());
      }

      if (suffixIcon != null) {
        widgets.add(
          IconTheme(
            data: IconThemeData(color: foreground, size: sizeConfig.iconSize),
            child: suffixIcon!,
          ),
        );
      }
    }

    return widgets;
  }
}
