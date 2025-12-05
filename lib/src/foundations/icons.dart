import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Semantic icon aliases for commonly used icons in the design system.
///
/// Use [FIcons] for semantic references that communicate intent:
/// - `FIcons.close` instead of `LucideIcons.x`
/// - `FIcons.checkCircle` instead of `LucideIcons.circleCheck`
///
/// For the full catalog of 1500+ icons, use [LucideIcons] directly:
/// ```dart
/// Icon(LucideIcons.airplane)
/// Icon(LucideIcons.bitcoin)
/// Icon(LucideIcons.coffee)
/// ```
///
/// See all icons at: https://lucide.dev/icons
class FIcons {
  FIcons._();

  // ─────────────────────────────────────────────────────────────────────────
  // Navigation & Actions
  // ─────────────────────────────────────────────────────────────────────────

  /// Close/dismiss action
  static const IconData close = LucideIcons.x;

  /// Back navigation
  static const IconData arrowLeft = LucideIcons.arrowLeft;

  /// Forward navigation
  static const IconData arrowRight = LucideIcons.arrowRight;

  /// Expand/show more
  static const IconData chevronDown = LucideIcons.chevronDown;

  /// Collapse/show less
  static const IconData chevronUp = LucideIcons.chevronUp;

  /// Menu/hamburger
  static const IconData menu = LucideIcons.menu;

  /// More options (horizontal dots)
  static const IconData moreHorizontal = LucideIcons.ellipsis;

  /// More options (vertical dots)
  static const IconData moreVertical = LucideIcons.ellipsisVertical;

  // ─────────────────────────────────────────────────────────────────────────
  // Status & Feedback
  // ─────────────────────────────────────────────────────────────────────────

  /// Success/positive state
  static const IconData checkCircle = LucideIcons.circleCheck;

  /// Check mark (no circle)
  static const IconData check = LucideIcons.check;

  /// Minus (for indeterminate state)
  static const IconData minus = LucideIcons.minus;

  /// Information
  static const IconData info = LucideIcons.info;

  /// Warning/caution
  static const IconData alertTriangle = LucideIcons.triangleAlert;

  /// Error/danger
  static const IconData alertCircle = LucideIcons.circleAlert;

  // ─────────────────────────────────────────────────────────────────────────
  // User & Profile
  // ─────────────────────────────────────────────────────────────────────────

  /// Single user/profile
  static const IconData user = LucideIcons.user;

  /// Multiple users
  static const IconData users = LucideIcons.users;

  // ─────────────────────────────────────────────────────────────────────────
  // Common Actions
  // ─────────────────────────────────────────────────────────────────────────

  /// Add/create new
  static const IconData plus = LucideIcons.plus;

  /// Delete/remove
  static const IconData trash = LucideIcons.trash2;

  /// Edit/modify
  static const IconData edit = LucideIcons.pencil;

  /// Search
  static const IconData search = LucideIcons.search;

  /// Settings/preferences
  static const IconData settings = LucideIcons.settings;

  /// Share
  static const IconData share = LucideIcons.share2;

  /// Copy
  static const IconData copy = LucideIcons.copy;

  /// Download
  static const IconData download = LucideIcons.download;

  /// Upload
  static const IconData upload = LucideIcons.upload;

  /// Refresh/reload
  static const IconData refresh = LucideIcons.refreshCw;

  /// External link
  static const IconData externalLink = LucideIcons.externalLink;

  // ─────────────────────────────────────────────────────────────────────────
  // Media & Content
  // ─────────────────────────────────────────────────────────────────────────

  /// Image/photo
  static const IconData image = LucideIcons.image;

  /// File/document
  static const IconData file = LucideIcons.file;

  /// Folder
  static const IconData folder = LucideIcons.folder;

  /// Calendar
  static const IconData calendar = LucideIcons.calendar;

  /// Clock/time
  static const IconData clock = LucideIcons.clock;

  // ─────────────────────────────────────────────────────────────────────────
  // Communication
  // ─────────────────────────────────────────────────────────────────────────

  /// Email/mail
  static const IconData mail = LucideIcons.mail;

  /// Message/chat
  static const IconData messageCircle = LucideIcons.messageCircle;

  /// Phone
  static const IconData phone = LucideIcons.phone;

  /// Bell/notification
  static const IconData bell = LucideIcons.bell;

  // ─────────────────────────────────────────────────────────────────────────
  // Toggle States
  // ─────────────────────────────────────────────────────────────────────────

  /// Eye (show/visible)
  static const IconData eye = LucideIcons.eye;

  /// Eye off (hide/invisible)
  static const IconData eyeOff = LucideIcons.eyeOff;

  /// Lock (secured)
  static const IconData lock = LucideIcons.lock;

  /// Unlock (unsecured)
  static const IconData lockOpen = LucideIcons.lockOpen;

  /// Star (favorite)
  static const IconData star = LucideIcons.star;

  /// Heart (like)
  static const IconData heart = LucideIcons.heart;

  // ─────────────────────────────────────────────────────────────────────────
  // Misc
  // ─────────────────────────────────────────────────────────────────────────

  /// Loading spinner
  static const IconData loader = LucideIcons.loaderCircle;

  /// Home
  static const IconData home = LucideIcons.house;

  /// Link
  static const IconData link = LucideIcons.link;

  /// Grip/drag handle
  static const IconData gripVertical = LucideIcons.gripVertical;
}
