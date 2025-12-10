import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';

class FoundryEmptyState extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? description;
  final Widget? action;

  final bool adaptive;

  const FoundryEmptyState({
    super.key,
    this.icon,
    required this.title,
    this.description,
    this.action,
    this.adaptive = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final spacing = theme.spacing;

    return LayoutBuilder(
      builder: (context, constraints) {
        const estimatedMinHeight = 200.0;

        final isConstrained = constraints.maxHeight < double.infinity;
        final isVeryConstrained = isConstrained && constraints.maxHeight < estimatedMinHeight;

        final iconSize = isVeryConstrained ? FIconSize.xl : FIconSize.xxl;
        final gapAfterIcon = isVeryConstrained ? FoundryGap.sm() : FoundryGap.lg();
        final gapAfterTitle = isVeryConstrained ? FoundryGap.xs() : FoundryGap.sm();
        final gapBeforeAction = isVeryConstrained ? FoundryGap.md() : FoundryGap.lg();
        final padding = isVeryConstrained
            ? FInsets.symmetric(horizontal: spacing.lg, vertical: spacing.md)
            : FInsets.xl;

        Widget content = Padding(
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[Icon(icon, size: iconSize, color: colors.fg.muted), gapAfterIcon],
              FoundryText.heading(title, textAlign: TextAlign.center, color: colors.fg.primary),
              if (description != null) ...[
                gapAfterTitle,
                FoundryText.body(description!, textAlign: TextAlign.center, color: colors.fg.secondary),
              ],
              if (action != null) ...[gapBeforeAction, action!],
            ],
          ),
        );

        if (isConstrained && adaptive) {
          content = SingleChildScrollView(child: content);
        }

        return Center(child: content);
      },
    );
  }
}
