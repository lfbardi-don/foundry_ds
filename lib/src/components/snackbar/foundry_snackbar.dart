import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';

/// Snackbar variants for different semantic meanings.
enum FoundrySnackbarVariant { neutral, info, positive, warning, negative }

/// An inline snackbar notification that appears at the bottom of the screen.
///
/// Unlike [FoundryToast] which auto-dismisses, snackbars persist until
/// user action or programmatic dismissal.
///
/// Use [FoundrySnackbar.show] to display a snackbar.
class FoundrySnackbar extends StatelessWidget {
  final String message;
  final FoundrySnackbarVariant variant;
  final String? actionLabel;
  final VoidCallback? onAction;
  final VoidCallback? onDismiss;
  final IconData? icon;

  const FoundrySnackbar({
    super.key,
    required this.message,
    this.variant = FoundrySnackbarVariant.neutral,
    this.actionLabel,
    this.onAction,
    this.onDismiss,
    this.icon,
  });

  /// Shows a snackbar notification.
  ///
  /// Returns a [FoundrySnackbarController] that can be used to dismiss
  /// the snackbar programmatically.
  static FoundrySnackbarController show({
    required BuildContext context,
    required String message,
    FoundrySnackbarVariant variant = FoundrySnackbarVariant.neutral,
    String? actionLabel,
    VoidCallback? onAction,
    Duration? duration,
    IconData? icon,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    late FoundrySnackbarController controller;

    void dismiss() {
      entry.remove();
    }

    controller = FoundrySnackbarController(dismiss: dismiss);

    entry = OverlayEntry(
      builder: (context) => _SnackbarOverlay(
        message: message,
        variant: variant,
        actionLabel: actionLabel,
        onAction: () {
          onAction?.call();
          dismiss();
        },
        onDismiss: dismiss,
        icon: icon,
        duration: duration,
      ),
    );

    overlay.insert(entry);
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    return _SnackbarContent(
      message: message,
      variant: variant,
      actionLabel: actionLabel,
      onAction: onAction,
      onDismiss: onDismiss,
      icon: icon,
    );
  }
}

/// Controller for programmatically dismissing a snackbar.
class FoundrySnackbarController {
  final VoidCallback _dismiss;

  FoundrySnackbarController({required VoidCallback dismiss}) : _dismiss = dismiss;

  void dismiss() => _dismiss();
}

class _SnackbarOverlay extends StatefulWidget {
  final String message;
  final FoundrySnackbarVariant variant;
  final String? actionLabel;
  final VoidCallback? onAction;
  final VoidCallback onDismiss;
  final IconData? icon;
  final Duration? duration;

  const _SnackbarOverlay({
    required this.message,
    required this.variant,
    this.actionLabel,
    this.onAction,
    required this.onDismiss,
    this.icon,
    this.duration,
  });

  @override
  State<_SnackbarOverlay> createState() => _SnackbarOverlayState();
}

class _SnackbarOverlayState extends State<_SnackbarOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _controller.forward();

    // Auto-dismiss if duration is provided
    if (widget.duration != null) {
      Future.delayed(widget.duration!, _dismiss);
    }
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

    return Positioned(
      left: FSpacing.md,
      right: FSpacing.md,
      bottom: mediaQuery.padding.bottom + FSpacing.md,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SafeArea(
            top: false,
            child: _SnackbarContent(
              message: widget.message,
              variant: widget.variant,
              actionLabel: widget.actionLabel,
              onAction: widget.onAction,
              onDismiss: _dismiss,
              icon: widget.icon,
            ),
          ),
        ),
      ),
    );
  }
}

class _SnackbarContent extends StatelessWidget {
  final String message;
  final FoundrySnackbarVariant variant;
  final String? actionLabel;
  final VoidCallback? onAction;
  final VoidCallback? onDismiss;
  final IconData? icon;

  const _SnackbarContent({
    required this.message,
    required this.variant,
    this.actionLabel,
    this.onAction,
    this.onDismiss,
    this.icon,
  });

  IconData? get _defaultIcon {
    switch (variant) {
      case FoundrySnackbarVariant.neutral:
        return null;
      case FoundrySnackbarVariant.info:
        return FIcons.info;
      case FoundrySnackbarVariant.positive:
        return FIcons.checkCircle;
      case FoundrySnackbarVariant.warning:
        return FIcons.alertTriangle;
      case FoundrySnackbarVariant.negative:
        return FIcons.alertCircle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final radius = theme.radius;
    final shadows = theme.shadows;
    final typography = theme.typography;

    Color bgColor;
    Color fgColor;
    Color? iconColor;

    switch (variant) {
      case FoundrySnackbarVariant.neutral:
        bgColor = colors.bg.inverted;
        fgColor = colors.fg.inverted;
        iconColor = colors.fg.inverted;
        break;
      case FoundrySnackbarVariant.info:
        bgColor = colors.bg.inverted;
        fgColor = colors.fg.inverted;
        iconColor = colors.status.info.main;
        break;
      case FoundrySnackbarVariant.positive:
        bgColor = colors.bg.inverted;
        fgColor = colors.fg.inverted;
        iconColor = colors.status.positive.main;
        break;
      case FoundrySnackbarVariant.warning:
        bgColor = colors.bg.inverted;
        fgColor = colors.fg.inverted;
        iconColor = colors.status.warning.main;
        break;
      case FoundrySnackbarVariant.negative:
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
        children: [
          if (displayIcon != null) ...[Icon(displayIcon, size: FIconSize.md, color: iconColor), const FoundryGap.sm()],
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: fgColor, fontSize: typography.body, fontFamily: typography.primary),
            ),
          ),
          if (actionLabel != null) ...[
            const FoundryGap.md(),
            GestureDetector(
              onTap: onAction,
              child: Text(
                actionLabel!,
                style: TextStyle(
                  color: colors.accent.base,
                  fontSize: typography.body,
                  fontWeight: typography.semibold,
                  fontFamily: typography.primary,
                ),
              ),
            ),
          ],
          if (onDismiss != null && actionLabel == null) ...[
            const FoundryGap.sm(),
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
