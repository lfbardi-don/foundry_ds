import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';

/// A tab bar component for navigation between views.
///
/// Example:
/// ```dart
/// FoundryTabs(
///   selectedIndex: _selectedIndex,
///   onChanged: (index) => setState(() => _selectedIndex = index),
///   tabs: [
///     FoundryTab(label: 'Home', icon: Icons.home),
///     FoundryTab(label: 'Settings', icon: Icons.settings),
///   ],
/// )
/// ```
class FoundryTabs extends StatelessWidget {
  /// The currently selected tab index.
  final int selectedIndex;

  /// Called when a tab is selected.
  final ValueChanged<int>? onChanged;

  /// List of tabs to display.
  final List<FoundryTab> tabs;

  /// Whether to expand tabs to fill available width.
  final bool isExpanded;

  const FoundryTabs({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
    required this.tabs,
    this.isExpanded = false,
  }) : assert(tabs.length >= 2, 'At least 2 tabs are required');

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final spacing = theme.spacing;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: colors.border.muted, width: FBorderWidth.hairline),
        ),
      ),
      child: Row(
        mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
        children: List.generate(tabs.length, (index) {
          final tab = tabs[index];
          final isSelected = index == selectedIndex;

          return isExpanded
              ? Expanded(child: _buildTab(context, tab, isSelected, index))
              : Padding(
                  padding: EdgeInsets.only(right: index < tabs.length - 1 ? spacing.md : 0),
                  child: _buildTab(context, tab, isSelected, index),
                );
        }),
      ),
    );
  }

  Widget _buildTab(BuildContext context, FoundryTab tab, bool isSelected, int index) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final typography = theme.typography;
    final spacing = theme.spacing;
    final motion = theme.motion;

    final isDisabled = tab.isDisabled;
    final isEnabled = !isDisabled && onChanged != null;

    Color textColor;
    if (isDisabled) {
      textColor = colors.state.disabled.fg!;
    } else if (isSelected) {
      textColor = colors.accent.base;
    } else {
      textColor = colors.fg.secondary;
    }

    return GestureDetector(
      onTap: isEnabled ? () => onChanged?.call(index) : null,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: motion.fast,
        padding: FInsets.symmetric(horizontal: spacing.sm, vertical: spacing.sm),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? colors.accent.base : colors.border.transparent,
              width: FBorderWidth.medium,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (tab.icon != null) ...[
              Icon(tab.icon, size: FIconSize.md, color: textColor),
              if (tab.label != null) const FoundryGap.xs(),
            ],
            if (tab.label != null)
              Text(
                tab.label!,
                style: TextStyle(
                  color: textColor,
                  fontSize: typography.body,
                  fontWeight: isSelected ? typography.medium : typography.regular,
                  fontFamily: typography.primary,
                ),
              ),
            if (tab.badge != null) ...[
              const FoundryGap.xs(),
              FoundryBadge(count: tab.badge, size: FoundryBadgeSize.small),
            ],
          ],
        ),
      ),
    );
  }
}

/// A tab definition for [FoundryTabs].
class FoundryTab {
  /// The tab label text.
  final String? label;

  /// Optional icon.
  final IconData? icon;

  /// Optional badge count.
  final int? badge;

  /// Whether this tab is disabled.
  final bool isDisabled;

  const FoundryTab({this.label, this.icon, this.badge, this.isDisabled = false})
    : assert(label != null || icon != null, 'Either label or icon must be provided');
}

/// A full tab view with content switching.
///
/// Example:
/// ```dart
/// FoundryTabView(
///   tabs: [
///     FoundryTab(label: 'Tab 1'),
///     FoundryTab(label: 'Tab 2'),
///   ],
///   children: [
///     Tab1Content(),
///     Tab2Content(),
///   ],
/// )
/// ```
class FoundryTabView extends StatefulWidget {
  /// List of tabs.
  final List<FoundryTab> tabs;

  /// Content for each tab.
  final List<Widget> children;

  /// Initial selected index.
  final int initialIndex;

  /// Whether tabs expand to fill width.
  final bool isExpanded;

  const FoundryTabView({
    super.key,
    required this.tabs,
    required this.children,
    this.initialIndex = 0,
    this.isExpanded = false,
  }) : assert(tabs.length == children.length, 'tabs and children must have the same length');

  @override
  State<FoundryTabView> createState() => _FoundryTabViewState();
}

class _FoundryTabViewState extends State<FoundryTabView> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FoundryTabs(
          selectedIndex: _selectedIndex,
          onChanged: (index) => setState(() => _selectedIndex = index),
          tabs: widget.tabs,
          isExpanded: widget.isExpanded,
        ),
        const FoundryGap.md(),
        Expanded(
          child: IndexedStack(index: _selectedIndex, children: widget.children),
        ),
      ],
    );
  }
}
