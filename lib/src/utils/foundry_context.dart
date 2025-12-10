import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/semantic/semantic.dart';

extension FoundryContext on BuildContext {
  FoundryThemeData get foundry => FoundryTheme.of(this);
}

extension FoundryContextShorthand on BuildContext {
  SemanticColors get foundryColors => foundry.colors;

  SemanticTypography get foundryTypography => foundry.typography;

  SemanticSpacing get foundrySpacing => foundry.spacing;

  SemanticRadius get foundryRadius => foundry.radius;

  SemanticShadows get foundryShadows => foundry.shadows;

  SemanticMotion get foundryMotion => foundry.motion;

  SemanticLayout get foundryLayout => foundry.layout;
}
