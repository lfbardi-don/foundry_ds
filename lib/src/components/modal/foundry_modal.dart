import 'package:flutter/material.dart' show Material, MaterialType;
import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';
import 'package:foundry_ds/src/utils/foundry_interactive.dart';

/// A modal dialog with optional title, content, and action buttons.
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
              ).animate(CurvedAnimation(parent: animation, curve: FMotion.emphasized)),
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
      child: Material(
        type: MaterialType.transparency,
        child: Padding(
          padding: FInsets.lg,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth ?? 480,
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
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
                  if (title != null || showCloseButton)
                    Padding(
                      padding: FInsets.all(spacing.md),
                      child: Row(
                        children: [
                          if (title != null) Expanded(child: FoundryText.heading(title!)) else const Spacer(),
                          if (showCloseButton)
                            FoundryInteractive(
                              onTap: onClose ?? () => Navigator.of(context).pop(),
                              builder: (isHovered, isFocused, isPressed) => AnimatedOpacity(
                                duration: FMotion.fast,
                                opacity: isPressed ? 0.5 : (isHovered ? 0.7 : 1.0),
                                child: Icon(FIcons.close, size: FIconSize.md, color: colors.fg.secondary),
                              ),
                            ),
                        ],
                      ),
                    ),
                  if (title != null) FoundryDivider.horizontal(),
                  Flexible(
                    child: SingleChildScrollView(padding: FInsets.all(spacing.md), child: content),
                  ),
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
      ),
    );
  }
}

/// A convenience wrapper for displaying confirmation dialogs.
class FoundryConfirmDialog {
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
          variant: FoundryButtonVariant.ghost,
          child: Text(cancelLabel),
        ),
        FoundryButton(
          onPressed: () => Navigator.of(context).pop(true),
          variant: isDestructive ? FoundryButtonVariant.destructive : FoundryButtonVariant.primary,
          child: Text(confirmLabel),
        ),
      ],
    );

    return result ?? false;
  }
}
