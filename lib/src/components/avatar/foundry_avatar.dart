import 'package:flutter/widgets.dart';
import 'package:foundry_ds/src/theme/theme.dart';
import 'package:foundry_ds/src/foundations/foundations.dart';

import 'package:foundry_ds/src/semantic/semantic.dart';

/// Size presets for [FoundryAvatar].
enum FoundryAvatarSize { xs, sm, md, lg, xl }

/// A circular avatar displaying an image, initials, or icon with optional status indicator.
class FoundryAvatar extends StatelessWidget {
  final ImageProvider? image;
  final String? initials;
  final IconData? fallbackIcon;
  final FoundryAvatarSize size;
  final bool showStatus;
  final bool isOnline;

  const FoundryAvatar({
    super.key,
    this.image,
    this.initials,
    this.fallbackIcon,
    this.size = FoundryAvatarSize.md,
    this.showStatus = false,
    this.isOnline = false,
  });

  const FoundryAvatar.xs({
    super.key,
    this.image,
    this.initials,
    this.fallbackIcon,
    this.showStatus = false,
    this.isOnline = false,
  }) : size = FoundryAvatarSize.xs;

  const FoundryAvatar.sm({
    super.key,
    this.image,
    this.initials,
    this.fallbackIcon,
    this.showStatus = false,
    this.isOnline = false,
  }) : size = FoundryAvatarSize.sm;

  const FoundryAvatar.md({
    super.key,
    this.image,
    this.initials,
    this.fallbackIcon,
    this.showStatus = false,
    this.isOnline = false,
  }) : size = FoundryAvatarSize.md;

  const FoundryAvatar.lg({
    super.key,
    this.image,
    this.initials,
    this.fallbackIcon,
    this.showStatus = false,
    this.isOnline = false,
  }) : size = FoundryAvatarSize.lg;

  const FoundryAvatar.xl({
    super.key,
    this.image,
    this.initials,
    this.fallbackIcon,
    this.showStatus = false,
    this.isOnline = false,
  }) : size = FoundryAvatarSize.xl;

  double get _dimension {
    switch (size) {
      case FoundryAvatarSize.xs:
        return FControlSize.avatarXs;
      case FoundryAvatarSize.sm:
        return FControlSize.avatarSm;
      case FoundryAvatarSize.md:
        return FControlSize.avatarMd;
      case FoundryAvatarSize.lg:
        return FControlSize.avatarLg;
      case FoundryAvatarSize.xl:
        return FControlSize.avatarXl;
    }
  }

  double get _fontSize {
    switch (size) {
      case FoundryAvatarSize.xs:
        return FControlSize.avatarFontXs;
      case FoundryAvatarSize.sm:
        return FControlSize.avatarFontSm;
      case FoundryAvatarSize.md:
        return FControlSize.avatarFontMd;
      case FoundryAvatarSize.lg:
        return FControlSize.avatarFontLg;
      case FoundryAvatarSize.xl:
        return FControlSize.avatarFontXl;
    }
  }

  double get _iconSize {
    switch (size) {
      case FoundryAvatarSize.xs:
        return FIconSize.xs;
      case FoundryAvatarSize.sm:
        return FIconSize.sm;
      case FoundryAvatarSize.md:
        return FIconSize.md;
      case FoundryAvatarSize.lg:
        return FIconSize.lg;
      case FoundryAvatarSize.xl:
        return FIconSize.xl;
    }
  }

  double get _statusSize {
    switch (size) {
      case FoundryAvatarSize.xs:
        return FControlSize.statusXs;
      case FoundryAvatarSize.sm:
        return FControlSize.statusSm;
      case FoundryAvatarSize.md:
        return FControlSize.statusMd;
      case FoundryAvatarSize.lg:
        return FControlSize.statusLg;
      case FoundryAvatarSize.xl:
        return FControlSize.statusXl;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FoundryTheme.of(context);
    final colors = theme.colors;
    final typography = theme.typography;

    Widget content = Container(
      width: _dimension,
      height: _dimension,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: _buildAvatarContent(colors, typography),
    );

    if (!showStatus) {
      return content;
    }

    return SizedBox(
      width: _dimension,
      height: _dimension,
      child: Stack(
        children: [
          content,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: _statusSize,
              height: _statusSize,
              decoration: BoxDecoration(
                color: isOnline ? colors.status.positive.main : colors.fg.muted,
                shape: BoxShape.circle,
                border: Border.all(color: colors.bg.canvas, width: FBorderWidth.thin),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarContent(SemanticColors colors, SemanticTypography typography) {
    if (image != null) {
      return ClipOval(
        child: Image(
          image: image!,
          width: _dimension,
          height: _dimension,
          fit: BoxFit.cover,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) return child;
            return AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: FMotion.fadeIn,
              curve: FMotion.easeOut,
              child: child,
            );
          },
          errorBuilder: (context, error, stackTrace) => _buildFallback(colors, typography),
        ),
      );
    }
    return _buildFallback(colors, typography);
  }

  Widget _buildFallback(SemanticColors colors, SemanticTypography typography) {
    if (initials != null) {
      return Container(
        width: _dimension,
        height: _dimension,
        decoration: BoxDecoration(color: colors.accent.subtle, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Text(
          initials!.toUpperCase(),
          style: TextStyle(
            color: colors.accent.base,
            fontSize: _fontSize,
            fontWeight: typography.semibold,
            fontFamily: typography.primary,
          ),
        ),
      );
    }

    return Container(
      width: _dimension,
      height: _dimension,
      decoration: BoxDecoration(color: colors.bg.muted, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Icon(fallbackIcon ?? FIcons.user, size: _iconSize, color: colors.fg.muted),
    );
  }
}
