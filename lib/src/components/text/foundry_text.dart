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
/// By default, [FoundryText] uses the Foundry Design System typography
/// and colors directly. Use [FoundryText.inherit] for cases where you need
/// vanilla text that inherits styling from parent [DefaultTextStyle].
class FoundryText extends StatelessWidget {
  final String data;
  final FoundryTextVariant variant;
  final Color? color;
  final FontWeight? weight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool isMono;
  final bool _inherit;

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
  }) : _inherit = false;

  const FoundryText.displayLarge(
    this.data, {
    super.key,
    this.color,
    this.weight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isMono = false,
  }) : variant = FoundryTextVariant.displayLarge,
       _inherit = false;

  const FoundryText.display(
    this.data, {
    super.key,
    this.color,
    this.weight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isMono = false,
  }) : variant = FoundryTextVariant.display,
       _inherit = false;

  const FoundryText.headingLarge(
    this.data, {
    super.key,
    this.color,
    this.weight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isMono = false,
  }) : variant = FoundryTextVariant.headingLarge,
       _inherit = false;

  const FoundryText.heading(
    this.data, {
    super.key,
    this.color,
    this.weight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isMono = false,
  }) : variant = FoundryTextVariant.heading,
       _inherit = false;

  const FoundryText.headingSmall(
    this.data, {
    super.key,
    this.color,
    this.weight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isMono = false,
  }) : variant = FoundryTextVariant.headingSmall,
       _inherit = false;

  const FoundryText.subheading(
    this.data, {
    super.key,
    this.color,
    this.weight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isMono = false,
  }) : variant = FoundryTextVariant.subheading,
       _inherit = false;

  const FoundryText.body(
    this.data, {
    super.key,
    this.color,
    this.weight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isMono = false,
  }) : variant = FoundryTextVariant.body,
       _inherit = false;

  const FoundryText.bodySmall(
    this.data, {
    super.key,
    this.color,
    this.weight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isMono = false,
  }) : variant = FoundryTextVariant.bodySmall,
       _inherit = false;

  const FoundryText.caption(
    this.data, {
    super.key,
    this.color,
    this.weight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isMono = false,
  }) : variant = FoundryTextVariant.caption,
       _inherit = false;

  const FoundryText.inherit(this.data, {super.key, this.textAlign, this.maxLines, this.overflow})
    : variant = FoundryTextVariant.body,
      color = null,
      weight = null,
      isMono = false,
      _inherit = true;

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final typography = theme.typography;
    final colors = theme.colors;

    if (_inherit) {
      return Text(data, textAlign: textAlign, maxLines: maxLines, overflow: overflow);
    }

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
