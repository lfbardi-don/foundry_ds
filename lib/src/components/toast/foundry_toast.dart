import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';

/// Toast variants matching alert types.
enum FoundryToastVariant { neutral, info, positive, warning, negative }

/// Position where the toast appears.
enum FoundryToastPosition { top, bottom }

/// An auto-dismiss notification toast.
///
/// Use [FoundryToast.show] to display temporary notification messages.
class FoundryToast extends StatefulWidget {
  final String message;
  final String? title;
  final FoundryToastVariant variant;
  final Duration duration;
  final VoidCallback? onDismiss;
  final IconData? icon;

  const FoundryToast({
    super.key,
    required this.message,
    this.title,
    this.variant = FoundryToastVariant.neutral,
    this.duration = FMotion.toastDisplay,
    this.onDismiss,
    this.icon,
  });

  /// Shows a toast notification.
  static void show({
    required BuildContext context,
    required String message,
    String? title,
    FoundryToastVariant variant = FoundryToastVariant.neutral,
    Duration duration = FMotion.toastDisplay,
    FoundryToastPosition position = FoundryToastPosition.bottom,
    IconData? icon,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => _ToastOverlay(
        message: message,
        title: title,
        variant: variant,
        duration: duration,
        position: position,
        icon: icon,
        onDismiss: () => entry.remove(),
      ),
    );

    overlay.insert(entry);
  }

  @override
  State<FoundryToast> createState() => _FoundryToastState();
}

class _FoundryToastState extends State<FoundryToast> {
  @override
  Widget build(BuildContext context) {
    return _ToastContent(
      message: widget.message,
      title: widget.title,
      variant: widget.variant,
      icon: widget.icon,
      onDismiss: widget.onDismiss,
    );
  }
}

class _ToastOverlay extends StatefulWidget {
  final String message;
  final String? title;
  final FoundryToastVariant variant;
  final Duration duration;
  final FoundryToastPosition position;
  final VoidCallback onDismiss;
  final IconData? icon;

  const _ToastOverlay({
    required this.message,
    this.title,
    required this.variant,
    required this.duration,
    required this.position,
    required this.onDismiss,
    this.icon,
  });

  @override
  State<_ToastOverlay> createState() => _ToastOverlayState();
}

class _ToastOverlayState extends State<_ToastOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: FMotion.slideIn);

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    final slideBegin = widget.position == FoundryToastPosition.top ? const Offset(0, -1) : const Offset(0, 1);

    _slideAnimation = Tween<Offset>(
      begin: slideBegin,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    Future.delayed(widget.duration, _dismiss);
  }

  void _dismiss() {
    if (mounted) {
      _controller.reverse().then((_) {
        widget.onDismiss();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isTop = widget.position == FoundryToastPosition.top;

    return Positioned(
      left: FSpacing.md,
      right: FSpacing.md,
      top: isTop ? mediaQuery.padding.top + FSpacing.md : null,
      bottom: isTop ? null : mediaQuery.padding.bottom + FSpacing.md,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: _ToastContent(
                  message: widget.message,
                  title: widget.title,
                  variant: widget.variant,
                  icon: widget.icon,
                  onDismiss: _dismiss,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ToastContent extends StatelessWidget {
  final String message;
  final String? title;
  final FoundryToastVariant variant;
  final IconData? icon;
  final VoidCallback? onDismiss;

  const _ToastContent({required this.message, this.title, required this.variant, this.icon, this.onDismiss});

  IconData? get _defaultIcon {
    switch (variant) {
      case FoundryToastVariant.neutral:
        return null;
      case FoundryToastVariant.info:
        return FIcons.info;
      case FoundryToastVariant.positive:
        return FIcons.checkCircle;
      case FoundryToastVariant.warning:
        return FIcons.alertTriangle;
      case FoundryToastVariant.negative:
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
    Color? iconColor;

    switch (variant) {
      case FoundryToastVariant.neutral:
        bgColor = colors.bg.inverted;
        fgColor = colors.fg.inverted;
        iconColor = colors.fg.inverted;
        break;
      case FoundryToastVariant.info:
        bgColor = colors.bg.inverted;
        fgColor = colors.fg.inverted;
        iconColor = colors.status.info.main;
        break;
      case FoundryToastVariant.positive:
        bgColor = colors.bg.inverted;
        fgColor = colors.fg.inverted;
        iconColor = colors.status.positive.main;
        break;
      case FoundryToastVariant.warning:
        bgColor = colors.bg.inverted;
        fgColor = colors.fg.inverted;
        iconColor = colors.status.warning.main;
        break;
      case FoundryToastVariant.negative:
        bgColor = colors.bg.inverted;
        fgColor = colors.fg.inverted;
        iconColor = colors.status.negative.main;
        break;
    }

    final displayIcon = icon ?? _defaultIcon;

    return Container(
      padding: FInsets.md,
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(radius.md), boxShadow: shadows.lg),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (displayIcon != null) ...[Icon(displayIcon, size: FIconSize.md, color: iconColor), FoundryGap.sm()],
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null) ...[
                  FoundryText.body(title!, color: fgColor, weight: FontWeight.w600),
                  FoundryGap.xxs(),
                ],
                FoundryText.bodySmall(message, color: fgColor),
              ],
            ),
          ),
          if (onDismiss != null) ...[
            FoundryGap.sm(),
            GestureDetector(
              onTap: onDismiss,
              child: Icon(FIcons.close, size: FIconSize.sm, color: fgColor),
            ),
          ],
        ],
      ),
    );
  }
}
