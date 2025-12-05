import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';

/// Breakpoint size based on [FLayout] tokens.
enum FoundryBreakpoint { sm, md, lg, xl, xxl }

/// A builder widget for responsive layouts based on [FLayout] breakpoints.
///
/// Provides the current breakpoint to build different layouts for different
/// screen sizes.
class FoundryResponsive extends StatelessWidget {
  /// Builder function that receives the current breakpoint.
  final Widget Function(BuildContext context, FoundryBreakpoint breakpoint) builder;

  const FoundryResponsive({super.key, required this.builder});

  /// Returns the current breakpoint based on screen width.
  static FoundryBreakpoint breakpointOf(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width >= FLayout.xxl) return FoundryBreakpoint.xxl;
    if (width >= FLayout.xl) return FoundryBreakpoint.xl;
    if (width >= FLayout.lg) return FoundryBreakpoint.lg;
    if (width >= FLayout.md) return FoundryBreakpoint.md;
    return FoundryBreakpoint.sm;
  }

  /// Check if current screen is mobile (sm)
  static bool isMobile(BuildContext context) => breakpointOf(context) == FoundryBreakpoint.sm;

  /// Check if current screen is tablet (md)
  static bool isTablet(BuildContext context) => breakpointOf(context) == FoundryBreakpoint.md;

  /// Check if current screen is desktop (lg or above)
  static bool isDesktop(BuildContext context) {
    final bp = breakpointOf(context);
    return bp == FoundryBreakpoint.lg || bp == FoundryBreakpoint.xl || bp == FoundryBreakpoint.xxl;
  }

  @override
  Widget build(BuildContext context) {
    return builder(context, breakpointOf(context));
  }
}

/// A widget that shows different children based on breakpoints.
///
/// Simpler alternative to [FoundryResponsive] when you just need different
/// widgets for mobile/tablet/desktop.
class FoundryResponsiveChild extends StatelessWidget {
  /// Widget to show on mobile (sm breakpoint)
  final Widget mobile;

  /// Widget to show on tablet (md breakpoint). Falls back to [mobile] if not provided.
  final Widget? tablet;

  /// Widget to show on desktop (lg+ breakpoint). Falls back to [tablet] or [mobile] if not provided.
  final Widget? desktop;

  const FoundryResponsiveChild({super.key, required this.mobile, this.tablet, this.desktop});

  @override
  Widget build(BuildContext context) {
    final bp = FoundryResponsive.breakpointOf(context);

    switch (bp) {
      case FoundryBreakpoint.sm:
        return mobile;
      case FoundryBreakpoint.md:
        return tablet ?? mobile;
      case FoundryBreakpoint.lg:
      case FoundryBreakpoint.xl:
      case FoundryBreakpoint.xxl:
        return desktop ?? tablet ?? mobile;
    }
  }
}

/// A responsive value helper for selecting values based on breakpoint.
class FoundryResponsiveValue<T> {
  final T mobile;
  final T? tablet;
  final T? desktop;

  const FoundryResponsiveValue({required this.mobile, this.tablet, this.desktop});

  T resolve(BuildContext context) {
    final bp = FoundryResponsive.breakpointOf(context);

    switch (bp) {
      case FoundryBreakpoint.sm:
        return mobile;
      case FoundryBreakpoint.md:
        return tablet ?? mobile;
      case FoundryBreakpoint.lg:
      case FoundryBreakpoint.xl:
      case FoundryBreakpoint.xxl:
        return desktop ?? tablet ?? mobile;
    }
  }
}
