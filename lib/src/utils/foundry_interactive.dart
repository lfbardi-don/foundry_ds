import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';

/// Provides consistent hover and focus states for interactive components.
///
/// Wraps any widget to add proper hover highlighting and keyboard focus
/// handling for web and desktop accessibility.
///
/// Example:
/// ```dart
/// FoundryInteractive(
///   onTap: _handleTap,
///   builder: (isHovered, isFocused) => Container(
///     color: isHovered ? colors.state.hover.bg : colors.bg.canvas,
///     child: Text('Interactive'),
///   ),
/// )
/// ```
class FoundryInteractive extends StatefulWidget {
  /// Builder that receives hover and focus states.
  final Widget Function(bool isHovered, bool isFocused) builder;

  /// Called when the widget is tapped/clicked.
  final VoidCallback? onTap;

  /// Whether the widget is enabled for interaction.
  final bool enabled;

  /// Custom cursor for hover state.
  final MouseCursor? cursor;

  /// Whether this widget can receive focus.
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

  void _handleTap() {
    if (widget.enabled && widget.onTap != null) {
      widget.onTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveHovered = widget.enabled && _isHovered;
    final effectiveFocused = widget.enabled && _isFocused;

    return Focus(
      canRequestFocus: widget.enabled && widget.canRequestFocus,
      onFocusChange: _handleFocusChange,
      child: MouseRegion(
        cursor: widget.enabled ? (widget.cursor ?? SystemMouseCursors.click) : SystemMouseCursors.basic,
        onEnter: (_) => _handleHoverChange(true),
        onExit: (_) => _handleHoverChange(false),
        child: GestureDetector(
          onTap: widget.enabled ? _handleTap : null,
          behavior: HitTestBehavior.opaque,
          child: widget.builder(effectiveHovered, effectiveFocused),
        ),
      ),
    );
  }
}

/// A focus ring wrapper that shows a visible outline when focused.
///
/// Use this to wrap interactive elements that need keyboard accessibility.
///
/// Example:
/// ```dart
/// FoundryFocusRing(
///   child: FoundryButton(onPressed: _submit, label: 'Submit'),
/// )
/// ```
class FoundryFocusRing extends StatefulWidget {
  /// The child widget to wrap with a focus ring.
  final Widget child;

  /// Whether the focus ring is enabled.
  final bool enabled;

  /// Custom focus ring color. Defaults to accent color.
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
