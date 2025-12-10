import 'package:flutter/material.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';
import 'package:foundry_ds/src/semantic/semantic_colors.dart';

/// Visual variants for [FoundrySnackbar].
enum FoundrySnackbarVariant { neutral, info, positive, warning, negative }

/// A bottom-anchored message bar with optional action button.
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
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: FMotion.snackbarEntry);

    final springCurve = FMotion.spring;

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: springCurve));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: FMotion.easeOut));

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: springCurve));

    _controller.forward();

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
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: SafeArea(
              top: false,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: FLayout.snackbarMaxWidth),
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

  Color _getAccentColor(SemanticColors colors) {
    switch (variant) {
      case FoundrySnackbarVariant.neutral:
        return colors.fg.primary;
      case FoundrySnackbarVariant.info:
        return colors.status.info.main;
      case FoundrySnackbarVariant.positive:
        return colors.status.positive.main;
      case FoundrySnackbarVariant.warning:
        return colors.status.warning.main;
      case FoundrySnackbarVariant.negative:
        return colors.status.negative.main;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final radius = theme.radius;
    final shadows = theme.shadows;

    final bgColor = colors.layout.elevated;
    final fgColor = colors.fg.primary;
    final accentColor = _getAccentColor(colors);
    final displayIcon = icon ?? _defaultIcon;

    return Material(
      type: MaterialType.transparency,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(radius.md),
          boxShadow: shadows.xl,
        ),
        clipBehavior: Clip.antiAlias,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: FControlSize.accentStripWidth,
                constraints: const BoxConstraints(minHeight: FControlSize.buttonMd),
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
                    children: [
                      if (displayIcon != null) ...[
                        Icon(displayIcon, size: FIconSize.md, color: accentColor),
                        const FoundryGap.sm(),
                      ],
                      Expanded(child: FoundryText.body(message, color: fgColor)),
                      if (actionLabel != null) ...[
                        const FoundryGap.md(),
                        FoundryButton(
                          onPressed: onAction,
                          variant: FoundryButtonVariant.ghost,
                          size: FoundryButtonSize.small,
                          child: Text(actionLabel!),
                        ),
                      ],
                      if (onDismiss != null && actionLabel == null) ...[
                        const FoundryGap.sm(),
                        FoundryButton.icon(
                          onPressed: onDismiss,
                          tooltip: 'Dismiss',
                          variant: FoundryButtonVariant.ghost,
                          size: FoundryButtonSize.small,
                          child: Icon(FIcons.close, size: FIconSize.sm),
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
    );
  }
}
