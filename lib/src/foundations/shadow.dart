import 'package:flutter/widgets.dart' show BoxShadow, Color, Offset;

/// Standardized box shadow tokens for consistent elevation effects.
class FShadow {
  FShadow._();

  static const List<BoxShadow> none = [];

  static const List<BoxShadow> xs = [BoxShadow(color: Color(0x0D000000), offset: Offset(0, 1), blurRadius: 2)];

  static const List<BoxShadow> sm = [
    BoxShadow(color: Color(0x0F000000), offset: Offset(0, 1), blurRadius: 2),
    BoxShadow(color: Color(0x0A000000), offset: Offset(0, 1), blurRadius: 1),
  ];

  static const List<BoxShadow> md = [
    BoxShadow(color: Color(0x1A000000), offset: Offset(0, 4), blurRadius: 6, spreadRadius: -1),
    BoxShadow(color: Color(0x10000000), offset: Offset(0, 2), blurRadius: 4, spreadRadius: -1),
  ];

  static const List<BoxShadow> lg = [
    BoxShadow(color: Color(0x1A000000), offset: Offset(0, 10), blurRadius: 15, spreadRadius: -3),
    BoxShadow(color: Color(0x0A000000), offset: Offset(0, 4), blurRadius: 6, spreadRadius: -2),
  ];

  static const List<BoxShadow> xl = [
    BoxShadow(color: Color(0x1A000000), offset: Offset(0, 20), blurRadius: 25, spreadRadius: -5),
    BoxShadow(color: Color(0x0A000000), offset: Offset(0, 10), blurRadius: 10, spreadRadius: -5),
  ];

  static const List<BoxShadow> thumb = [BoxShadow(color: Color(0x1A000000), blurRadius: 4, offset: Offset(0, 2))];

  static const List<BoxShadow> darkXs = [BoxShadow(color: Color(0x4D000000), offset: Offset(0, 1), blurRadius: 2)];

  static const List<BoxShadow> darkSm = [
    BoxShadow(color: Color(0x66000000), offset: Offset(0, 1), blurRadius: 2),
    BoxShadow(color: Color(0x4D000000), offset: Offset(0, 1), blurRadius: 1),
  ];

  static const List<BoxShadow> darkMd = [
    BoxShadow(color: Color(0x80000000), offset: Offset(0, 4), blurRadius: 6, spreadRadius: -1),
    BoxShadow(color: Color(0x66000000), offset: Offset(0, 2), blurRadius: 4, spreadRadius: -1),
  ];

  static const List<BoxShadow> darkLg = [
    BoxShadow(color: Color(0x99000000), offset: Offset(0, 10), blurRadius: 15, spreadRadius: -3),
    BoxShadow(color: Color(0x66000000), offset: Offset(0, 4), blurRadius: 6, spreadRadius: -2),
  ];

  static const List<BoxShadow> darkXl = [
    BoxShadow(color: Color(0xB3000000), offset: Offset(0, 20), blurRadius: 25, spreadRadius: -5),
    BoxShadow(color: Color(0x66000000), offset: Offset(0, 10), blurRadius: 10, spreadRadius: -5),
  ];

  static const double glowBlur = 4.0;

  static const double glowSpread = 1.0;
}
