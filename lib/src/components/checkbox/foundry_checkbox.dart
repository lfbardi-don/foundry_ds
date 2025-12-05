import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';

/// Checkbox state for tristate support.
enum FoundryCheckboxState { unchecked, checked, indeterminate }

/// A checkbox component with optional indeterminate state.
///
/// Supports standard two-state (checked/unchecked) and three-state
/// (checked/unchecked/indeterminate) modes via [tristate].
///
/// Example:
/// ```dart
/// FoundryCheckbox(
///   value: _isChecked,
///   onChanged: (value) => setState(() => _isChecked = value),
/// )
/// ```
class FoundryCheckbox extends StatelessWidget {
  /// The current value. `true` = checked, `false` = unchecked, `null` = indeterminate.
  final bool? value;

  /// Called when the user taps the checkbox.
  final ValueChanged<bool?>? onChanged;

  /// Whether to enable three-state mode (checked, unchecked, indeterminate).
  final bool tristate;

  /// Whether the checkbox is disabled.
  final bool isDisabled;

  /// Semantic label for accessibility.
  final String? label;

  const FoundryCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.tristate = false,
    this.isDisabled = false,
    this.label,
  });

  bool get _isEnabled => !isDisabled && onChanged != null;

  FoundryCheckboxState get _state {
    if (value == null) return FoundryCheckboxState.indeterminate;
    return value! ? FoundryCheckboxState.checked : FoundryCheckboxState.unchecked;
  }

  void _handleTap() {
    if (!_isEnabled) return;

    if (tristate) {
      switch (_state) {
        case FoundryCheckboxState.unchecked:
          onChanged!(true);
          break;
        case FoundryCheckboxState.checked:
          onChanged!(null);
          break;
        case FoundryCheckboxState.indeterminate:
          onChanged!(false);
          break;
      }
    } else {
      onChanged!(!(value ?? false));
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
        ? (isCheckedOrIndeterminate ? colors.accent.base : colors.bg.canvas)
        : colors.state.disabled.bg!;

    final borderColor = _isEnabled
        ? (isCheckedOrIndeterminate ? colors.accent.base : colors.border.base)
        : colors.state.disabled.border!;

    final iconColor = _isEnabled ? colors.accent.fg : colors.state.disabled.fg!;

    return Semantics(
      checked: _state == FoundryCheckboxState.checked,
      mixed: _state == FoundryCheckboxState.indeterminate,
      enabled: _isEnabled,
      label: label,
      child: GestureDetector(
        onTap: _isEnabled ? _handleTap : null,
        child: AnimatedContainer(
          duration: motion.fast,
          curve: motion.easeInOut,
          width: FControlSize.controlMd,
          height: FControlSize.controlMd,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(radius.xs),
            border: Border.all(color: borderColor, width: FBorderWidth.thin),
          ),
          child: AnimatedSwitcher(duration: motion.fast, child: _buildIcon(iconColor)),
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

/// A checkbox with an associated label.
///
/// Example:
/// ```dart
/// FoundryCheckboxTile(
///   value: _agreed,
///   onChanged: (value) => setState(() => _agreed = value),
///   label: 'I agree to terms',
///   description: 'By checking this you accept our terms of service.',
/// )
/// ```
class FoundryCheckboxTile extends StatelessWidget {
  /// The current value.
  final bool? value;

  /// Called when the user taps the tile or checkbox.
  final ValueChanged<bool?>? onChanged;

  /// The primary label text.
  final String label;

  /// Optional secondary description text.
  final String? description;

  /// Whether to enable three-state mode.
  final bool tristate;

  /// Whether the tile is disabled.
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
