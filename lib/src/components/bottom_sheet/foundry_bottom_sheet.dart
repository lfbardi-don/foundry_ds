import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';

/// A bottom sheet component that slides up from the bottom.
///
/// Use [FoundryBottomSheet.show] to display a bottom sheet modal.
class FoundryBottomSheet extends StatelessWidget {
  /// Optional title for the sheet.
  final String? title;

  /// The content of the sheet.
  final Widget child;

  /// Whether to show a close button.
  final bool showCloseButton;

  /// Whether to show the drag handle.
  final bool showHandle;

  /// Called when the sheet is dismissed.
  final VoidCallback? onClose;

  const FoundryBottomSheet({
    super.key,
    this.title,
    required this.child,
    this.showCloseButton = true,
    this.showHandle = true,
    this.onClose,
  });

  /// Shows a bottom sheet.
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    required Widget child,
    bool showCloseButton = true,
    bool showHandle = true,
    bool isDismissible = true,
    bool isScrollControlled = true,
  }) {
    final theme = FoundryTheme.of(context);

    return Navigator.of(context).push<T>(
      PageRouteBuilder<T>(
        opaque: false,
        barrierDismissible: isDismissible,
        barrierColor: theme.colors.layout.overlay,
        pageBuilder: (context, animation, secondaryAnimation) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
              child: FoundryBottomSheet(
                title: title,
                showCloseButton: showCloseButton,
                showHandle: showHandle,
                onClose: () => Navigator.of(context).pop(),
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final radius = theme.radius;
    final spacing = theme.spacing;
    final shadows = theme.shadows;

    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
      decoration: BoxDecoration(
        color: colors.layout.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius.xl)),
        boxShadow: shadows.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle
          if (showHandle)
            Center(
              child: Container(
                margin: FInsets.vSm,
                width: FControlSize.handleWidth,
                height: FControlSize.handleHeight,
                decoration: BoxDecoration(color: colors.border.muted, borderRadius: BorderRadius.circular(radius.full)),
              ),
            ),
          // Header
          if (title != null || showCloseButton)
            Padding(
              padding: FInsets.symmetric(horizontal: spacing.md, vertical: showHandle ? spacing.xs : spacing.md),
              child: Row(
                children: [
                  if (title != null) Expanded(child: FoundryText.heading(title!)) else const Spacer(),
                  if (showCloseButton)
                    GestureDetector(
                      onTap: onClose ?? () => Navigator.of(context).pop(),
                      child: Icon(FIcons.close, size: FIconSize.md, color: colors.fg.secondary),
                    ),
                ],
              ),
            ),
          // Divider
          if (title != null) FoundryDivider.horizontal(),
          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: FInsets.all(spacing.md),
              child: SafeArea(top: false, child: child),
            ),
          ),
        ],
      ),
    );
  }
}

/// Action sheet variant with action buttons.
class FoundryActionSheet {
  /// Shows an action sheet with options.
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    String? message,
    required List<FoundryActionSheetItem<T>> actions,
    String cancelLabel = 'Cancel',
  }) {
    return FoundryBottomSheet.show<T>(
      context: context,
      title: title,
      showCloseButton: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (message != null) ...[FoundryText.body(message), const FoundryGap.md()],
          ...actions.map((action) => _ActionSheetButton<T>(action: action)),
          const FoundryGap.sm(),
          FoundryButton(
            onPressed: () => Navigator.of(context).pop(),
            label: cancelLabel,
            variant: FoundryButtonVariant.ghost,
          ),
        ],
      ),
    );
  }
}

/// An action item for [FoundryActionSheet].
class FoundryActionSheetItem<T> {
  final String label;
  final IconData? icon;
  final T? value;
  final bool isDestructive;
  final VoidCallback? onTap;

  const FoundryActionSheetItem({required this.label, this.icon, this.value, this.isDestructive = false, this.onTap});
}

class _ActionSheetButton<T> extends StatelessWidget {
  final FoundryActionSheetItem<T> action;

  const _ActionSheetButton({required this.action});

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final spacing = theme.spacing;

    final textColor = action.isDestructive ? colors.status.negative.fg : colors.fg.primary;

    return Padding(
      padding: EdgeInsets.only(bottom: spacing.xs),
      child: FoundryButton(
        onPressed: () {
          action.onTap?.call();
          Navigator.of(context).pop(action.value);
        },
        label: action.label,
        icon: action.icon != null ? Icon(action.icon, color: textColor) : null,
        variant: action.isDestructive ? FoundryButtonVariant.destructive : FoundryButtonVariant.outline,
      ),
    );
  }
}
