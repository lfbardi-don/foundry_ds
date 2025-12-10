import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';

/// Visual states for [FoundryCheckbox].
enum FoundryCheckboxState { unchecked, checked, indeterminate }

/// A checkbox with optional tristate support and animated transitions.
class FoundryCheckbox extends StatefulWidget {
  final bool? value;

  final ValueChanged<bool?>? onChanged;

  final bool tristate;

  final bool isDisabled;

  final String? label;

  const FoundryCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.tristate = false,
    this.isDisabled = false,
    this.label,
  });

  @override
  State<FoundryCheckbox> createState() => _FoundryCheckboxState();
}

class _FoundryCheckboxState extends State<FoundryCheckbox> {
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isPressed = false;

  bool get _isEnabled => !widget.isDisabled && widget.onChanged != null;

  FoundryCheckboxState get _state {
    if (widget.value == null) return FoundryCheckboxState.indeterminate;
    return widget.value! ? FoundryCheckboxState.checked : FoundryCheckboxState.unchecked;
  }

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
    if (!_isEnabled) return;

    if (widget.tristate) {
      switch (_state) {
        case FoundryCheckboxState.unchecked:
          widget.onChanged!(true);
          break;
        case FoundryCheckboxState.checked:
          widget.onChanged!(null);
          break;
        case FoundryCheckboxState.indeterminate:
          widget.onChanged!(false);
          break;
      }
    } else {
      widget.onChanged!(!(widget.value ?? false));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final radius = theme.radius;
    final motion = theme.motion;

    final isCheckedOrIndeterminate = _state != FoundryCheckboxState.unchecked;

    final bgColor = _isEnabled
        ? (isCheckedOrIndeterminate
              ? (_isHovered ? colors.accent.hover : colors.accent.base)
              : (_isHovered ? colors.state.hover.bg : colors.bg.canvas))
        : colors.state.disabled.bg!;

    final borderColor = _isEnabled
        ? (_isFocused
              ? colors.border.focus
              : isCheckedOrIndeterminate
              ? (_isHovered ? colors.accent.hover : colors.accent.base)
              : (_isHovered ? colors.border.strong : colors.border.base))
        : colors.state.disabled.border!;

    final iconColor = _isEnabled ? colors.accent.fg : colors.state.disabled.fg!;

    final scale = _isPressed ? 0.92 : 1.0;

    final shadow = _isEnabled && (_isHovered || _isFocused) && !_isPressed ? FShadow.xs : FShadow.none;

    return Semantics(
      checked: _state == FoundryCheckboxState.checked,
      mixed: _state == FoundryCheckboxState.indeterminate,
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
            child: AnimatedScale(
              scale: scale,
              duration: motion.fast,
              curve: motion.easeOut,
              child: AnimatedContainer(
                duration: motion.fast,
                curve: motion.easeInOut,
                width: FControlSize.controlMd,
                height: FControlSize.controlMd,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(radius.sm),
                  border: Border.all(color: borderColor, width: _isFocused ? FBorderWidth.medium : FBorderWidth.thin),
                  boxShadow: shadow,
                ),
                child: AnimatedSwitcher(
                  duration: motion.fast,
                  switchInCurve: motion.easeOut,
                  switchOutCurve: motion.accelerate,
                  child: _buildIcon(iconColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(Color color) {
    switch (_state) {
      case FoundryCheckboxState.checked:
        return Icon(FIcons.check, size: FControlSize.checkboxIconSize, color: color, key: const ValueKey('checked'));
      case FoundryCheckboxState.indeterminate:
        return Icon(
          FIcons.minus,
          size: FControlSize.checkboxIconSize,
          color: color,
          key: const ValueKey('indeterminate'),
        );
      case FoundryCheckboxState.unchecked:
        return const SizedBox.shrink(key: ValueKey('unchecked'));
    }
  }
}

/// A checkbox with an accompanying label and optional description.
class FoundryCheckboxTile extends StatelessWidget {
  final bool? value;

  final ValueChanged<bool?>? onChanged;

  final String label;

  final String? description;

  final bool tristate;

  final bool isDisabled;

  const FoundryCheckboxTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
    this.description,
    this.tristate = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;

    return GestureDetector(
      onTap: isDisabled || onChanged == null ? null : () => onChanged!(!(value ?? false)),
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: FInsets.topXxs,
            child: FoundryCheckbox(value: value, onChanged: onChanged, tristate: tristate, isDisabled: isDisabled),
          ),
          const FoundryGap.sm(),
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
        ],
      ),
    );
  }
}
