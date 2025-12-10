import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/semantic/semantic.dart';
import 'dart:math' as math;

/// Shape variants for [FoundryProgress].
enum FoundryProgressVariant { linear, circular }

/// A progress indicator supporting determinate and indeterminate states.
class FoundryProgress extends StatefulWidget {
  final double? value;

  final FoundryProgressVariant variant;

  final double? size;

  final double? strokeWidth;

  final Color? trackColor;

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

  const FoundryProgress.linear({super.key, this.value, this.trackColor, this.progressColor})
    : variant = FoundryProgressVariant.linear,
      size = null,
      strokeWidth = null;

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

    _controller = AnimationController(vsync: this, duration: FMotion.spin);

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
            Container(color: track),
            if (widget.isIndeterminate)
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final position = math.sin(_controller.value * math.pi * 2);
                  return FractionallySizedBox(
                    alignment: Alignment(position, 0),
                    widthFactor: 0.3,
                    child: Container(
                      decoration: BoxDecoration(color: progress, borderRadius: BorderRadius.circular(radius.full)),
                    ),
                  );
                },
              )
            else
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: widget.value ?? 0),
                duration: FMotion.normal,
                curve: FMotion.easeOut,
                builder: (context, value, child) {
                  return FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: value,
                    child: Container(color: progress),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircular(Color track, Color progress, SemanticRadius radius) {
    final size = widget.size ?? FControlSize.progressCircular;
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
          : TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: widget.value ?? 0),
              duration: FMotion.normal,
              curve: FMotion.easeOut,
              builder: (context, value, child) {
                return CustomPaint(
                  painter: _CircularProgressPainter(
                    trackColor: track,
                    progressColor: progress,
                    strokeWidth: strokeWidth,
                    value: value,
                  ),
                );
              },
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

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

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
