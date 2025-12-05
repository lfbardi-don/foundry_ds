import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/semantic/semantic.dart';

/// Extension on [BuildContext] for convenient access to Foundry theme data.
///
/// Usage:
/// ```dart
/// final colors = context.foundry.colors;
/// final spacing = context.foundry.spacing;
/// ```
extension FoundryContext on BuildContext {
  /// Access the current Foundry theme data.
  FoundryThemeData get foundry => FoundryTheme.of(this);
}

/// Shorthand extensions for common theme properties.
extension FoundryContextShorthand on BuildContext {
  /// Access semantic colors directly.
  SemanticColors get foundryColors => foundry.colors;

  /// Access semantic typography directly.
  SemanticTypography get foundryTypography => foundry.typography;

  /// Access semantic spacing directly.
  SemanticSpacing get foundrySpacing => foundry.spacing;

  /// Access semantic radius directly.
  SemanticRadius get foundryRadius => foundry.radius;

  /// Access semantic shadows directly.
  SemanticShadows get foundryShadows => foundry.shadows;

  /// Access semantic motion directly.
  SemanticMotion get foundryMotion => foundry.motion;

  /// Access semantic layout directly.
  SemanticLayout get foundryLayout => foundry.layout;
}
