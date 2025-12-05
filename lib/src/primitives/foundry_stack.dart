import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';

/// A vertical stack widget with automatic spacing between children.
///
/// Inspired by SwiftUI's VStack, this widget uses [FSpacing] tokens
/// to ensure consistent vertical rhythm.
class FoundryVStack extends StatelessWidget {
  final List<Widget> children;
  final double? spacing;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  const FoundryVStack({
    super.key,
    required this.children,
    this.spacing,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
  });

  /// VStack with extra-small spacing
  const FoundryVStack.xs({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
  }) : spacing = FSpacing.xs;

  /// VStack with small spacing
  const FoundryVStack.sm({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
  }) : spacing = FSpacing.sm;

  /// VStack with medium spacing (default)
  const FoundryVStack.md({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
  }) : spacing = FSpacing.md;

  /// VStack with large spacing
  const FoundryVStack.lg({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
  }) : spacing = FSpacing.lg;

  /// VStack with extra-large spacing
  const FoundryVStack.xl({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
  }) : spacing = FSpacing.xl;

  @override
  Widget build(BuildContext context) {
    final gap = spacing ?? FSpacing.md;
    final spacedChildren = <Widget>[];

    for (var i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1) {
        spacedChildren.add(SizedBox(height: gap));
      }
    }

    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: spacedChildren,
    );
  }
}

/// A horizontal stack widget with automatic spacing between children.
///
/// Inspired by SwiftUI's HStack, this widget uses [FSpacing] tokens
/// to ensure consistent horizontal rhythm.
class FoundryHStack extends StatelessWidget {
  final List<Widget> children;
  final double? spacing;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  const FoundryHStack({
    super.key,
    required this.children,
    this.spacing,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.min,
  });

  /// HStack with extra-small spacing
  const FoundryHStack.xs({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.min,
  }) : spacing = FSpacing.xs;

  /// HStack with small spacing
  const FoundryHStack.sm({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.min,
  }) : spacing = FSpacing.sm;

  /// HStack with medium spacing (default)
  const FoundryHStack.md({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.min,
  }) : spacing = FSpacing.md;

  /// HStack with large spacing
  const FoundryHStack.lg({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.min,
  }) : spacing = FSpacing.lg;

  /// HStack with extra-large spacing
  const FoundryHStack.xl({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.min,
  }) : spacing = FSpacing.xl;

  @override
  Widget build(BuildContext context) {
    final gap = spacing ?? FSpacing.md;
    final spacedChildren = <Widget>[];

    for (var i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1) {
        spacedChildren.add(SizedBox(width: gap));
      }
    }

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: spacedChildren,
    );
  }
}
