import 'package:flutter/material.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';

/// A page scaffold with centered content and max-width constraint.
class FoundryPage extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool extendBodyBehindAppBar;

  const FoundryPage({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.extendBodyBehindAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: FLayout.xl),
          child: body,
        ),
      ),
    );
  }
}
