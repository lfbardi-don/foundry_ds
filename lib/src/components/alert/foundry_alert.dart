import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';
import 'package:foundry_ds/src/utils/foundry_interactive.dart';

/// Visual variants for [FoundryAlert].
enum FoundryAlertVariant { info, positive, warning, negative }

/// An inline alert banner for displaying contextual messages.
class FoundryAlert extends StatefulWidget {
  final FoundryAlertVariant variant;
  final String? title;
  final String description;
  final IconData? icon;
  final VoidCallback? onDismiss;

  final bool animate;

  const FoundryAlert({
    super.key,
    this.variant = FoundryAlertVariant.info,
    this.title,
    required this.description,
    this.icon,
    this.onDismiss,
    this.animate = true,
  });

  const FoundryAlert.info({
    super.key,
    this.title,
    required this.description,
    this.icon,
    this.onDismiss,
    this.animate = true,
  }) : variant = FoundryAlertVariant.info;

  const FoundryAlert.positive({
    super.key,
    this.title,
    required this.description,
    this.icon,
    this.onDismiss,
    this.animate = true,
  }) : variant = FoundryAlertVariant.positive;

  const FoundryAlert.warning({
    super.key,
    this.title,
    required this.description,
    this.icon,
    this.onDismiss,
    this.animate = true,
  }) : variant = FoundryAlertVariant.warning;

  const FoundryAlert.negative({
    super.key,
    this.title,
    required this.description,
    this.icon,
    this.onDismiss,
    this.animate = true,
  }) : variant = FoundryAlertVariant.negative;

  @override
  State<FoundryAlert> createState() => _FoundryAlertState();
}

class _FoundryAlertState extends State<FoundryAlert> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: FMotion.fadeIn);

    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: FMotion.easeOut);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: FMotion.decelerate));

    if (widget.animate) {
      _animationController.forward();
    } else {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleDismiss() {
    if (widget.onDismiss != null) {
      _animationController.reverse().then((_) {
        widget.onDismiss?.call();
      });
    }
  }

  IconData get _defaultIcon {
    switch (widget.variant) {
      case FoundryAlertVariant.info:
        return FIcons.info;
      case FoundryAlertVariant.positive:
        return FIcons.checkCircle;
      case FoundryAlertVariant.warning:
        return FIcons.alertTriangle;
      case FoundryAlertVariant.negative:
        return FIcons.alertCircle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final radius = theme.radius;
    final shadows = theme.shadows;

    Color bgColor;
    Color fgColor;
    Color accentColor;
    Color borderColor;

    switch (widget.variant) {
      case FoundryAlertVariant.info:
        bgColor = colors.status.info.bg;
        fgColor = colors.status.info.fg;
        accentColor = colors.status.info.main;
        borderColor = colors.status.info.border;
        break;
      case FoundryAlertVariant.positive:
        bgColor = colors.status.positive.bg;
        fgColor = colors.status.positive.fg;
        accentColor = colors.status.positive.main;
        borderColor = colors.status.positive.border;
        break;
      case FoundryAlertVariant.warning:
        bgColor = colors.status.warning.bg;
        fgColor = colors.status.warning.fg;
        accentColor = colors.status.warning.main;
        borderColor = colors.status.warning.border;
        break;
      case FoundryAlertVariant.negative:
        bgColor = colors.status.negative.bg;
        fgColor = colors.status.negative.fg;
        accentColor = colors.status.negative.main;
        borderColor = colors.status.negative.border;
        break;
    }

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(radius.md),
            border: Border.all(color: borderColor, width: FBorderWidth.hairline),
            boxShadow: shadows.sm,
          ),
          clipBehavior: Clip.antiAlias,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: FBorderWidth.accent,
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radius.md),
                      bottomLeft: Radius.circular(radius.md),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: FInsets.md,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(widget.icon ?? _defaultIcon, size: FIconSize.md, color: accentColor),
                        FoundryGap.sm(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (widget.title != null) ...[
                                FoundryText.body(widget.title!, weight: FontWeight.w600, color: fgColor),
                                FoundryGap.xs(),
                              ],
                              FoundryText.bodySmall(widget.description, color: fgColor),
                            ],
                          ),
                        ),
                        if (widget.onDismiss != null) ...[
                          FoundryGap.sm(),
                          FoundryInteractive(
                            onTap: _handleDismiss,
                            builder: (isHovered, isFocused, isPressed) {
                              return AnimatedOpacity(
                                duration: FMotion.fast,
                                opacity: isHovered || isPressed ? 0.7 : 1.0,
                                child: Icon(FIcons.close, size: FIconSize.sm, color: fgColor),
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
