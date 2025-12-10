import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/semantic/semantic.dart';
import 'foundry_theme_data.dart';

class FoundryDarkTheme implements FoundryThemeData {
  @override
  final SemanticColors colors;

  @override
  final SemanticTypography typography;

  @override
  final SemanticSpacing spacing;

  @override
  final SemanticRadius radius;

  @override
  final SemanticShadows shadows;

  @override
  final SemanticLayout layout;

  @override
  final SemanticMotion motion;

  FoundryDarkTheme()
    : colors = const SemanticColors(
        bg: BackgroundColors(
          canvas: FColors.zinc950,
          muted: FColors.zinc900,
          emphasis: FColors.zinc800,
          inverted: FColors.white,
          transparent: FColors.transparent,
          positive: FColors.green950,
          negative: FColors.red950,
          warning: FColors.amber950,
          info: FColors.blue950,
        ),
        fg: ForegroundColors(
          primary: FColors.white,
          secondary: FColors.zinc400,
          muted: FColors.zinc500,
          inverted: FColors.zinc950,
          accent: FColors.brandPrimary,
          link: FColors.blue500,
          positive: FColors.green500,
          negative: FColors.red500,
          warning: FColors.amber500,
        ),
        border: BorderColors(
          base: FColors.zinc800,
          muted: FColors.zinc900,
          strong: FColors.zinc700,
          focus: FColors.brandPrimary,
          accent: FColors.brandPrimary,
          positive: FColors.green500,
          negative: FColors.red500,
          transparent: FColors.transparent,
        ),
        accent: AccentColors(
          base: FColors.brandPrimary,
          hover: FColors.brandPrimaryHover,
          active: FColors.brandPrimaryActive,
          subtle: FColors.brandPrimaryOp15,
          fg: FColors.brandWhite,
        ),
        status: StatusColors(
          positive: StatusColor(
            bg: FColors.green950,

            fg: FColors.green500,
            border: FColors.green600,
            main: FColors.green500,
          ),
          negative: StatusColor(bg: FColors.red950, fg: FColors.red500, border: FColors.red600, main: FColors.red500),
          warning: StatusColor(
            bg: FColors.amber950,

            fg: FColors.amber500,
            border: FColors.amber600,
            main: FColors.amber500,
          ),
          info: StatusColor(bg: FColors.blue950, fg: FColors.blue500, border: FColors.blue600, main: FColors.blue500),
        ),
        opacity: OpacityTokens(
          disabled: 0.5,
          hover: 0.04,
          focus: 0.12,
          active: 0.12,
          overlay: 0.4,
          hoverDark: 0.85,
          pressedDark: 0.7,
        ),
        state: StateColors(
          hover: StateColor(bg: FColors.zinc800, fg: FColors.white),
          active: StateColor(bg: FColors.zinc700, fg: FColors.white),
          disabled: StateColor(bg: FColors.zinc900, fg: FColors.zinc600, border: FColors.zinc800),
        ),
        layout: LayoutColors(
          surface: FColors.zinc900,
          subtle: FColors.zinc950,
          elevated: FColors.zinc800,
          overlay: FColors.blackOp60,
        ),
        button: ButtonColors(
          primary: ComponentColors(bg: FColors.brandPrimary, fg: FColors.brandWhite, border: FColors.transparent),
          secondary: ComponentColors(bg: FColors.white, fg: FColors.zinc950, border: FColors.transparent),
        ),
        input: InputColors(bg: FColors.zinc950, border: FColors.zinc700, placeholder: FColors.zinc500),
        card: CardColors(bg: FColors.zinc900, border: FColors.zinc800),
        navbar: NavbarColors(bg: FColors.zinc950Op80, border: FColors.zinc800),
      ),
      typography = const SemanticTypography(
        primary: FTypography.primary,
        mono: FTypography.mono,
        caption: FTypography.caption,
        bodySmall: FTypography.bodySmall,
        body: FTypography.body,
        subheading: FTypography.subheading,
        headingSmall: FTypography.headingSmall,
        heading: FTypography.heading,
        headingLarge: FTypography.headingLarge,
        display: FTypography.display,
        displayLarge: FTypography.displayLarge,
        regular: FTypography.regular,
        medium: FTypography.medium,
        semibold: FTypography.semibold,
        bold: FTypography.bold,
        tight: FTypography.tight,
        compact: FTypography.compact,
        snug: FTypography.snug,
        normal: FTypography.normal,
        relaxed: FTypography.relaxed,
      ),
      spacing = const SemanticSpacing(
        xxs: FSpacing.xxs,
        xs: FSpacing.xs,
        sm: FSpacing.sm,
        md: FSpacing.md,
        lg: FSpacing.lg,
        xl: FSpacing.xl,
        xxl: FSpacing.xxl,
        xxxl: FSpacing.xxxl,
      ),
      radius = const SemanticRadius(
        none: FRadius.none,
        xs: FRadius.xs,
        sm: FRadius.sm,
        md: FRadius.md,
        lg: FRadius.lg,
        xl: FRadius.xl,
        full: FRadius.full,
      ),
      shadows = const SemanticShadows(
        none: FShadow.none,
        xs: FShadow.xs,
        sm: FShadow.sm,
        md: FShadow.md,
        lg: FShadow.lg,
        xl: FShadow.xl,
      ),
      layout = const SemanticLayout(
        sm: FLayout.sm,
        md: FLayout.md,
        lg: FLayout.lg,
        xl: FLayout.xl,
        xxl: FLayout.xxl,
        gutterSm: FLayout.gutterSm,
        gutterMd: FLayout.gutterMd,
        gutterLg: FLayout.gutterLg,
      ),
      motion = const SemanticMotion(
        fast: FMotion.fast,
        normal: FMotion.normal,
        slow: FMotion.slow,
        delayShort: FMotion.delayShort,
        delayMedium: FMotion.delayMedium,
        delayLong: FMotion.delayLong,
        easeOut: FMotion.easeOut,
        easeInOut: FMotion.easeInOut,
        emphasized: FMotion.emphasized,
        decelerate: FMotion.decelerate,
        accelerate: FMotion.accelerate,
      );
}
