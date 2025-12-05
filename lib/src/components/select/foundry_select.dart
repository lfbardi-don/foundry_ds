import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';

/// A dropdown select component for single-value selection.
///
/// Example:
/// ```dart
/// FoundrySelect<String>(
///   value: _selectedValue,
///   options: [
///     FoundrySelectOption(value: 'a', label: 'Option A'),
///     FoundrySelectOption(value: 'b', label: 'Option B'),
///   ],
///   onChanged: (value) => setState(() => _selectedValue = value),
///   placeholder: 'Select an option',
/// )
/// ```
class FoundrySelect<T> extends StatefulWidget {
  /// The currently selected value.
  final T? value;

  /// List of available options.
  final List<FoundrySelectOption<T>> options;

  /// Called when the selection changes.
  final ValueChanged<T?>? onChanged;

  /// Placeholder text when no value is selected.
  final String? placeholder;

  /// Optional label above the select.
  final String? label;

  /// Whether the select is disabled.
  final bool isDisabled;

  /// Error text to display below the select.
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
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  bool get _isEnabled => !widget.isDisabled && widget.onChanged != null;

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
          offset: Offset(0, size.height + 4),
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

    final borderColor = widget.errorText != null
        ? colors.status.negative.border
        : (_isOpen ? colors.border.focus : colors.input.border);

    final bgColor = _isEnabled ? colors.input.bg : colors.state.disabled.bg!;
    final textColor = widget.value != null
        ? (_isEnabled ? colors.fg.primary : colors.state.disabled.fg!)
        : colors.input.placeholder;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          FoundryText.bodySmall(widget.label!, weight: typography.medium, color: colors.fg.primary),
          const FoundryGap.xs(),
        ],
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: _toggleDropdown,
            child: Container(
              padding: FInsets.symmetric(horizontal: spacing.md, vertical: spacing.sm),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(radius.md),
                border: Border.all(color: borderColor, width: _isOpen ? FBorderWidth.medium : FBorderWidth.hairline),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _displayText,
                      style: TextStyle(color: textColor, fontSize: typography.body, fontFamily: typography.primary),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const FoundryGap.sm(),
                  Icon(
                    _isOpen ? FIcons.chevronUp : FIcons.chevronDown,
                    size: FIconSize.md,
                    color: _isEnabled ? colors.fg.secondary : colors.state.disabled.fg,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (widget.errorText != null) ...[
          const FoundryGap.xs(),
          FoundryText.caption(widget.errorText!, color: colors.status.negative.fg),
        ],
      ],
    );
  }
}

/// An option for [FoundrySelect].
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
    final spacing = theme.spacing;
    final typography = theme.typography;

    return TapRegion(
      onTapOutside: (_) => onDismiss(),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 200),
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
                final isDisabled = option.isDisabled;

                return GestureDetector(
                  onTap: isDisabled ? null : () => onSelect(option.value),
                  child: Container(
                    padding: FInsets.symmetric(horizontal: spacing.md, vertical: spacing.sm),
                    color: isSelected ? colors.accent.subtle : colors.bg.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            option.label,
                            style: TextStyle(
                              color: isDisabled
                                  ? colors.state.disabled.fg
                                  : (isSelected ? colors.accent.base : colors.fg.primary),
                              fontSize: typography.body,
                              fontWeight: isSelected ? typography.medium : typography.regular,
                              fontFamily: typography.primary,
                            ),
                          ),
                        ),
                        if (isSelected) Icon(FIcons.check, size: FIconSize.sm, color: colors.accent.base),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
