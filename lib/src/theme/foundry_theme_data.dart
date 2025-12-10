import 'package:foundry_ds/src/semantic/semantic.dart';

abstract class FoundryThemeData {
  SemanticColors get colors;

  SemanticTypography get typography;

  SemanticSpacing get spacing;

  SemanticRadius get radius;

  SemanticShadows get shadows;

  SemanticMotion get motion;

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
