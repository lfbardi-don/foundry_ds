import 'dart:ui';

class SemanticColors {
  final BackgroundColors bg;
  final ForegroundColors fg;
  final BorderColors border;
  final AccentColors accent;
  final StatusColors status;
  final OpacityTokens opacity;
  final StateColors state;
  final LayoutColors layout;
  final ButtonColors button;
  final InputColors input;
  final CardColors card;
  final NavbarColors navbar;

  const SemanticColors({
    required this.bg,
    required this.fg,
    required this.border,
    required this.accent,
    required this.status,
    required this.opacity,
    required this.state,
    required this.layout,
    required this.button,
    required this.input,
    required this.card,
    required this.navbar,
  });
}

class BackgroundColors {
  final Color canvas;
  final Color muted;
  final Color emphasis;
  final Color inverted;
  final Color positive;
  final Color negative;
  final Color warning;
  final Color info;
  final Color transparent;

  const BackgroundColors({
    required this.canvas,
    required this.muted,
    required this.emphasis,
    required this.inverted,
    required this.positive,
    required this.negative,
    required this.warning,
    required this.info,
    required this.transparent,
  });
}

class ForegroundColors {
  final Color primary;
  final Color secondary;
  final Color muted;
  final Color inverted;
  final Color accent;
  final Color link;
  final Color positive;
  final Color negative;
  final Color warning;

  const ForegroundColors({
    required this.primary,
    required this.secondary,
    required this.muted,
    required this.inverted,
    required this.accent,
    required this.link,
    required this.positive,
    required this.negative,
    required this.warning,
  });
}

class BorderColors {
  final Color base;
  final Color muted;
  final Color strong;
  final Color focus;
  final Color accent;
  final Color positive;
  final Color negative;
  final Color transparent;

  const BorderColors({
    required this.base,
    required this.muted,
    required this.strong,
    required this.focus,
    required this.accent,
    required this.positive,
    required this.negative,
    required this.transparent,
  });
}

class AccentColors {
  final Color base;
  final Color hover;
  final Color active;
  final Color subtle;
  final Color fg;

  const AccentColors({
    required this.base,
    required this.hover,
    required this.active,
    required this.subtle,
    required this.fg,
  });
}

class StatusColors {
  final StatusColor positive;
  final StatusColor negative;
  final StatusColor warning;
  final StatusColor info;

  const StatusColors({required this.positive, required this.negative, required this.warning, required this.info});
}

class StatusColor {
  final Color bg;
  final Color fg;
  final Color border;
  final Color main;
  const StatusColor({required this.bg, required this.fg, required this.border, required this.main});
}

class OpacityTokens {
  final double disabled;
  final double hover;
  final double focus;
  final double active;
  final double overlay;
  final double hoverDark;
  final double pressedDark;

  const OpacityTokens({
    required this.disabled,
    required this.hover,
    required this.focus,
    required this.active,
    required this.overlay,
    required this.hoverDark,
    required this.pressedDark,
  });
}

class StateColors {
  final StateColor hover;
  final StateColor active;
  final StateColor disabled;

  const StateColors({required this.hover, required this.active, required this.disabled});
}

class StateColor {
  final Color? bg;
  final Color? fg;
  final Color? border;
  const StateColor({this.bg, this.fg, this.border});
}

class LayoutColors {
  final Color surface;
  final Color subtle;
  final Color elevated;
  final Color overlay;

  const LayoutColors({required this.surface, required this.subtle, required this.elevated, required this.overlay});
}

class ButtonColors {
  final ComponentColors primary;
  final ComponentColors secondary;

  const ButtonColors({required this.primary, required this.secondary});
}

class InputColors {
  final Color bg;
  final Color border;
  final Color placeholder;

  const InputColors({required this.bg, required this.border, required this.placeholder});
}

class CardColors {
  final Color bg;
  final Color border;

  const CardColors({required this.bg, required this.border});
}

class NavbarColors {
  final Color bg;
  final Color border;

  const NavbarColors({required this.bg, required this.border});
}

class ComponentColors {
  final Color bg;
  final Color fg;
  final Color border;
  const ComponentColors({required this.bg, required this.fg, required this.border});
}
