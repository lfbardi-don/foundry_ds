import 'package:flutter/material.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';
import 'package:foundry_ds/src/components/components.dart';
import 'package:foundry_ds/src/semantic/semantic.dart';

/// A text input field with label, placeholder, validation, and icon support.
class FoundryInput extends StatefulWidget {
  final TextEditingController? controller;

  final String? placeholder;

  final String? label;

  final String? errorText;

  final String? helperText;

  final bool obscureText;

  final ValueChanged<String>? onChanged;

  final VoidCallback? onTap;

  final bool enabled;

  final FocusNode? focusNode;

  final Widget? prefixIcon;

  final Widget? suffixIcon;

  final TextInputType? keyboardType;

  final TextInputAction? textInputAction;

  final int maxLines;

  final VoidCallback? onEditingComplete;

  final ValueChanged<String>? onSubmitted;

  const FoundryInput({
    super.key,
    this.controller,
    this.placeholder,
    this.label,
    this.errorText,
    this.helperText,
    this.obscureText = false,
    this.onChanged,
    this.onTap,
    this.enabled = true,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.onEditingComplete,
    this.onSubmitted,
  });

  @override
  State<FoundryInput> createState() => _FoundryInputState();
}

class _FoundryInputState extends State<FoundryInput> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(FoundryInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode.removeListener(_handleFocusChange);
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_handleFocusChange);
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_handleFocusChange);
    }
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  void _handleHover(bool isHovered) {
    if (widget.enabled) {
      setState(() => _isHovered = isHovered);
    }
  }

  EdgeInsetsGeometry _buildContentPadding(SemanticSpacing spacing) {
    return FInsets.symmetric(horizontal: widget.prefixIcon != null ? spacing.sm : spacing.md, vertical: spacing.sm);
  }

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final typography = theme.typography;
    final spacing = theme.spacing;
    final radius = theme.radius;
    final motion = theme.motion;

    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;
    final hasHelperText = widget.helperText != null && widget.helperText!.isNotEmpty;

    final borderColor = !widget.enabled
        ? colors.state.disabled.border ?? colors.border.muted
        : hasError
        ? colors.status.negative.border
        : _isFocused
        ? colors.fg.secondary
        : _isHovered
        ? colors.border.strong
        : colors.input.border;

    final backgroundColor = !widget.enabled
        ? colors.state.disabled.bg
        : _isHovered && !_isFocused
        ? colors.state.hover.bg
        : colors.input.bg;

    final focusShadow = _isFocused && widget.enabled && !hasError ? FShadow.sm : FShadow.none;

    final errorShadow = _isFocused && widget.enabled && hasError ? FShadow.xs : <BoxShadow>[];

    final effectiveShadow = hasError ? errorShadow : focusShadow;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          FoundryText.bodySmall(
            widget.label!,
            color: widget.enabled ? colors.fg.primary : colors.fg.muted,
            weight: typography.medium,
          ),
          const FoundryGap.xs(),
        ],

        MouseRegion(
          cursor: widget.enabled ? SystemMouseCursors.text : SystemMouseCursors.forbidden,
          onEnter: (_) => _handleHover(true),
          onExit: (_) => _handleHover(false),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: widget.maxLines == 1 ? FControlSize.buttonMd : 0),
            child: AnimatedContainer(
              duration: motion.fast,
              curve: motion.easeOut,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(radius.md),
                border: Border.all(color: borderColor, width: _isFocused ? FBorderWidth.medium : FBorderWidth.thin),
                boxShadow: effectiveShadow,
              ),
              child: Row(
                children: [
                  if (widget.prefixIcon != null) ...[
                    Padding(
                      padding: FInsets.only(left: spacing.md),
                      child: IconTheme(
                        data: IconThemeData(
                          color: widget.enabled ? colors.fg.secondary : colors.fg.muted,
                          size: FIconSize.md,
                        ),
                        child: widget.prefixIcon!,
                      ),
                    ),
                  ],

                  Expanded(
                    child: TextField(
                      controller: widget.controller,
                      focusNode: _focusNode,
                      obscureText: widget.obscureText,
                      onChanged: widget.onChanged,
                      onTap: widget.onTap,
                      enabled: widget.enabled,
                      keyboardType: widget.keyboardType,
                      textInputAction: widget.textInputAction,
                      maxLines: widget.maxLines,
                      onEditingComplete: widget.onEditingComplete,
                      onSubmitted: widget.onSubmitted,
                      style: TextStyle(
                        color: widget.enabled ? colors.fg.primary : colors.fg.muted,
                        fontSize: typography.body,
                        fontWeight: typography.regular,
                        fontFamily: typography.primary,
                        height: typography.snug,
                      ),
                      cursorColor: colors.fg.primary,
                      decoration: InputDecoration(
                        hintText: widget.placeholder,
                        hintStyle: TextStyle(
                          color: colors.input.placeholder,
                          fontSize: typography.body,
                          fontWeight: typography.regular,
                          fontFamily: typography.primary,
                          height: typography.snug,
                        ),
                        filled: false,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        contentPadding: _buildContentPadding(spacing),
                        isDense: true,
                      ),
                    ),
                  ),

                  if (widget.suffixIcon != null) ...[
                    Padding(
                      padding: FInsets.only(right: spacing.md),
                      child: IconTheme(
                        data: IconThemeData(
                          color: widget.enabled ? colors.fg.secondary : colors.fg.muted,
                          size: FIconSize.md,
                        ),
                        child: widget.suffixIcon!,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),

        if (hasError || hasHelperText) ...[
          const FoundryGap.xs(),
          FoundryText.caption(
            hasError ? widget.errorText! : widget.helperText!,
            color: hasError ? colors.status.negative.fg : colors.fg.secondary,
          ),
        ],
      ],
    );
  }
}
