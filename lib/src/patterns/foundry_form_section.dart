import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/components/components.dart';

class FoundryFormSection extends StatelessWidget {
  final String? title;
  final String? description;
  final List<Widget> children;
  final double? spacing;

  const FoundryFormSection({super.key, this.title, this.description, required this.children, this.spacing});

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final gap = spacing ?? theme.spacing.md;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) ...[
          FoundryText.headingSmall(title!, color: colors.fg.primary),
          if (description != null) ...[
            FoundryGap.xs(),
            FoundryText.bodySmall(description!, color: colors.fg.secondary),
          ],
          FoundryGap.md(),
        ],
        ...List.generate(children.length * 2 - 1, (index) {
          if (index.isOdd) {
            return SizedBox(height: gap);
          }
          return children[index ~/ 2];
        }),
      ],
    );
  }
}
