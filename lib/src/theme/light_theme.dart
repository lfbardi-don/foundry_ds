import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/semantic/semantic.dart';
import 'foundry_theme_data.dart';

class FoundryLightTheme implements FoundryThemeData {
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
  final SemanticMotion motion;

  @override
  final SemanticLayout layout;

  FoundryLightTheme()
    : colors = const SemanticColors(
        bg: BackgroundColors(
          canvas: FColors.white,
          muted: FColors.zinc100,
          emphasis: FColors.zinc200,
          inverted: FColors.zinc900,
          positive: FColors.green50,
          negative: FColors.red50,
          warning: FColors.amber50,
          info: FColors.blue50,
          transparent: FColors.transparent,
        ),
        fg: ForegroundColors(
          primary: FColors.zinc950,
          secondary: FColors.zinc500,
          muted: FColors.zinc400,
          inverted: FColors.white,
          accent: FColors.brandPrimary,
          link: FColors.blue600,
          positive: FColors.green600,
          negative: FColors.red600,
          warning: FColors.amber500,
        ),
        border: BorderColors(
          base: FColors.zinc300,
          muted: FColors.zinc200,
          strong: FColors.zinc400,
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
          subtle: FColors.brandPrimaryOp10,
          fg: FColors.brandWhite,
        ),
        status: StatusColors(
          positive: StatusColor(
            bg: FColors.green50,
            fg: FColors.green600,
            border: FColors.green500,
            main: FColors.green500,
          ),
          negative: StatusColor(bg: FColors.red50, fg: FColors.red600, border: FColors.red500, main: FColors.red500),
          warning: StatusColor(
            bg: FColors.amber50,
            fg: FColors.amber500,
            border: FColors.amber500,
            main: FColors.amber500,
          ),
          info: StatusColor(bg: FColors.blue50, fg: FColors.blue600, border: FColors.blue500, main: FColors.blue500),
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
          hover: StateColor(bg: FColors.zinc100, fg: FColors.zinc900),
          active: StateColor(bg: FColors.zinc200, fg: FColors.zinc950),
          disabled: StateColor(bg: FColors.zinc100, fg: FColors.zinc400, border: FColors.zinc200),
        ),
        layout: LayoutColors(
          surface: FColors.white,
          subtle: FColors.zinc50,
          elevated: FColors.white,
          overlay: FColors.blackOp40,
        ),
        button: ButtonColors(
          primary: ComponentColors(bg: FColors.brandPrimary, fg: FColors.brandWhite, border: FColors.transparent),
          secondary: ComponentColors(bg: FColors.zinc900, fg: FColors.white, border: FColors.transparent),
        ),
        input: InputColors(bg: FColors.white, border: FColors.zinc300, placeholder: FColors.zinc400),
        card: CardColors(bg: FColors.white, border: FColors.zinc200),
        navbar: NavbarColors(bg: FColors.whiteOp80, border: FColors.zinc200),
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
