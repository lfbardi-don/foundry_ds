import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';

/// A widget that provides Lenis-style smooth scrolling.
///
/// Wraps scrollable content to create a buttery smooth, interpolated
/// scroll experience similar to motion.dev and Lenis scroll libraries.
///
/// Example usage:
/// ```dart
/// FoundrySmoothScroll(
///   child: CustomScrollView(
///     primary: true, // Required to connect to the scroll controller
///     physics: const NeverScrollableScrollPhysics(),
///     slivers: [...],
///   ),
/// )
/// ```
class FoundrySmoothScroll extends StatefulWidget {
  /// The scrollable child widget.
  ///
  /// Must use `primary: true` and `NeverScrollableScrollPhysics`
  /// for the smooth scroll effect to work properly.
  final Widget child;

  /// Controls the interpolation speed.
  ///
  /// Lower values = smoother/slower scroll (e.g., 0.05)
  /// Higher values = snappier scroll (e.g., 0.15)
  /// Default is [FMotion.scrollSmoothness]
  final double smoothness;

  /// Optional external scroll controller.
  final ScrollController? controller;

  const FoundrySmoothScroll({
    super.key,
    required this.child,
    this.smoothness = FMotion.scrollSmoothness,
    this.controller,
  });

  @override
  State<FoundrySmoothScroll> createState() => _FoundrySmoothScrollState();
}

class _FoundrySmoothScrollState extends State<FoundrySmoothScroll> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late Ticker _ticker;

  double _targetScrollOffset = 0;
  double _currentScrollOffset = 0;
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    _ticker = createTicker(_onTick);
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    if (!_scrollController.hasClients) return;

    final diff = _targetScrollOffset - _currentScrollOffset;

    if (diff.abs() > 0.5) {
      _currentScrollOffset += diff * widget.smoothness;

      final maxScroll = _scrollController.position.maxScrollExtent;
      _currentScrollOffset = _currentScrollOffset.clamp(0.0, maxScroll);

      _scrollController.jumpTo(_currentScrollOffset);
      _isScrolling = true;
    } else if (_isScrolling) {
      _currentScrollOffset = _targetScrollOffset;
      _scrollController.jumpTo(_currentScrollOffset);
      _isScrolling = false;
    }
  }

  void _handleScroll(PointerScrollEvent event) {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    _targetScrollOffset += event.scrollDelta.dy;
    _targetScrollOffset = _targetScrollOffset.clamp(0.0, maxScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (event) {
        if (event is PointerScrollEvent) {
          _handleScroll(event);
        }
      },
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: PrimaryScrollController(controller: _scrollController, child: widget.child),
      ),
    );
  }
}
