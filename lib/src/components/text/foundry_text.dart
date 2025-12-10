import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';

/// Typography variants for [FoundryText].
enum FoundryTextVariant {
  displayLarge,
  display,
  headingLarge,
  heading,
  headingSmall,
  subheading,
  body,
  bodySmall,
  caption,
}

/// A text widget with semantic typography variants.
class FoundryText extends StatelessWidget {
  final String data;
  final FoundryTextVariant variant;
  final Color? color;
  final FontWeight? weight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool isMono;

  const FoundryText(
    this.data, {
    super.key,
    this.variant = FoundryTextVariant.body,
    this.color,
    this.weight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isMono = false,
  });

  const FoundryText.displayLarge(
    this.data, {
    super.key,
    this.color,
    this.weight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isMono = false,
  }) : variant = FoundryTextVariant.displayLarge;

  const FoundryText.display(
    this.data, {
    super.key,
    this.color,
    this.weight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isMono = false,
  }) : variant = FoundryTextVariant.display;

  const FoundryText.headingLarge(
    this.data, {
    super.key,
    this.color,
    this.weight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isMono = false,
  }) : variant = FoundryTextVariant.headingLarge;

  const FoundryText.heading(
    this.data, {
    super.key,
    this.color,
    this.weight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isMono = false,
  }) : variant = FoundryTextVariant.heading;

  const FoundryText.headingSmall(
    this.data, {
    super.key,
    this.color,
    this.weight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isMono = false,
  }) : variant = FoundryTextVariant.headingSmall;

  const FoundryText.subheading(
    this.data, {
    super.key,
    this.color,
    this.weight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isMono = false,
  }) : variant = FoundryTextVariant.subheading;

  const FoundryText.body(
    this.data, {
    super.key,
    this.color,
    this.weight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isMono = false,
  }) : variant = FoundryTextVariant.body;

  const FoundryText.bodySmall(
    this.data, {
    super.key,
    this.color,
    this.weight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isMono = false,
  }) : variant = FoundryTextVariant.bodySmall;

  const FoundryText.caption(
    this.data, {
    super.key,
    this.color,
    this.weight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isMono = false,
  }) : variant = FoundryTextVariant.caption;

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final typography = theme.typography;
    final colors = theme.colors;

    double fontSize;
    FontWeight defaultWeight;
    double lineHeight;

    switch (variant) {
      case FoundryTextVariant.displayLarge:
        fontSize = typography.displayLarge;
        defaultWeight = typography.bold;
        lineHeight = typography.tight;
        break;
      case FoundryTextVariant.display:
        fontSize = typography.display;
        defaultWeight = typography.bold;
        lineHeight = typography.tight;
        break;
      case FoundryTextVariant.headingLarge:
        fontSize = typography.headingLarge;
        defaultWeight = typography.semibold;
        lineHeight = typography.snug;
        break;
      case FoundryTextVariant.heading:
        fontSize = typography.heading;
        defaultWeight = typography.semibold;
        lineHeight = typography.snug;
        break;
      case FoundryTextVariant.headingSmall:
        fontSize = typography.headingSmall;
        defaultWeight = typography.semibold;
        lineHeight = typography.snug;
        break;
      case FoundryTextVariant.subheading:
        fontSize = typography.subheading;
        defaultWeight = typography.medium;
        lineHeight = typography.normal;
        break;
      case FoundryTextVariant.body:
        fontSize = typography.body;
        defaultWeight = typography.regular;
        lineHeight = typography.normal;
        break;
      case FoundryTextVariant.bodySmall:
        fontSize = typography.bodySmall;
        defaultWeight = typography.regular;
        lineHeight = typography.normal;
        break;
      case FoundryTextVariant.caption:
        fontSize = typography.caption;
        defaultWeight = typography.regular;
        lineHeight = typography.normal;
        break;
    }

    return Text(
      data,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontFamily: isMono ? typography.mono : typography.primary,
        fontSize: fontSize,
        fontWeight: weight ?? defaultWeight,
        height: lineHeight,
        color: color ?? colors.fg.primary,
      ),
    );
  }
}
