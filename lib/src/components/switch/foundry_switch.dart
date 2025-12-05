import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';

/// A toggle switch component with smooth animations.
///
/// Use [FoundrySwitch] for binary on/off settings.
class FoundrySwitch extends StatelessWidget {
  /// The current value of the switch.
  final bool value;

  /// Called when the user toggles the switch.
  final ValueChanged<bool>? onChanged;

  /// Whether the switch is disabled.
  final bool isDisabled;

  /// Semantic label for accessibility.
  final String? label;

  const FoundrySwitch({super.key, required this.value, required this.onChanged, this.isDisabled = false, this.label});

  bool get _isEnabled => !isDisabled && onChanged != null;

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final motion = theme.motion;
    final radius = theme.radius;

    final trackColor = _isEnabled ? (value ? colors.accent.base : colors.bg.emphasis) : colors.state.disabled.bg!;

    final thumbColor = _isEnabled ? colors.bg.canvas : colors.fg.muted;

    return Semantics(
      toggled: value,
      enabled: _isEnabled,
      label: label,
      child: GestureDetector(
        onTap: _isEnabled ? () => onChanged!(!value) : null,
        child: AnimatedContainer(
          duration: motion.fast,
          curve: motion.easeInOut,
          width: FControlSize.switchTrackWidth,
          height: FControlSize.switchTrackHeight,
          decoration: BoxDecoration(color: trackColor, borderRadius: BorderRadius.circular(radius.full)),
          child: AnimatedAlign(
            duration: motion.fast,
            curve: motion.easeInOut,
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: FControlSize.switchThumb,
              height: FControlSize.switchThumb,
              margin: const EdgeInsets.all(FControlSize.switchThumbPadding),
              decoration: BoxDecoration(color: thumbColor, shape: BoxShape.circle, boxShadow: FShadow.thumb),
            ),
          ),
        ),
      ),
    );
  }
}

/// A switch with an associated label.
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
