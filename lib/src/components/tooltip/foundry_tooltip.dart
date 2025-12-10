import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';

/// A tooltip that displays contextual information on hover or long press.
class FoundryTooltip extends StatefulWidget {
  final Widget child;
  final String message;
  final Duration showDuration;

  const FoundryTooltip({
    super.key,
    required this.child,
    required this.message,
    this.showDuration = FMotion.tooltipDisplay,
  });

  @override
  State<FoundryTooltip> createState() => _FoundryTooltipState();
}

class _FoundryTooltipState extends State<FoundryTooltip> with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: FMotion.tooltip);
    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: FMotion.easeOut);
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _hideTooltip();
    _animationController.dispose();
    super.dispose();
  }

  void _showTooltip() {
    _hideTooltip();
    _hideTimer?.cancel();

    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final targetRect = renderBox.localToGlobal(Offset.zero) & renderBox.size;

    if (!mounted) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => _TooltipOverlay(message: widget.message, targetRect: targetRect, animation: _fadeAnimation),
    );

    overlay.insert(_overlayEntry!);
    _animationController.forward();

    _hideTimer = Timer(widget.showDuration, () {
      if (mounted) _hideTooltip();
    });
  }

  void _hideTooltip() {
    _hideTimer?.cancel();
    _hideTimer = null;
    if (_overlayEntry != null) {
      _animationController.reverse().then((_) {
        if (_overlayEntry != null) {
          _overlayEntry?.remove();
          _overlayEntry = null;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _showTooltip(),
      onExit: (_) => _hideTooltip(),
      child: GestureDetector(
        onLongPress: _showTooltip, // Keep for mobile
        child: widget.child,
      ),
    );
  }
}

class _TooltipOverlay extends StatelessWidget {
  final String message;
  final Rect targetRect;
  final Animation<double> animation;

  const _TooltipOverlay({required this.message, required this.targetRect, required this.animation});

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final radius = theme.radius;
    final spacing = theme.spacing;
    final shadows = theme.shadows;

    return CustomSingleChildLayout(
      delegate: _TooltipPositionDelegate(targetRect: targetRect, padding: MediaQuery.paddingOf(context)),
      child: FadeTransition(
        opacity: animation,
        child: Container(
          constraints: BoxConstraints(maxWidth: FControlSize.tooltipMaxWidth),
          padding: FInsets.symmetric(horizontal: spacing.sm, vertical: spacing.xs),
          decoration: BoxDecoration(
            color: colors.bg.inverted,
            borderRadius: BorderRadius.circular(radius.sm),
            boxShadow: shadows.md,
          ),
          child: FoundryText.bodySmall(message, color: colors.fg.inverted, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}

class _TooltipPositionDelegate extends SingleChildLayoutDelegate {
  final Rect targetRect;
  final EdgeInsets padding;
  static const double _gap = FSpacing.sm;
  static const double _screenEdgeMargin = FSpacing.sm;

  _TooltipPositionDelegate({required this.targetRect, required this.padding});

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.copyWith(minWidth: 0, minHeight: 0, maxWidth: constraints.maxWidth - (_screenEdgeMargin * 2));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double x = targetRect.center.dx - (childSize.width / 2);

    if (x < _screenEdgeMargin) {
      x = _screenEdgeMargin;
    } else if (x + childSize.width > size.width - _screenEdgeMargin) {
      x = size.width - _screenEdgeMargin - childSize.width;
    }

    double y = targetRect.top - childSize.height - _gap;

    final double topLimit = padding.top + _screenEdgeMargin;

    if (y < topLimit) {
      final double yBelow = targetRect.bottom + _gap;
      if (yBelow + childSize.height < size.height - padding.bottom - _screenEdgeMargin) {
        y = yBelow;
      } else {
        if (targetRect.top > size.height - targetRect.bottom) {
          y = topLimit;
        } else {
          y = size.height - padding.bottom - _screenEdgeMargin - childSize.height;
        }
      }
    }

    return Offset(x, y);
  }

  @override
  bool shouldRelayout(covariant _TooltipPositionDelegate oldDelegate) {
    return targetRect != oldDelegate.targetRect || padding != oldDelegate.padding;
  }
}
