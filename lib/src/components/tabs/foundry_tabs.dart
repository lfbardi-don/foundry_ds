import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';

/// A tab bar with animated sliding indicator.
class FoundryTabs extends StatefulWidget {
  final int selectedIndex;

  final ValueChanged<int>? onChanged;

  final List<FoundryTab> tabs;

  final bool isExpanded;

  const FoundryTabs({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
    required this.tabs,
    this.isExpanded = false,
  }) : assert(tabs.length >= 2, 'At least 2 tabs are required');

  @override
  State<FoundryTabs> createState() => _FoundryTabsState();
}

class _FoundryTabsState extends State<FoundryTabs> {
  final List<GlobalKey> _tabKeys = [];
  double _indicatorLeft = 0;
  double _indicatorWidth = 0;

  @override
  void initState() {
    super.initState();
    _tabKeys.addAll(List.generate(widget.tabs.length, (_) => GlobalKey()));
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateIndicator());
  }

  @override
  void didUpdateWidget(FoundryTabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tabs.length != oldWidget.tabs.length) {
      _tabKeys.clear();
      _tabKeys.addAll(List.generate(widget.tabs.length, (_) => GlobalKey()));
    }
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _updateIndicator());
    }
  }

  void _updateIndicator() {
    if (!mounted) return;
    if (widget.selectedIndex >= _tabKeys.length) return;

    final selectedKey = _tabKeys[widget.selectedIndex];
    final renderBox = selectedKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final parentRenderBox = context.findRenderObject() as RenderBox?;
    if (parentRenderBox == null) return;

    final offset = renderBox.localToGlobal(Offset.zero, ancestor: parentRenderBox);
    final size = renderBox.size;

    setState(() {
      _indicatorLeft = offset.dx;
      _indicatorWidth = size.width;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final motion = theme.motion;
    final spacing = theme.spacing;

    Widget tabRow = Row(
      mainAxisSize: widget.isExpanded ? MainAxisSize.max : MainAxisSize.min,
      children: List.generate(widget.tabs.length, (index) {
        final tab = widget.tabs[index];
        final isSelected = index == widget.selectedIndex;

        Widget tabWidget = _TabItem(
          key: _tabKeys[index],
          tab: tab,
          isSelected: isSelected,
          isEnabled: !tab.isDisabled && widget.onChanged != null,
          onTap: () => widget.onChanged?.call(index),
        );

        return widget.isExpanded
            ? Expanded(child: tabWidget)
            : Padding(
                padding: FInsets.only(right: index < widget.tabs.length - 1 ? spacing.md : 0),
                child: tabWidget,
              );
      }),
    );

    Widget result = Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: colors.border.muted, width: FBorderWidth.hairline),
            ),
          ),
          child: tabRow,
        ),
        AnimatedPositioned(
          duration: motion.normal,
          curve: motion.emphasized,
          left: _indicatorLeft,
          bottom: 0,
          child: AnimatedContainer(
            duration: motion.normal,
            curve: motion.emphasized,
            width: _indicatorWidth,
            height: FBorderWidth.medium,
            decoration: BoxDecoration(
              color: colors.accent.base,
              borderRadius: BorderRadius.circular(FBorderWidth.medium / 2),
            ),
          ),
        ),
      ],
    );

    if (!widget.isExpanded) {
      result = IntrinsicWidth(child: result);
    }

    return result;
  }
}

class _TabItem extends StatefulWidget {
  final FoundryTab tab;
  final bool isSelected;
  final bool isEnabled;
  final VoidCallback onTap;

  const _TabItem({
    super.key,
    required this.tab,
    required this.isSelected,
    required this.isEnabled,
    required this.onTap,
  });

  @override
  State<_TabItem> createState() => _TabItemState();
}

class _TabItemState extends State<_TabItem> {
  bool _isHovered = false;
  bool _isPressed = false;

  void _handleHover(bool isHovered) {
    if (widget.isEnabled) {
      setState(() => _isHovered = isHovered);
    }
  }

  void _handleTapDown(TapDownDetails _) {
    if (widget.isEnabled) {
      setState(() => _isPressed = true);
    }
  }

  void _handleTapUp(TapUpDetails _) {
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final typography = theme.typography;
    final spacing = theme.spacing;
    final motion = theme.motion;

    Color textColor;
    if (!widget.isEnabled) {
      textColor = colors.state.disabled.fg!;
    } else if (widget.isSelected) {
      textColor = colors.accent.base;
    } else if (_isHovered || _isPressed) {
      textColor = colors.fg.primary;
    } else {
      textColor = colors.fg.secondary;
    }

    final showBg = widget.isEnabled && (_isHovered || _isPressed) && !widget.isSelected;
    final bgColor = _isPressed ? colors.state.hover.bg : colors.state.hover.bg?.withValues(alpha: 0.5);

    return MouseRegion(
      cursor: widget.isEnabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: GestureDetector(
        onTap: widget.isEnabled ? widget.onTap : null,
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: motion.fast,
          curve: motion.easeOut,
          padding: FInsets.symmetric(horizontal: spacing.sm, vertical: spacing.sm),
          decoration: BoxDecoration(
            color: showBg ? bgColor : null,
            borderRadius: BorderRadius.circular(theme.radius.sm),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.tab.icon != null) ...[
                AnimatedDefaultTextStyle(
                  duration: motion.fast,
                  style: TextStyle(color: textColor),
                  child: Icon(widget.tab.icon, size: FIconSize.md, color: textColor),
                ),
                if (widget.tab.label != null) const FoundryGap.xs(),
              ],
              if (widget.tab.label != null)
                AnimatedDefaultTextStyle(
                  duration: motion.fast,
                  curve: motion.easeOut,
                  style: TextStyle(
                    color: textColor,
                    fontSize: typography.body,
                    fontWeight: widget.isSelected ? typography.medium : typography.regular,
                    fontFamily: typography.primary,
                    height: typography.snug,
                  ),
                  child: Text(widget.tab.label!),
                ),
              if (widget.tab.badge != null) ...[
                const FoundryGap.xs(),
                FoundryBadge(count: widget.tab.badge, size: FoundryBadgeSize.small),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Configuration for an individual tab.
class FoundryTab {
  final String? label;

  final IconData? icon;

  final int? badge;

  final bool isDisabled;

  const FoundryTab({this.label, this.icon, this.badge, this.isDisabled = false})
    : assert(label != null || icon != null, 'Either label or icon must be provided');
}

/// A complete tab interface combining tab bar and content views.
class FoundryTabView extends StatefulWidget {
  final List<FoundryTab> tabs;

  final List<Widget> children;

  final int initialIndex;

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
