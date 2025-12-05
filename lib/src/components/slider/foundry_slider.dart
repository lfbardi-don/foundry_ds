import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';

import 'package:foundry_ds/src/components/components.dart';

/// A slider component for selecting numeric values.
///
/// Example:
/// ```dart
/// FoundrySlider(
///   value: _volume,
///   onChanged: (value) => setState(() => _volume = value),
///   min: 0,
///   max: 100,
/// )
/// ```
class FoundrySlider extends StatefulWidget {
  /// The current value.
  final double value;

  /// Called when the value changes.
  final ValueChanged<double>? onChanged;

  /// Called when the user starts dragging.
  final VoidCallback? onChangeStart;

  /// Called when the user stops dragging.
  final VoidCallback? onChangeEnd;

  /// Minimum value.
  final double min;

  /// Maximum value.
  final double max;

  /// Number of discrete divisions. If null, continuous.
  final int? divisions;

  /// Whether the slider is disabled.
  final bool isDisabled;

  /// Whether to show the current value label.
  final bool showLabel;

  /// Custom label formatter.
  final String Function(double value)? labelFormatter;

  const FoundrySlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.isDisabled = false,
    this.showLabel = false,
    this.labelFormatter,
  }) : assert(min < max, 'min must be less than max'),
       assert(value >= min && value <= max, 'value must be between min and max');

  @override
  State<FoundrySlider> createState() => _FoundrySliderState();
}

class _FoundrySliderState extends State<FoundrySlider> {
  bool _isDragging = false;

  bool get _isEnabled => !widget.isDisabled && widget.onChanged != null;

  double get _fraction => (widget.value - widget.min) / (widget.max - widget.min);

  String get _label {
    if (widget.labelFormatter != null) {
      return widget.labelFormatter!(widget.value);
    }
    return widget.value.toStringAsFixed(widget.divisions != null ? 0 : 1);
  }

  void _handleDragStart(DragStartDetails details) {
    if (!_isEnabled) return;
    setState(() => _isDragging = true);
    widget.onChangeStart?.call();
  }

  void _handleDragUpdate(DragUpdateDetails details, double trackWidth) {
    if (!_isEnabled) return;

    final localX = details.localPosition.dx.clamp(0.0, trackWidth);
    var fraction = localX / trackWidth;

    if (widget.divisions != null) {
      fraction = (fraction * widget.divisions!).round() / widget.divisions!;
    }

    final newValue = widget.min + fraction * (widget.max - widget.min);
    widget.onChanged?.call(newValue.clamp(widget.min, widget.max));
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!_isEnabled) return;
    setState(() => _isDragging = false);
    widget.onChangeEnd?.call();
  }

  void _handleTap(TapDownDetails details, double trackWidth) {
    if (!_isEnabled) return;

    final localX = details.localPosition.dx.clamp(0.0, trackWidth);
    var fraction = localX / trackWidth;

    if (widget.divisions != null) {
      fraction = (fraction * widget.divisions!).round() / widget.divisions!;
    }

    final newValue = widget.min + fraction * (widget.max - widget.min);
    widget.onChanged?.call(newValue.clamp(widget.min, widget.max));
  }

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final radius = theme.radius;
    final motion = theme.motion;

    final trackColor = _isEnabled ? colors.bg.emphasis : colors.state.disabled.bg!;
    final activeColor = _isEnabled ? colors.accent.base : colors.state.disabled.fg!;
    final thumbColor = _isEnabled ? colors.bg.canvas : colors.fg.muted;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showLabel) ...[FoundryText.bodySmall(_label, color: colors.fg.secondary), const FoundryGap.xs()],
        LayoutBuilder(
          builder: (context, constraints) {
            final trackWidth = constraints.maxWidth;
            const thumbSize = FControlSize.switchThumb; // 20px
            const trackHeight = FControlSize.progressHeight; // 4px

            return GestureDetector(
              onTapDown: (details) => _handleTap(details, trackWidth),
              onHorizontalDragStart: _handleDragStart,
              onHorizontalDragUpdate: (details) => _handleDragUpdate(details, trackWidth),
              onHorizontalDragEnd: _handleDragEnd,
              child: SizedBox(
                height: thumbSize,
                width: trackWidth,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Track background
                    Container(
                      height: trackHeight,
                      decoration: BoxDecoration(color: trackColor, borderRadius: BorderRadius.circular(radius.full)),
                    ),
                    // Active track
                    Positioned(
                      left: 0,
                      child: AnimatedContainer(
                        duration: _isDragging ? Duration.zero : motion.fast,
                        height: trackHeight,
                        width: _fraction * trackWidth,
                        decoration: BoxDecoration(color: activeColor, borderRadius: BorderRadius.circular(radius.full)),
                      ),
                    ),
                    // Divisions marks
                    if (widget.divisions != null)
                      ...List.generate(widget.divisions! + 1, (index) {
                        final markFraction = index / widget.divisions!;
                        return Positioned(
                          left: markFraction * (trackWidth - FBorderWidth.medium) + 1,
                          child: Container(
                            width: FBorderWidth.medium,
                            height: trackHeight,
                            color: markFraction <= _fraction ? activeColor : trackColor,
                          ),
                        );
                      }),
                    // Thumb
                    Positioned(
                      left: (_fraction * (trackWidth - thumbSize)).clamp(0.0, trackWidth - thumbSize),
                      child: AnimatedContainer(
                        duration: _isDragging ? Duration.zero : motion.fast,
                        width: thumbSize,
                        height: thumbSize,
                        decoration: BoxDecoration(
                          color: thumbColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _isDragging ? colors.border.focus : colors.border.base,
                            width: _isDragging ? FBorderWidth.medium : FBorderWidth.hairline,
                          ),
                          boxShadow: FShadow.thumb,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

/// A slider with label and optional min/max labels.
class FoundrySliderTile extends StatelessWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final String label;
  final double min;
  final double max;
  final int? divisions;
  final bool isDisabled;
  final String? minLabel;
  final String? maxLabel;

  const FoundrySliderTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.isDisabled = false,
    this.minLabel,
    this.maxLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FoundryText.body(label, color: isDisabled ? colors.state.disabled.fg : colors.fg.primary),
        const FoundryGap.sm(),
        FoundrySlider(
          value: value,
          onChanged: onChanged,
          min: min,
          max: max,
          divisions: divisions,
          isDisabled: isDisabled,
        ),
        if (minLabel != null || maxLabel != null) ...[
          const FoundryGap.xs(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (minLabel != null) FoundryText.caption(minLabel!, color: colors.fg.muted) else const SizedBox.shrink(),
              if (maxLabel != null) FoundryText.caption(maxLabel!, color: colors.fg.muted) else const SizedBox.shrink(),
            ],
          ),
        ],
      ],
    );
  }
}
