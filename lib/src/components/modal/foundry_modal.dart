import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';

/// A modal dialog component.
///
/// Use [FoundryModal.show] to display a modal dialog with header, content,
/// and optional footer.
class FoundryModal extends StatelessWidget {
  final String? title;
  final Widget content;
  final List<Widget>? actions;
  final double? maxWidth;
  final bool showCloseButton;
  final VoidCallback? onClose;

  const FoundryModal({
    super.key,
    this.title,
    required this.content,
    this.actions,
    this.maxWidth,
    this.showCloseButton = true,
    this.onClose,
  });

  /// Shows a modal dialog.
  ///
  /// Returns `true` if the dialog was dismissed by the user,
  /// or the result from [Navigator.pop] if dismissed programmatically.
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    required Widget content,
    List<Widget>? actions,
    double? maxWidth,
    bool showCloseButton = true,
    bool barrierDismissible = true,
  }) {
    final theme = FoundryTheme.of(context);

    return Navigator.of(context).push<T>(
      PageRouteBuilder<T>(
        opaque: false,
        barrierDismissible: barrierDismissible,
        barrierColor: theme.colors.layout.overlay,
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(
                begin: 0.95,
                end: 1.0,
              ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
              child: FoundryModal(
                title: title,
                content: content,
                actions: actions,
                maxWidth: maxWidth,
                showCloseButton: showCloseButton,
                onClose: () => Navigator.of(context).pop(),
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

    return Center(
      child: Padding(
        padding: FInsets.lg,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth ?? 480, maxHeight: MediaQuery.of(context).size.height * 0.85),
          child: Container(
            decoration: BoxDecoration(
              color: colors.layout.surface,
              borderRadius: BorderRadius.circular(radius.lg),
              boxShadow: shadows.xl,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                if (title != null || showCloseButton)
                  Padding(
                    padding: FInsets.all(spacing.md),
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
                  child: SingleChildScrollView(padding: FInsets.all(spacing.md), child: content),
                ),
                // Footer with actions
                if (actions != null && actions!.isNotEmpty) ...[
                  FoundryDivider.horizontal(),
                  Padding(
                    padding: FInsets.all(spacing.md),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        for (int i = 0; i < actions!.length; i++) ...[if (i > 0) FoundryGap.sm(), actions![i]],
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A confirmation dialog with predefined buttons.
class FoundryConfirmDialog {
  /// Shows a confirmation dialog with Cancel and Confirm buttons.
  static Future<bool> show({
    required BuildContext context,
    required String title,
    required String message,
    String cancelLabel = 'Cancel',
    String confirmLabel = 'Confirm',
    bool isDestructive = false,
  }) async {
    final result = await FoundryModal.show<bool>(
      context: context,
      title: title,
      content: FoundryText.body(message),
      actions: [
        FoundryButton(
          onPressed: () => Navigator.of(context).pop(false),
          label: cancelLabel,
          variant: FoundryButtonVariant.ghost,
        ),
        FoundryButton(
          onPressed: () => Navigator.of(context).pop(true),
          label: confirmLabel,
          variant: isDestructive ? FoundryButtonVariant.destructive : FoundryButtonVariant.primary,
        ),
      ],
    );

    return result ?? false;
  }
}
