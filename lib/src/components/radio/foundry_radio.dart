import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';

/// A radio button for single-selection within a group.
class FoundryRadio<T> extends StatefulWidget {
  final T value;

  final T? groupValue;

  final ValueChanged<T?>? onChanged;

  final bool isDisabled;

  final String? label;

  const FoundryRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.isDisabled = false,
    this.label,
  });

  @override
  State<FoundryRadio<T>> createState() => _FoundryRadioState<T>();
}

class _FoundryRadioState<T> extends State<FoundryRadio<T>> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isPressed = false;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  bool get _isSelected => widget.value == widget.groupValue;
  bool get _isEnabled => !widget.isDisabled && widget.onChanged != null;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: FMotion.fast, vsync: this);
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: FMotion.spring));
    if (_isSelected) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(FoundryRadio<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isSelected != (oldWidget.value == oldWidget.groupValue)) {
      if (_isSelected) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
    if (_isEnabled) {
      widget.onChanged!(widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final motion = theme.motion;

    final ringColor = _isEnabled
        ? (_isSelected
              ? colors.accent.base
              : _isHovered
              ? colors.border.strong
              : colors.border.base)
        : colors.state.disabled.border!;

    final indicatorColor = _isEnabled ? colors.accent.base : colors.state.disabled.fg!;

    final scale = _isPressed ? 0.9 : 1.0;

    final shadow = _isEnabled && (_isHovered || _isFocused) && !_isPressed ? FShadow.xs : FShadow.none;

    return Semantics(
      selected: _isSelected,
      enabled: _isEnabled,
      label: widget.label,
      inMutuallyExclusiveGroup: true,
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
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ringColor,
                    width: _isSelected || _isFocused ? FBorderWidth.medium : FBorderWidth.thin,
                  ),
                  boxShadow: shadow,
                ),
                alignment: Alignment.center,
                child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        width: FControlSize.radioIndicator,
                        height: FControlSize.radioIndicator,
                        decoration: BoxDecoration(color: indicatorColor, shape: BoxShape.circle),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A radio button with an accompanying label and optional description.
class FoundryRadioTile<T> extends StatelessWidget {
  final T value;

  final T? groupValue;

  final ValueChanged<T?>? onChanged;

  final String label;

  final String? description;

  final bool isDisabled;

  const FoundryRadioTile({
    super.key,
    required this.value,
    required this.groupValue,
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
      onTap: isDisabled || onChanged == null ? null : () => onChanged!(value),
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: FInsets.topXxs,
            child: FoundryRadio<T>(value: value, groupValue: groupValue, onChanged: onChanged, isDisabled: isDisabled),
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

/// A vertical group of radio tiles with consistent spacing.
class FoundryRadioGroup<T> extends StatelessWidget {
  final List<FoundryRadioTile<T>> children;

  final double spacing;

  const FoundryRadioGroup({super.key, required this.children, this.spacing = FSpacing.sm});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < children.length; i++) ...[children[i], if (i < children.length - 1) FoundryGap(spacing)],
      ],
    );
  }
}
