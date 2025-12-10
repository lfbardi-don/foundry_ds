import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/utils/utils.dart';
import 'package:foundry_ds/src/components/components.dart';
import 'package:foundry_ds/src/semantic/semantic.dart';

import '_button_colors.dart';
import '_button_sizes.dart';

/// Visual variants for [FoundryButton].
enum FoundryButtonVariant { primary, secondary, outline, ghost, destructive }

/// Size presets for [FoundryButton].
enum FoundryButtonSize { small, medium, large }

/// A versatile button component with multiple variants, sizes, and states.
///
/// Supports loading states, icons, haptic feedback, and accessibility.
class FoundryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
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
  final bool _isIconOnlyMode;

  final String? semanticLabel;
  final String? tooltip;

  const FoundryButton({
    super.key,
    required this.onPressed,
    this.child,
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
  }) : _isIconOnlyMode = false,
       assert(
         child != null || prefixIcon != null || suffixIcon != null,
         'FoundryButton requires at least a child, prefixIcon, or suffixIcon.',
       );

  const FoundryButton.icon({
    super.key,
    required this.child,
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
  }) : prefixIcon = null,
       suffixIcon = null,
       expanded = false,
       _isIconOnlyMode = true;

  bool get _isEnabled => !isDisabled && !isLoading && onPressed != null;

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

        final isTransparentBg = buttonColors.background.a == 0;

        final container = Stack(
          children: [
            Positioned.fill(
              child: AnimatedOpacity(
                opacity: isTransparentBg ? 0.0 : 1.0,
                duration: motion.fast,
                curve: motion.easeInOut,
                child: AnimatedContainer(
                  duration: motion.fast,
                  curve: motion.easeInOut,
                  decoration: BoxDecoration(
                    color: isTransparentBg ? null : buttonColors.background,
                    borderRadius: BorderRadius.circular(radius.md),
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: motion.fast,
              curve: motion.easeInOut,
              height: sizeConfig.height,
              padding: _isIconOnlyMode ? FInsets.all(sizeConfig.iconPadding) : sizeConfig.padding,
              decoration: BoxDecoration(
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
            ),
          ],
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

    button = Semantics(button: true, enabled: _isEnabled, label: semanticLabel ?? tooltip, child: button);

    if (_isIconOnlyMode && tooltip != null) {
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
      if (prefixIcon != null) {
        widgets.add(
          IconTheme(
            data: IconThemeData(color: foreground, size: sizeConfig.iconSize),
            child: prefixIcon!,
          ),
        );
        if (child != null || suffixIcon != null) widgets.add(FoundryGap.sm());
      }

      if (child != null) {
        widgets.add(
          Flexible(
            child: DefaultTextStyle(
              style: TextStyle(
                color: foreground,
                fontSize: sizeConfig.fontSize,
                fontWeight: typography.medium,
                height: typography.tight,
              ),
              child: IconTheme(
                data: IconThemeData(color: foreground, size: sizeConfig.iconSize),
                child: child!,
              ),
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
