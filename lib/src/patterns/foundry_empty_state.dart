import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';

/// A pattern widget for displaying empty states.
///
/// Use [FoundryEmptyState] to show a consistent empty state UI when
/// there's no data to display (e.g., empty lists, no search results).
class FoundryEmptyState extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? description;
  final Widget? action;

  const FoundryEmptyState({super.key, this.icon, required this.title, this.description, this.action});

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;

    return Center(
      child: Padding(
        padding: FInsets.xl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Icon(icon, size: FIconSize.xxl, color: colors.fg.muted), FoundryGap.lg()],
            FoundryText.heading(title, textAlign: TextAlign.center, color: colors.fg.primary),
            if (description != null) ...[
              FoundryGap.sm(),
              FoundryText.body(description!, textAlign: TextAlign.center, color: colors.fg.secondary),
            ],
            if (action != null) ...[FoundryGap.lg(), action!],
          ],
        ),
      ),
    );
  }
}
