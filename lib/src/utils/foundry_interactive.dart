import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';

/// A wrapper that provides hover, focus, and press states to child widgets.
class FoundryInteractive extends StatefulWidget {
  final Widget Function(bool isHovered, bool isFocused, bool isPressed) builder;
  final VoidCallback? onTap;
  final bool enabled;
  final MouseCursor? cursor;
  final bool canRequestFocus;

  const FoundryInteractive({
    super.key,
    required this.builder,
    this.onTap,
    this.enabled = true,
    this.cursor,
    this.canRequestFocus = true,
  });

  @override
  State<FoundryInteractive> createState() => _FoundryInteractiveState();
}

class _FoundryInteractiveState extends State<FoundryInteractive> {
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isPressed = false;

  void _handleHoverChange(bool isHovered) {
    if (widget.enabled) {
      setState(() => _isHovered = isHovered);
    }
  }

  void _handleFocusChange(bool isFocused) {
    if (widget.enabled) {
      setState(() => _isFocused = isFocused);
    }
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.enabled) {
      setState(() => _isPressed = true);
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.enabled) {
      setState(() => _isPressed = false);
    }
  }

  void _handleTapCancel() {
    if (widget.enabled) {
      setState(() => _isPressed = false);
    }
  }

  void _handleTap() {
    if (widget.enabled && widget.onTap != null) {
      widget.onTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveHovered = widget.enabled && _isHovered;
    final effectiveFocused = widget.enabled && _isFocused;
    final effectivePressed = widget.enabled && _isPressed;

    return Focus(
      canRequestFocus: widget.enabled && widget.canRequestFocus,
      onFocusChange: _handleFocusChange,
      child: MouseRegion(
        cursor: widget.enabled ? (widget.cursor ?? SystemMouseCursors.click) : SystemMouseCursors.basic,
        onEnter: (_) => _handleHoverChange(true),
        onExit: (_) => _handleHoverChange(false),
        child: GestureDetector(
          onTap: widget.enabled ? _handleTap : null,
          onTapDown: widget.enabled ? _handleTapDown : null,
          onTapUp: widget.enabled ? _handleTapUp : null,
          onTapCancel: widget.enabled ? _handleTapCancel : null,
          behavior: HitTestBehavior.opaque,
          child: widget.builder(effectiveHovered, effectiveFocused, effectivePressed),
        ),
      ),
    );
  }
}

/// A visual focus ring indicator for accessibility.
class FoundryFocusRing extends StatefulWidget {
  final Widget child;

  final bool enabled;

  final Color? focusColor;

  const FoundryFocusRing({super.key, required this.child, this.enabled = true, this.focusColor});

  @override
  State<FoundryFocusRing> createState() => _FoundryFocusRingState();
}

class _FoundryFocusRingState extends State<FoundryFocusRing> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final radius = theme.radius;
    final motion = theme.motion;

    return Focus(
      canRequestFocus: false, // The child handles focus
      onFocusChange: (focused) {
        if (widget.enabled) {
          setState(() => _isFocused = focused);
        }
      },
      child: AnimatedContainer(
        duration: motion.fast,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius.md + 2),
          border: Border.all(
            color: _isFocused && widget.enabled
                ? (widget.focusColor ?? colors.border.focus)
                : colors.border.transparent,
            width: FBorderWidth.medium,
          ),
        ),
        padding: const EdgeInsets.all(2),
        child: widget.child,
      ),
    );
  }
}
