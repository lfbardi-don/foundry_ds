import 'package:flutter/widgets.dart';

class TransparentAnimatedContainer extends StatelessWidget {
  final Color color;

  final Duration duration;

  final Curve curve;

  final BoxDecoration? decoration;

  final EdgeInsetsGeometry? padding;

  final EdgeInsetsGeometry? margin;

  final double? width;

  final double? height;

  final AlignmentGeometry? alignment;

  final Widget? child;

  const TransparentAnimatedContainer({
    super.key,
    required this.color,
    required this.duration,
    this.curve = Curves.linear,
    this.decoration,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.alignment,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isTransparent = color.a == 0;

    return AnimatedOpacity(
      opacity: isTransparent ? 0.0 : 1.0,
      duration: duration,
      curve: curve,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        alignment: alignment,
        decoration:
            decoration?.copyWith(color: isTransparent ? null : color) ??
            BoxDecoration(color: isTransparent ? null : color),
        child: child,
      ),
    );
  }
}

mixin TransparentColorHelper {
  static bool shouldSkipAnimation(Color from, Color to) {
    final fromTransparent = from.a == 0;
    final toTransparent = to.a == 0;
    return fromTransparent != toTransparent;
  }

  static Duration animationDuration(Color from, Color to, Duration normal) {
    return shouldSkipAnimation(from, to) ? Duration.zero : normal;
  }
}
