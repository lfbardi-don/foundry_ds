import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/semantic/semantic.dart';
import 'dart:math' as math;

/// Progress indicator variants.
enum FoundryProgressVariant { linear, circular }

/// A progress indicator component for loading states.
///
/// Supports both linear and circular variants, as well as
/// determinate (with value) and indeterminate (loading) modes.
///
/// Example:
/// ```dart
/// // Determinate linear progress (50%)
/// FoundryProgress.linear(value: 0.5)
///
/// // Indeterminate circular spinner
/// FoundryProgress.circular()
/// ```
class FoundryProgress extends StatefulWidget {
  /// The progress value between 0.0 and 1.0. If null, shows indeterminate animation.
  final double? value;

  /// Whether to display linear or circular progress.
  final FoundryProgressVariant variant;

  /// Size of circular progress indicator. Defaults to 24.0.
  final double? size;

  /// Stroke width for circular progress. Defaults to [FBorderWidth.medium].
  final double? strokeWidth;

  /// Background track color.
  final Color? trackColor;

  /// Foreground progress color.
  final Color? progressColor;

  const FoundryProgress({
    super.key,
    this.value,
    this.variant = FoundryProgressVariant.linear,
    this.size,
    this.strokeWidth,
    this.trackColor,
    this.progressColor,
  }) : assert(value == null || (value >= 0 && value <= 1), 'Value must be between 0 and 1');

  /// Linear progress bar
  const FoundryProgress.linear({super.key, this.value, this.trackColor, this.progressColor})
    : variant = FoundryProgressVariant.linear,
      size = null,
      strokeWidth = null;

  /// Circular progress indicator
  const FoundryProgress.circular({
    super.key,
    this.value,
    this.size,
    this.strokeWidth,
    this.trackColor,
    this.progressColor,
  }) : variant = FoundryProgressVariant.circular;

  bool get isIndeterminate => value == null;

  @override
  State<FoundryProgress> createState() => _FoundryProgressState();
}

class _FoundryProgressState extends State<FoundryProgress> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    if (widget.isIndeterminate) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(FoundryProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isIndeterminate && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.isIndeterminate && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final radius = theme.radius;

    final track = widget.trackColor ?? colors.bg.emphasis;
    final progress = widget.progressColor ?? colors.accent.base;

    if (widget.variant == FoundryProgressVariant.circular) {
      return _buildCircular(track, progress, radius);
    }
    return _buildLinear(track, progress, radius);
  }

  Widget _buildLinear(Color track, Color progress, SemanticRadius radius) {
    return SizedBox(
      height: FControlSize.progressHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius.full),
        child: Stack(
          children: [
            // Track
            Container(color: track),
            // Progress
            if (widget.isIndeterminate)
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return FractionallySizedBox(
                    alignment: Alignment(-1 + _controller.value * 3, 0),
                    widthFactor: 0.3,
                    child: Container(
                      decoration: BoxDecoration(color: progress, borderRadius: BorderRadius.circular(radius.full)),
                    ),
                  );
                },
              )
            else
              FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: widget.value ?? 0,
                child: Container(color: progress),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircular(Color track, Color progress, SemanticRadius radius) {
    final size = widget.size ?? 24.0;
    final strokeWidth = widget.strokeWidth ?? FBorderWidth.medium;

    return SizedBox(
      width: size,
      height: size,
      child: widget.isIndeterminate
          ? AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: CustomPaint(
                    painter: _CircularProgressPainter(
                      trackColor: track,
                      progressColor: progress,
                      strokeWidth: strokeWidth,
                      value: 0.25,
                    ),
                  ),
                );
              },
            )
          : CustomPaint(
              painter: _CircularProgressPainter(
                trackColor: track,
                progressColor: progress,
                strokeWidth: strokeWidth,
                value: widget.value ?? 0,
              ),
            ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final Color trackColor;
  final Color progressColor;
  final double strokeWidth;
  final double value;

  _CircularProgressPainter({
    required this.trackColor,
    required this.progressColor,
    required this.strokeWidth,
    required this.value,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Track
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    // Progress
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      value * 2 * math.pi,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.progressColor != progressColor;
  }
}
