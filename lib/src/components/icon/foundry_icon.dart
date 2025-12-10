import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';

/// Size presets for [FoundryIcon].
enum FoundryIconSize { xs, sm, md, lg, xl, xxl }

/// An icon widget using the design system's size scale.
class FoundryIcon extends StatelessWidget {
  final IconData icon;
  final FoundryIconSize size;
  final Color? color;

  const FoundryIcon(this.icon, {super.key, this.size = FoundryIconSize.md, this.color});

  const FoundryIcon.xs(this.icon, {super.key, this.color}) : size = FoundryIconSize.xs;
  const FoundryIcon.sm(this.icon, {super.key, this.color}) : size = FoundryIconSize.sm;
  const FoundryIcon.md(this.icon, {super.key, this.color}) : size = FoundryIconSize.md;
  const FoundryIcon.lg(this.icon, {super.key, this.color}) : size = FoundryIconSize.lg;
  const FoundryIcon.xl(this.icon, {super.key, this.color}) : size = FoundryIconSize.xl;
  const FoundryIcon.xxl(this.icon, {super.key, this.color}) : size = FoundryIconSize.xxl;

  double _getSize() {
    switch (size) {
      case FoundryIconSize.xs:
        return FIconSize.xs;
      case FoundryIconSize.sm:
        return FIconSize.sm;
      case FoundryIconSize.md:
        return FIconSize.md;
      case FoundryIconSize.lg:
        return FIconSize.lg;
      case FoundryIconSize.xl:
        return FIconSize.xl;
      case FoundryIconSize.xxl:
        return FIconSize.xxl;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final iconColor = color ?? theme.colors.fg.primary;

    return Icon(icon, size: _getSize(), color: iconColor);
  }
}
