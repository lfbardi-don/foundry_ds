import 'package:flutter/material.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/semantic/semantic.dart';

import 'foundry_button.dart';

class ButtonSizeConfiguration {
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final double iconSize;
  final double iconPadding;
  final double height;

  const ButtonSizeConfiguration({
    required this.padding,
    required this.fontSize,
    required this.iconSize,
    required this.iconPadding,
    required this.height,
  });
}

class ButtonSizeConfig {
  const ButtonSizeConfig._();

  static ButtonSizeConfiguration forSize(
    FoundryButtonSize size,
    SemanticSpacing spacing,
    SemanticTypography typography,
  ) {
    return switch (size) {
      FoundryButtonSize.small => small(spacing, typography),
      FoundryButtonSize.medium => medium(spacing, typography),
      FoundryButtonSize.large => large(spacing, typography),
    };
  }

  static ButtonSizeConfiguration small(SemanticSpacing spacing, SemanticTypography typography) {
    return ButtonSizeConfiguration(
      padding: FInsets.symmetric(horizontal: spacing.sm, vertical: spacing.xs),
      fontSize: typography.bodySmall,
      iconSize: FIconSize.sm,
      iconPadding: spacing.xs,
      height: FControlSize.buttonSm,
    );
  }

  static ButtonSizeConfiguration medium(SemanticSpacing spacing, SemanticTypography typography) {
    return ButtonSizeConfiguration(
      padding: FInsets.symmetric(horizontal: spacing.md, vertical: spacing.sm),
      fontSize: typography.body,
      iconSize: FIconSize.md,
      iconPadding: spacing.sm,
      height: FControlSize.buttonMd,
    );
  }

  static ButtonSizeConfiguration large(SemanticSpacing spacing, SemanticTypography typography) {
    return ButtonSizeConfiguration(
      padding: FInsets.symmetric(horizontal: spacing.lg, vertical: spacing.md),
      fontSize: typography.headingSmall,
      iconSize: FIconSize.lg,
      iconPadding: spacing.md,
      height: FControlSize.buttonLg,
    );
  }
}
