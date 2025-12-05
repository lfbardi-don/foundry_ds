import 'package:flutter/material.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';

class FoundryInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final String? label;
  final String? errorText;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  const FoundryInput({
    super.key,
    this.controller,
    this.placeholder,
    this.label,
    this.errorText,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final typography = theme.typography;
    final spacing = theme.spacing;
    final radius = theme.radius;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              color: colors.fg.primary,
              fontSize: typography.bodySmall,
              fontWeight: typography.medium,
              fontFamily: typography.primary,
            ),
          ),
          const FoundryGap.xs(),
        ],
        TextField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          style: TextStyle(color: colors.fg.primary, fontSize: typography.body, fontFamily: typography.primary),
          cursorColor: colors.fg.primary,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(
              color: colors.input.placeholder,
              fontSize: typography.body,
              fontFamily: typography.primary,
            ),
            filled: true,
            fillColor: colors.input.bg,
            contentPadding: FInsets.symmetric(horizontal: spacing.md, vertical: spacing.sm),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius.md),
              borderSide: BorderSide(color: colors.input.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius.md),
              borderSide: BorderSide(color: colors.input.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius.md),
              borderSide: BorderSide(color: colors.border.focus, width: FBorderWidth.medium),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius.md),
              borderSide: BorderSide(color: colors.status.negative.border),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius.md),
              borderSide: BorderSide(color: colors.status.negative.border, width: FBorderWidth.medium),
            ),
            errorText: errorText,
            errorStyle: TextStyle(
              color: colors.status.negative.fg,
              fontSize: typography.caption,
              fontFamily: typography.primary,
            ),
          ),
        ),
      ],
    );
  }
}
