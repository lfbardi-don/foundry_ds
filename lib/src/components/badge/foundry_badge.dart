import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';

/// Visual variants for [FoundryBadge].
enum FoundryBadgeVariant { neutral, positive, negative, warning, info, accent }

/// Size presets for [FoundryBadge].
enum FoundryBadgeSize { small, medium }

/// A compact label for status, counts, or notifications.
class FoundryBadge extends StatefulWidget {
  final String? label;
  final int? count;
  final FoundryBadgeVariant variant;
  final FoundryBadgeSize size;
  final IconData? icon;
  final bool pulse;
  final bool dot;

  const FoundryBadge({
    super.key,
    this.label,
    this.count,
    this.variant = FoundryBadgeVariant.neutral,
    this.size = FoundryBadgeSize.medium,
    this.icon,
    this.pulse = false,
    this.dot = false,
  }) : assert(label != null || count != null || dot, 'Either label, count, or dot must be provided');

  const FoundryBadge.neutral({
    super.key,
    this.label,
    this.count,
    this.size = FoundryBadgeSize.medium,
    this.icon,
    this.pulse = false,
    this.dot = false,
  }) : variant = FoundryBadgeVariant.neutral,
       assert(label != null || count != null || dot);

  const FoundryBadge.positive({
    super.key,
    this.label,
    this.count,
    this.size = FoundryBadgeSize.medium,
    this.icon,
    this.pulse = false,
    this.dot = false,
  }) : variant = FoundryBadgeVariant.positive,
       assert(label != null || count != null || dot);

  const FoundryBadge.negative({
    super.key,
    this.label,
    this.count,
    this.size = FoundryBadgeSize.medium,
    this.icon,
    this.pulse = false,
    this.dot = false,
  }) : variant = FoundryBadgeVariant.negative,
       assert(label != null || count != null || dot);

  const FoundryBadge.warning({
    super.key,
    this.label,
    this.count,
    this.size = FoundryBadgeSize.medium,
    this.icon,
    this.pulse = false,
    this.dot = false,
  }) : variant = FoundryBadgeVariant.warning,
       assert(label != null || count != null || dot);

  const FoundryBadge.info({
    super.key,
    this.label,
    this.count,
    this.size = FoundryBadgeSize.medium,
    this.icon,
    this.pulse = false,
    this.dot = false,
  }) : variant = FoundryBadgeVariant.info,
       assert(label != null || count != null || dot);

  const FoundryBadge.accent({
    super.key,
    this.label,
    this.count,
    this.size = FoundryBadgeSize.medium,
    this.icon,
    this.pulse = false,
    this.dot = false,
  }) : variant = FoundryBadgeVariant.accent,
       assert(label != null || count != null || dot);

  const FoundryBadge.dot({super.key, this.variant = FoundryBadgeVariant.negative, this.pulse = true})
    : label = null,
      count = null,
      size = FoundryBadgeSize.small,
      icon = null,
      dot = true;

  @override
  State<FoundryBadge> createState() => _FoundryBadgeState();
}

class _FoundryBadgeState extends State<FoundryBadge> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: FMotion.pulse);

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(CurvedAnimation(parent: _pulseController, curve: FMotion.easeInOut));

    if (widget.pulse) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(FoundryBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.pulse != oldWidget.pulse) {
      if (widget.pulse) {
        _pulseController.repeat(reverse: true);
      } else {
        _pulseController.stop();
        _pulseController.value = 0;
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final typography = theme.typography;
    final radius = theme.radius;
    final spacing = theme.spacing;

    Color bgColor;
    Color fgColor;
    Color borderColor;

    switch (widget.variant) {
      case FoundryBadgeVariant.neutral:
        bgColor = colors.bg.muted;
        fgColor = colors.fg.secondary;
        borderColor = colors.border.muted;
        break;
      case FoundryBadgeVariant.positive:
        bgColor = colors.status.positive.bg;
        fgColor = colors.status.positive.fg;
        borderColor = colors.status.positive.border;
        break;
      case FoundryBadgeVariant.negative:
        bgColor = colors.status.negative.bg;
        fgColor = colors.status.negative.fg;
        borderColor = colors.status.negative.border;
        break;
      case FoundryBadgeVariant.warning:
        bgColor = colors.status.warning.bg;
        fgColor = colors.status.warning.fg;
        borderColor = colors.status.warning.border;
        break;
      case FoundryBadgeVariant.info:
        bgColor = colors.status.info.bg;
        fgColor = colors.status.info.fg;
        borderColor = colors.status.info.border;
        break;
      case FoundryBadgeVariant.accent:
        bgColor = colors.accent.subtle;
        fgColor = colors.accent.base;
        borderColor = colors.accent.base.withValues(alpha: 0.3);
        break;
    }

    if (widget.dot) {
      final dotSize = widget.size == FoundryBadgeSize.small ? FControlSize.badgeDotSm : FControlSize.badgeDotMd;
      final dotWidget = Container(
        width: dotSize,
        height: dotSize,
        decoration: BoxDecoration(
          color: fgColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: fgColor.withValues(alpha: 0.4),
              blurRadius: FShadow.glowBlur,
              spreadRadius: FShadow.glowSpread,
            ),
          ],
        ),
      );

      if (widget.pulse) {
        return AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(scale: _pulseAnimation.value, child: child);
          },
          child: dotWidget,
        );
      }
      return dotWidget;
    }

    final isSmall = widget.size == FoundryBadgeSize.small;
    final horizontalPadding = isSmall ? spacing.xs : spacing.sm;
    final verticalPadding = isSmall ? spacing.xxs : spacing.xs;
    final fontSize = isSmall ? typography.caption : typography.bodySmall;
    final iconSize = isSmall ? FControlSize.badgeIconSm : FControlSize.badgeIconMd;

    final displayText = widget.count != null ? (widget.count! > 99 ? '99+' : widget.count.toString()) : widget.label!;

    Widget badge = Container(
      padding: FInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(radius.full),
        border: Border.all(color: borderColor, width: FBorderWidth.hairline),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.icon != null) ...[Icon(widget.icon, size: iconSize, color: fgColor), FoundryGap.xxs()],
          Text(
            displayText,
            style: TextStyle(
              color: fgColor,
              fontSize: fontSize,
              fontWeight: typography.medium,
              fontFamily: typography.primary,
              height: typography.compact,
            ),
          ),
        ],
      ),
    );

    if (widget.pulse && widget.count != null) {
      return AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(scale: _pulseAnimation.value, child: child);
        },
        child: badge,
      );
    }

    return badge;
  }
}
