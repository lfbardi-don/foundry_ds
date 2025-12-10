import 'package:flutter/material.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';

/// A dropdown select component for choosing from a list of options.
class FoundrySelect<T> extends StatefulWidget {
  final T? value;

  final List<FoundrySelectOption<T>> options;

  final ValueChanged<T?>? onChanged;

  final String? placeholder;

  final String? label;

  final bool isDisabled;

  final String? errorText;

  const FoundrySelect({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.placeholder,
    this.label,
    this.isDisabled = false,
    this.errorText,
  });

  @override
  State<FoundrySelect<T>> createState() => _FoundrySelectState<T>();
}

class _FoundrySelectState<T> extends State<FoundrySelect<T>> {
  bool _isOpen = false;
  bool _isHovered = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  bool get _isEnabled => !widget.isDisabled && widget.onChanged != null;

  void _handleHover(bool isHovered) {
    if (_isEnabled) {
      setState(() => _isHovered = isHovered);
    }
  }

  String get _displayText {
    if (widget.value == null) {
      return widget.placeholder ?? '';
    }
    final selectedOption = widget.options.firstWhere(
      (option) => option.value == widget.value,
      orElse: () => FoundrySelectOption(value: widget.value as T, label: ''),
    );
    return selectedOption.label;
  }

  void _toggleDropdown() {
    if (!_isEnabled) return;

    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isOpen = false);
  }

  void _selectOption(T value) {
    widget.onChanged?.call(value);
    _closeDropdown();
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + FSpacing.dropdownOffset),
          child: _FoundrySelectDropdown<T>(
            options: widget.options,
            selectedValue: widget.value,
            onSelect: _selectOption,
            onDismiss: _closeDropdown,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final typography = theme.typography;
    final radius = theme.radius;
    final spacing = theme.spacing;
    final motion = theme.motion;
    final shadows = theme.shadows;

    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    final borderColor = !_isEnabled
        ? colors.state.disabled.border ?? colors.border.muted
        : hasError
        ? colors.status.negative.border
        : _isOpen
        ? colors.fg.secondary
        : _isHovered
        ? colors.border.strong
        : colors.input.border;

    final backgroundColor = !_isEnabled
        ? colors.state.disabled.bg
        : _isHovered && !_isOpen
        ? colors.state.hover.bg
        : colors.input.bg;

    final textColor = widget.value != null
        ? (_isEnabled ? colors.fg.primary : colors.state.disabled.fg!)
        : colors.input.placeholder;

    final focusShadow = _isOpen && _isEnabled && !hasError ? shadows.sm : shadows.none;
    final errorShadow = _isOpen && _isEnabled && hasError ? shadows.xs : <BoxShadow>[];
    final effectiveShadow = hasError ? errorShadow : focusShadow;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          FoundryText.bodySmall(
            widget.label!,
            color: _isEnabled ? colors.fg.primary : colors.fg.muted,
            weight: typography.medium,
          ),
          const FoundryGap.xs(),
        ],
        CompositedTransformTarget(
          link: _layerLink,
          child: MouseRegion(
            cursor: _isEnabled ? SystemMouseCursors.click : SystemMouseCursors.forbidden,
            onEnter: (_) => _handleHover(true),
            onExit: (_) => _handleHover(false),
            child: GestureDetector(
              onTap: _toggleDropdown,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: FControlSize.buttonMd),
                child: AnimatedContainer(
                  duration: motion.fast,
                  curve: motion.easeOut,
                  padding: FInsets.symmetric(horizontal: spacing.md, vertical: spacing.sm),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(radius.md),
                    border: Border.all(color: borderColor, width: _isOpen ? FBorderWidth.medium : FBorderWidth.thin),
                    boxShadow: effectiveShadow,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _displayText,
                          style: TextStyle(
                            color: textColor,
                            fontSize: typography.body,
                            fontWeight: typography.regular,
                            fontFamily: typography.primary,
                            height: typography.snug,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const FoundryGap.sm(),
                      AnimatedRotation(
                        turns: _isOpen ? 0.5 : 0,
                        duration: motion.fast,
                        curve: motion.easeOut,
                        child: Icon(
                          FIcons.chevronDown,
                          size: FIconSize.md,
                          color: _isEnabled ? colors.fg.secondary : colors.state.disabled.fg,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (hasError) ...[
          const FoundryGap.xs(),
          FoundryText.caption(widget.errorText!, color: colors.status.negative.fg),
        ],
      ],
    );
  }
}

/// A selectable option for [FoundrySelect].
class FoundrySelectOption<T> {
  final T value;
  final String label;
  final bool isDisabled;

  const FoundrySelectOption({required this.value, required this.label, this.isDisabled = false});
}

class _FoundrySelectDropdown<T> extends StatelessWidget {
  final List<FoundrySelectOption<T>> options;
  final T? selectedValue;
  final ValueChanged<T> onSelect;
  final VoidCallback onDismiss;

  const _FoundrySelectDropdown({
    required this.options,
    required this.selectedValue,
    required this.onSelect,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final radius = theme.radius;
    final shadows = theme.shadows;

    return Material(
      type: MaterialType.transparency,
      child: TapRegion(
        onTapOutside: (_) => onDismiss(),
        child: Container(
          constraints: const BoxConstraints(maxHeight: FLayout.dropdownMaxHeight),
          decoration: BoxDecoration(
            color: colors.layout.surface,
            borderRadius: BorderRadius.circular(radius.md),
            boxShadow: shadows.md,
            border: Border.all(color: colors.border.base, width: FBorderWidth.hairline),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius.md),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: options.map((option) {
                  final isSelected = option.value == selectedValue;
                  return _SelectOptionItem<T>(option: option, isSelected: isSelected, onSelect: onSelect);
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectOptionItem<T> extends StatefulWidget {
  final FoundrySelectOption<T> option;
  final bool isSelected;
  final ValueChanged<T> onSelect;

  const _SelectOptionItem({required this.option, required this.isSelected, required this.onSelect});

  @override
  State<_SelectOptionItem<T>> createState() => _SelectOptionItemState<T>();
}

class _SelectOptionItemState<T> extends State<_SelectOptionItem<T>> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final spacing = theme.spacing;
    final typography = theme.typography;
    final motion = theme.motion;

    final isDisabled = widget.option.isDisabled;
    final isEnabled = !isDisabled;

    final bgColor = widget.isSelected
        ? colors.accent.subtle
        : (_isHovered ? colors.state.hover.bg : colors.bg.transparent);

    final showBg = widget.isSelected || _isHovered;

    return MouseRegion(
      cursor: isEnabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: isEnabled ? (_) => setState(() => _isHovered = true) : null,
      onExit: isEnabled ? (_) => setState(() => _isHovered = false) : null,
      child: GestureDetector(
        onTap: isDisabled ? null : () => widget.onSelect(widget.option.value),
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: motion.fast,
          child: Container(
            padding: FInsets.symmetric(horizontal: spacing.md, vertical: spacing.sm),
            color: showBg ? bgColor : null,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.option.label,
                    style: TextStyle(
                      color: isDisabled
                          ? colors.state.disabled.fg
                          : (widget.isSelected ? colors.accent.base : colors.fg.primary),
                      fontSize: typography.body,
                      fontWeight: widget.isSelected ? typography.medium : typography.regular,
                      fontFamily: typography.primary,
                    ),
                  ),
                ),
                if (widget.isSelected) Icon(FIcons.check, size: FIconSize.sm, color: colors.accent.base),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
