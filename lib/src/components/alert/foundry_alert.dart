import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';

/// Alert variants for different semantic meanings.
enum FoundryAlertVariant { info, positive, warning, negative }

/// An inline alert component for displaying status messages.
///
/// Use [FoundryAlert] to show informational, success, warning, or error
/// messages to the user.
class FoundryAlert extends StatelessWidget {
  final FoundryAlertVariant variant;
  final String? title;
  final String description;
  final IconData? icon;
  final VoidCallback? onDismiss;

  const FoundryAlert({
    super.key,
    this.variant = FoundryAlertVariant.info,
    this.title,
    required this.description,
    this.icon,
    this.onDismiss,
  });

  /// Info alert (default)
  const FoundryAlert.info({super.key, this.title, required this.description, this.icon, this.onDismiss})
    : variant = FoundryAlertVariant.info;

  /// Positive/success alert
  const FoundryAlert.positive({super.key, this.title, required this.description, this.icon, this.onDismiss})
    : variant = FoundryAlertVariant.positive;

  /// Warning alert
  const FoundryAlert.warning({super.key, this.title, required this.description, this.icon, this.onDismiss})
    : variant = FoundryAlertVariant.warning;

  /// Negative/error alert
  const FoundryAlert.negative({super.key, this.title, required this.description, this.icon, this.onDismiss})
    : variant = FoundryAlertVariant.negative;

  IconData get _defaultIcon {
    switch (variant) {
      case FoundryAlertVariant.info:
        return FIcons.info;
      case FoundryAlertVariant.positive:
        return FIcons.checkCircle;
      case FoundryAlertVariant.warning:
        return FIcons.alertTriangle;
      case FoundryAlertVariant.negative:
        return FIcons.alertCircle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final radius = theme.radius;

    Color bgColor;
    Color fgColor;
    Color borderColor;

    switch (variant) {
      case FoundryAlertVariant.info:
        bgColor = colors.status.info.bg;
        fgColor = colors.status.info.fg;
        borderColor = colors.status.info.border;
        break;
      case FoundryAlertVariant.positive:
        bgColor = colors.status.positive.bg;
        fgColor = colors.status.positive.fg;
        borderColor = colors.status.positive.border;
        break;
      case FoundryAlertVariant.warning:
        bgColor = colors.status.warning.bg;
        fgColor = colors.status.warning.fg;
        borderColor = colors.status.warning.border;
        break;
      case FoundryAlertVariant.negative:
        bgColor = colors.status.negative.bg;
        fgColor = colors.status.negative.fg;
        borderColor = colors.status.negative.border;
        break;
    }

    return Container(
      padding: FInsets.md,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(radius.md),
        border: Border.all(color: borderColor, width: FBorderWidth.hairline),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon ?? _defaultIcon, size: FIconSize.md, color: fgColor),
          FoundryGap.sm(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null) ...[
                  FoundryText.body(title!, weight: FontWeight.w600, color: fgColor),
                  FoundryGap.xs(),
                ],
                FoundryText.bodySmall(description, color: fgColor),
              ],
            ),
          ),
          if (onDismiss != null) ...[
            FoundryGap.sm(),
            GestureDetector(
              onTap: onDismiss,
              child: Icon(FIcons.close, size: FIconSize.sm, color: fgColor),
            ),
          ],
        ],
      ),
    );
  }
}
