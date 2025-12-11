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
///
/// When [inherit] is `true`, the text will inherit styling (color, fontSize,
/// fontWeight, height) from its parent [DefaultTextStyle]. This is useful
/// when using [FoundryText] inside components like [FoundryButton] that
/// provide their own text styling via [DefaultTextStyle].
class FoundryText extends StatelessWidget {
  final String data;
  final FoundryTextVariant variant;
  final Color? color;
  final FontWeight? weight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool isMono;
  final bool inherit;

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
    this.inherit = true,
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
    this.inherit = true,
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
    this.inherit = true,
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
    this.inherit = true,
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
    this.inherit = true,
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
    this.inherit = true,
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
    this.inherit = true,
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
    this.inherit = true,
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
    this.inherit = true,
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
    this.inherit = true,
  }) : variant = FoundryTextVariant.caption;

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final typography = theme.typography;
    final colors = theme.colors;
    final defaultStyle = DefaultTextStyle.of(context).style;

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

    final effectiveColor = color ?? (inherit ? defaultStyle.color : colors.fg.primary);
    final effectiveFontSize = inherit ? defaultStyle.fontSize ?? fontSize : fontSize;
    final effectiveWeight = weight ?? (inherit ? defaultStyle.fontWeight ?? defaultWeight : defaultWeight);
    final effectiveHeight = inherit ? defaultStyle.height ?? lineHeight : lineHeight;

    return Text(
      data,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontFamily: isMono ? typography.mono : typography.primary,
        fontSize: effectiveFontSize,
        fontWeight: effectiveWeight,
        height: effectiveHeight,
        color: effectiveColor,
      ),
    );
  }
}
