import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';

/// Badge variants for different semantic meanings.
enum FoundryBadgeVariant { neutral, positive, negative, warning, info, accent }

/// Badge sizes.
enum FoundryBadgeSize { small, medium }

/// A badge component for status indicators, counts, and labels.
///
/// Use [FoundryBadge] to display short status text, notification counts,
/// or categorical labels.
class FoundryBadge extends StatelessWidget {
  final String? label;
  final int? count;
  final FoundryBadgeVariant variant;
  final FoundryBadgeSize size;

  const FoundryBadge({
    super.key,
    this.label,
    this.count,
    this.variant = FoundryBadgeVariant.neutral,
    this.size = FoundryBadgeSize.medium,
  }) : assert(label != null || count != null, 'Either label or count must be provided');

  /// Neutral badge (default)
  const FoundryBadge.neutral({super.key, this.label, this.count, this.size = FoundryBadgeSize.medium})
    : variant = FoundryBadgeVariant.neutral,
      assert(label != null || count != null);

  /// Positive/success badge
  const FoundryBadge.positive({super.key, this.label, this.count, this.size = FoundryBadgeSize.medium})
    : variant = FoundryBadgeVariant.positive,
      assert(label != null || count != null);

  /// Negative/error badge
  const FoundryBadge.negative({super.key, this.label, this.count, this.size = FoundryBadgeSize.medium})
    : variant = FoundryBadgeVariant.negative,
      assert(label != null || count != null);

  /// Warning badge
  const FoundryBadge.warning({super.key, this.label, this.count, this.size = FoundryBadgeSize.medium})
    : variant = FoundryBadgeVariant.warning,
      assert(label != null || count != null);

  /// Info badge
  const FoundryBadge.info({super.key, this.label, this.count, this.size = FoundryBadgeSize.medium})
    : variant = FoundryBadgeVariant.info,
      assert(label != null || count != null);

  /// Accent/brand badge
  const FoundryBadge.accent({super.key, this.label, this.count, this.size = FoundryBadgeSize.medium})
    : variant = FoundryBadgeVariant.accent,
      assert(label != null || count != null);

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final typography = theme.typography;
    final radius = theme.radius;
    final spacing = theme.spacing;

    Color bgColor;
    Color fgColor;

    switch (variant) {
      case FoundryBadgeVariant.neutral:
        bgColor = colors.bg.muted;
        fgColor = colors.fg.secondary;
        break;
      case FoundryBadgeVariant.positive:
        bgColor = colors.status.positive.bg;
        fgColor = colors.status.positive.fg;
        break;
      case FoundryBadgeVariant.negative:
        bgColor = colors.status.negative.bg;
        fgColor = colors.status.negative.fg;
        break;
      case FoundryBadgeVariant.warning:
        bgColor = colors.status.warning.bg;
        fgColor = colors.status.warning.fg;
        break;
      case FoundryBadgeVariant.info:
        bgColor = colors.status.info.bg;
        fgColor = colors.status.info.fg;
        break;
      case FoundryBadgeVariant.accent:
        bgColor = colors.accent.subtle;
        fgColor = colors.accent.base;
        break;
    }

    final isSmall = size == FoundryBadgeSize.small;
    final horizontalPadding = isSmall ? spacing.xs : spacing.sm;
    final verticalPadding = isSmall ? spacing.xxs : spacing.xs;
    final fontSize = isSmall ? typography.caption : typography.bodySmall;

    final displayText = count != null ? (count! > 99 ? '99+' : count.toString()) : label!;

    return Container(
      padding: FInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(radius.full)),
      child: Text(
        displayText,
        style: TextStyle(
          color: fgColor,
          fontSize: fontSize,
          fontWeight: typography.medium,
          fontFamily: typography.primary,
        ),
      ),
    );
  }
}
