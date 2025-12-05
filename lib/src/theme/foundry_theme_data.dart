import 'package:foundry_ds/src/semantic/semantic.dart';

/// Defines the contract for a Foundry Design System theme.
///
/// Implement this class to create custom themes for your application.
/// See [FoundryLightTheme] and [FoundryDarkTheme] for examples.
abstract class FoundryThemeData {
  /// Semantic color tokens for the theme.
  SemanticColors get colors;

  /// Typography tokens including font families and sizes.
  SemanticTypography get typography;

  /// Spacing scale tokens (xxs through xxxl).
  SemanticSpacing get spacing;

  /// Border radius tokens.
  SemanticRadius get radius;

  /// Shadow tokens for elevation.
  SemanticShadows get shadows;

  /// Motion/animation tokens.
  SemanticMotion get motion;

  /// Layout tokens for responsive design.
  SemanticLayout get layout;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FoundryThemeData) return false;
    return runtimeType == other.runtimeType;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}
