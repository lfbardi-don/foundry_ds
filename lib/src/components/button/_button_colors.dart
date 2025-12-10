import 'package:flutter/material.dart';
import 'package:foundry_ds/src/semantic/semantic.dart';

import 'foundry_button.dart';

class ButtonColors {
  final Color background;
  final Color foreground;
  final Color border;

  const ButtonColors({required this.background, required this.foreground, required this.border});
}

class ButtonColorResolver {
  const ButtonColorResolver._();

  static ButtonColors resolve({
    required FoundryButtonVariant variant,
    required SemanticColors colors,
    required bool isEnabled,
    required bool isHovered,
    required bool isPressed,
  }) {
    if (!isEnabled) {
      return _resolveDisabled(variant, colors);
    }

    return switch (variant) {
      FoundryButtonVariant.primary => _primary(colors, isHovered, isPressed),
      FoundryButtonVariant.secondary => _secondary(colors, isHovered, isPressed),
      FoundryButtonVariant.outline => _outline(colors, isHovered, isPressed),
      FoundryButtonVariant.ghost => _ghost(colors, isHovered, isPressed),
      FoundryButtonVariant.destructive => _destructive(colors, isHovered, isPressed),
    };
  }

  static ButtonColors _primary(SemanticColors colors, bool isHovered, bool isPressed) {
    return ButtonColors(
      background: isPressed
          ? colors.accent.active
          : isHovered
          ? colors.accent.hover
          : colors.button.primary.bg,
      foreground: colors.button.primary.fg,
      border: colors.button.primary.border,
    );
  }

  static ButtonColors _secondary(SemanticColors colors, bool isHovered, bool isPressed) {
    return ButtonColors(
      background: isPressed
          ? colors.bg.inverted.withValues(alpha: colors.opacity.pressedDark)
          : isHovered
          ? colors.bg.inverted.withValues(alpha: colors.opacity.hoverDark)
          : colors.button.secondary.bg,
      foreground: colors.button.secondary.fg,
      border: colors.button.secondary.border,
    );
  }

  static ButtonColors _outline(SemanticColors colors, bool isHovered, bool isPressed) {
    return ButtonColors(
      background: isPressed
          ? colors.state.active.bg!
          : isHovered
          ? colors.state.hover.bg!
          : colors.bg.canvas,
      foreground: colors.fg.primary,
      border: isPressed || isHovered ? colors.border.strong : colors.border.base,
    );
  }

  static ButtonColors _ghost(SemanticColors colors, bool isHovered, bool isPressed) {
    final bg = isPressed
        ? colors.state.active.bg!
        : isHovered
        ? colors.state.hover.bg!
        : colors.bg.transparent;
    return ButtonColors(background: bg, foreground: colors.fg.primary, border: colors.bg.transparent);
  }

  static ButtonColors _destructive(SemanticColors colors, bool isHovered, bool isPressed) {
    return ButtonColors(
      background: isPressed
          ? colors.status.negative.main.withValues(alpha: colors.opacity.pressedDark)
          : isHovered
          ? colors.status.negative.main
          : colors.status.negative.bg,
      foreground: isPressed || isHovered ? colors.fg.inverted : colors.status.negative.fg,
      border: colors.status.negative.border,
    );
  }

  static ButtonColors _resolveDisabled(FoundryButtonVariant variant, SemanticColors colors) {
    return switch (variant) {
      FoundryButtonVariant.ghost => ButtonColors(
        background: colors.bg.transparent,
        foreground: colors.state.disabled.fg!,
        border: colors.bg.transparent,
      ),
      FoundryButtonVariant.outline => ButtonColors(
        background: colors.bg.canvas,
        foreground: colors.state.disabled.fg!,
        border: colors.state.disabled.border!,
      ),
      _ => ButtonColors(
        background: colors.state.disabled.bg!,
        foreground: colors.state.disabled.fg!,
        border: colors.state.disabled.border ?? colors.border.muted,
      ),
    };
  }
}
