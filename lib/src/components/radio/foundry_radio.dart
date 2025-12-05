import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';

/// A radio button component for single selection within a group.
///
/// Use [FoundryRadio] with a `groupValue` to create radio button groups.
///
/// Example:
/// ```dart
/// FoundryRadio<String>(
///   value: 'option1',
///   groupValue: _selectedValue,
///   onChanged: (value) => setState(() => _selectedValue = value),
/// )
/// ```
class FoundryRadio<T> extends StatelessWidget {
  /// The value represented by this radio button.
  final T value;

  /// The currently selected value in the group.
  final T? groupValue;

  /// Called when this radio button is selected.
  final ValueChanged<T?>? onChanged;

  /// Whether the radio button is disabled.
  final bool isDisabled;

  /// Semantic label for accessibility.
  final String? label;

  const FoundryRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.isDisabled = false,
    this.label,
  });

  bool get _isSelected => value == groupValue;
  bool get _isEnabled => !isDisabled && onChanged != null;

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final motion = theme.motion;

    final borderColor = _isEnabled
        ? (_isSelected ? colors.accent.base : colors.border.base)
        : colors.state.disabled.border!;

    final fillColor = _isEnabled ? colors.accent.base : colors.state.disabled.fg!;

    return Semantics(
      selected: _isSelected,
      enabled: _isEnabled,
      label: label,
      inMutuallyExclusiveGroup: true,
      child: GestureDetector(
        onTap: _isEnabled ? () => onChanged!(value) : null,
        child: AnimatedContainer(
          duration: motion.fast,
          curve: motion.easeInOut,
          width: FControlSize.controlMd,
          height: FControlSize.controlMd,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: FBorderWidth.thin),
          ),
          alignment: Alignment.center,
          child: AnimatedContainer(
            duration: motion.fast,
            curve: motion.easeInOut,
            width: _isSelected ? FControlSize.controlInner : 0,
            height: _isSelected ? FControlSize.controlInner : 0,
            decoration: BoxDecoration(shape: BoxShape.circle, color: fillColor),
          ),
        ),
      ),
    );
  }
}

/// A radio button with an associated label.
///
/// Example:
/// ```dart
/// FoundryRadioTile<String>(
///   value: 'option1',
///   groupValue: _selectedValue,
///   onChanged: (value) => setState(() => _selectedValue = value),
///   label: 'Option 1',
///   description: 'Description for option 1',
/// )
/// ```
class FoundryRadioTile<T> extends StatelessWidget {
  /// The value represented by this radio button.
  final T value;

  /// The currently selected value in the group.
  final T? groupValue;

  /// Called when this radio button is selected.
  final ValueChanged<T?>? onChanged;

  /// The primary label text.
  final String label;

  /// Optional secondary description text.
  final String? description;

  /// Whether the tile is disabled.
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

/// A group of radio buttons displayed vertically.
///
/// Example:
/// ```dart
/// FoundryRadioGroup<String>(
///   children: [
///     FoundryRadioTile(value: 'a', groupValue: _selected, onChanged: _handleChange, label: 'Option A'),
///     FoundryRadioTile(value: 'b', groupValue: _selected, onChanged: _handleChange, label: 'Option B'),
///   ],
/// )
/// ```
class FoundryRadioGroup<T> extends StatelessWidget {
  /// The list of radio tiles to display.
  final List<FoundryRadioTile<T>> children;

  /// Spacing between radio tiles. Defaults to [FSpacing.sm].
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
