import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';

/// A toggle switch for binary on/off states.
class FoundrySwitch extends StatefulWidget {
  final bool value;

  final ValueChanged<bool>? onChanged;

  final bool isDisabled;

  final String? label;

  const FoundrySwitch({super.key, required this.value, required this.onChanged, this.isDisabled = false, this.label});

  @override
  State<FoundrySwitch> createState() => _FoundrySwitchState();
}

class _FoundrySwitchState extends State<FoundrySwitch> {
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isPressed = false;

  bool get _isEnabled => !widget.isDisabled && widget.onChanged != null;

  void _handleHoverChange(bool isHovered) {
    if (_isEnabled) {
      setState(() => _isHovered = isHovered);
    }
  }

  void _handleFocusChange(bool isFocused) {
    if (_isEnabled) {
      setState(() => _isFocused = isFocused);
    }
  }

  void _handleTapDown(TapDownDetails details) {
    if (_isEnabled) {
      setState(() => _isPressed = true);
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (_isEnabled) {
      setState(() => _isPressed = false);
    }
  }

  void _handleTapCancel() {
    if (_isEnabled) {
      setState(() => _isPressed = false);
    }
  }

  void _handleTap() {
    if (_isEnabled) {
      widget.onChanged!(!widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final motion = theme.motion;
    final radius = theme.radius;
    final shadows = theme.shadows;

    final trackColor = widget.value
        ? (_isEnabled ? colors.accent.base : colors.accent.base.withValues(alpha: 0.5))
        : (_isEnabled ? colors.bg.emphasis : colors.state.disabled.bg!);

    final thumbColor = _isEnabled ? colors.bg.canvas : colors.fg.muted;
    final thumbScale = _isPressed ? 0.92 : (_isHovered ? 1.05 : 1.0);

    final trackShadow = _isEnabled && (_isHovered || _isFocused) && !_isPressed ? shadows.sm : shadows.none;

    return Semantics(
      toggled: widget.value,
      enabled: _isEnabled,
      label: widget.label,
      child: Focus(
        canRequestFocus: _isEnabled,
        onFocusChange: _handleFocusChange,
        child: MouseRegion(
          cursor: _isEnabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
          onEnter: (_) => _handleHoverChange(true),
          onExit: (_) => _handleHoverChange(false),
          child: GestureDetector(
            onTap: _isEnabled ? _handleTap : null,
            onTapDown: _isEnabled ? _handleTapDown : null,
            onTapUp: _isEnabled ? _handleTapUp : null,
            onTapCancel: _isEnabled ? _handleTapCancel : null,
            child: AnimatedContainer(
              duration: motion.fast,
              curve: motion.easeInOut,
              width: FControlSize.switchTrackWidth,
              height: FControlSize.switchTrackHeight,
              decoration: BoxDecoration(
                color: trackColor,
                borderRadius: BorderRadius.circular(radius.full),
                boxShadow: trackShadow,
              ),
              child: AnimatedAlign(
                duration: motion.fast,
                curve: motion.easeInOut,
                alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
                child: AnimatedScale(
                  scale: thumbScale,
                  duration: motion.fast,
                  curve: motion.easeOut,
                  child: Container(
                    width: FControlSize.switchThumb,
                    height: FControlSize.switchThumb,
                    margin: const EdgeInsets.all(FControlSize.switchThumbPadding),
                    decoration: BoxDecoration(color: thumbColor, shape: BoxShape.circle, boxShadow: shadows.sm),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A switch with an accompanying label and optional description.
class FoundrySwitchTile extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String label;
  final String? description;
  final bool isDisabled;

  const FoundrySwitchTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
    this.description,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;

    return GestureDetector(
      onTap: isDisabled || onChanged == null ? null : () => onChanged!(!value),
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                FoundryText.body(label, color: isDisabled ? colors.state.disabled.fg : colors.fg.primary),
                if (description != null) ...[
                  const FoundryGap.xs(),
                  FoundryText.bodySmall(
                    description!,
                    color: isDisabled ? colors.state.disabled.fg : colors.fg.secondary,
                  ),
                ],
              ],
            ),
          ),
          const FoundryGap.md(),
          FoundrySwitch(value: value, onChanged: onChanged, isDisabled: isDisabled),
        ],
      ),
    );
  }
}
