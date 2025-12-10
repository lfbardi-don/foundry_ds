import 'package:flutter/widgets.dart';
import 'foundry_theme_data.dart';

/// An InheritedWidget that provides theme data to the widget tree.
class FoundryTheme extends InheritedWidget {
  final FoundryThemeData data;

  const FoundryTheme({super.key, required this.data, required super.child});

  static FoundryThemeData of(BuildContext context) {
    final FoundryTheme? result = context.dependOnInheritedWidgetOfExactType<FoundryTheme>();
    assert(result != null, 'No FoundryTheme found in context');
    return result!.data;
  }

  @override
  bool updateShouldNotify(FoundryTheme oldWidget) {
    return data != oldWidget.data;
  }
}
