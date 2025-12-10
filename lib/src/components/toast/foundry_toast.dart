import 'package:flutter/material.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';
import 'package:foundry_ds/src/utils/foundry_interactive.dart';
import 'package:foundry_ds/src/semantic/semantic_colors.dart';

/// Visual variants for [FoundryToast].
enum FoundryToastVariant { neutral, info, positive, warning, negative }

/// Screen position for toast display.
enum FoundryToastPosition { top, bottom }

/// A temporary notification that auto-dismisses with optional progress indicator.
class FoundryToast extends StatefulWidget {
  final String message;
  final String? title;
  final FoundryToastVariant variant;
  final Duration duration;
  final VoidCallback? onDismiss;
  final IconData? icon;
  final bool showProgress;

  const FoundryToast({
    super.key,
    required this.message,
    this.title,
    this.variant = FoundryToastVariant.neutral,
    this.duration = FMotion.toastDisplay,
    this.onDismiss,
    this.icon,
    this.showProgress = true,
  });

  static void show({
    required BuildContext context,
    required String message,
    String? title,
    FoundryToastVariant variant = FoundryToastVariant.neutral,
    Duration duration = FMotion.toastDisplay,
    FoundryToastPosition position = FoundryToastPosition.bottom,
    IconData? icon,
    bool showProgress = true,
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
        showProgress: showProgress,
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
      showProgress: false,
      progressValue: 1.0,
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
  final bool showProgress;

  const _ToastOverlay({
    required this.message,
    this.title,
    required this.variant,
    required this.duration,
    required this.position,
    required this.onDismiss,
    this.icon,
    this.showProgress = true,
  });

  @override
  State<_ToastOverlay> createState() => _ToastOverlayState();
}

class _ToastOverlayState extends State<_ToastOverlay> with TickerProviderStateMixin {
  late AnimationController _entryController;
  late AnimationController _progressController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _entryController = AnimationController(vsync: this, duration: FMotion.slideIn);

    _fadeAnimation = CurvedAnimation(parent: _entryController, curve: FMotion.easeOut);

    final slideBegin = widget.position == FoundryToastPosition.top ? const Offset(0, -0.3) : const Offset(0, 0.3);

    _slideAnimation = Tween<Offset>(
      begin: slideBegin,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _entryController, curve: FMotion.easeOut));

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _entryController, curve: FMotion.easeOut));

    _entryController.forward();

    _progressController = AnimationController(vsync: this, duration: widget.duration);
    _progressController.forward();
    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _dismiss();
      }
    });
  }

  void _dismiss() {
    if (mounted) {
      _entryController.reverse().then((_) {
        widget.onDismiss();
      });
    }
  }

  @override
  void dispose() {
    _entryController.dispose();
    _progressController.dispose();
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
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: FLayout.toastMaxWidth),
                  child: AnimatedBuilder(
                    animation: _progressController,
                    builder: (context, child) {
                      return _ToastContent(
                        message: widget.message,
                        title: widget.title,
                        variant: widget.variant,
                        icon: widget.icon,
                        onDismiss: _dismiss,
                        showProgress: widget.showProgress,
                        progressValue: 1.0 - _progressController.value,
                      );
                    },
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

class _ToastContent extends StatelessWidget {
  final String message;
  final String? title;
  final FoundryToastVariant variant;
  final IconData? icon;
  final VoidCallback? onDismiss;
  final bool showProgress;
  final double progressValue;

  const _ToastContent({
    required this.message,
    this.title,
    required this.variant,
    this.icon,
    this.onDismiss,
    this.showProgress = true,
    this.progressValue = 1.0,
  });

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

  Color _getAccentColor(SemanticColors colors) {
    switch (variant) {
      case FoundryToastVariant.neutral:
        return colors.fg.primary;
      case FoundryToastVariant.info:
        return colors.status.info.main;
      case FoundryToastVariant.positive:
        return colors.status.positive.main;
      case FoundryToastVariant.warning:
        return colors.status.warning.main;
      case FoundryToastVariant.negative:
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: FControlSize.accentStripWidth,
                    constraints: const BoxConstraints(minHeight: FControlSize.toastMinHeight),
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radius.md),
                        bottomLeft: showProgress ? Radius.zero : Radius.circular(radius.md),
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
                            FoundryGap.sm(),
                          ],
                          Expanded(
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
                            FoundryInteractive(
                              onTap: onDismiss,
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
            if (showProgress)
              Container(
                height: FControlSize.accentStripWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(radius.md),
                    bottomRight: Radius.circular(radius.md),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Container(color: fgColor.withValues(alpha: 0.1)),
                    FractionallySizedBox(
                      widthFactor: progressValue,
                      alignment: Alignment.centerLeft,
                      child: Container(decoration: BoxDecoration(color: accentColor)),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
