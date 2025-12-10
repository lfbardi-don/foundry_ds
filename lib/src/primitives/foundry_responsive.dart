import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';

enum FoundryBreakpoint { sm, md, lg, xl, xxl }

class FoundryResponsive extends StatelessWidget {
  final Widget Function(BuildContext context, FoundryBreakpoint breakpoint) builder;

  const FoundryResponsive({super.key, required this.builder});

  static FoundryBreakpoint breakpointOf(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width >= FLayout.xxl) return FoundryBreakpoint.xxl;
    if (width >= FLayout.xl) return FoundryBreakpoint.xl;
    if (width >= FLayout.lg) return FoundryBreakpoint.lg;
    if (width >= FLayout.md) return FoundryBreakpoint.md;
    return FoundryBreakpoint.sm;
  }

  static bool isMobile(BuildContext context) => breakpointOf(context) == FoundryBreakpoint.sm;

  static bool isTablet(BuildContext context) => breakpointOf(context) == FoundryBreakpoint.md;

  static bool isDesktop(BuildContext context) {
    final bp = breakpointOf(context);
    return bp == FoundryBreakpoint.lg || bp == FoundryBreakpoint.xl || bp == FoundryBreakpoint.xxl;
  }

  @override
  Widget build(BuildContext context) {
    return builder(context, breakpointOf(context));
  }
}

class FoundryResponsiveChild extends StatelessWidget {
  final Widget mobile;

  final Widget? tablet;

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
