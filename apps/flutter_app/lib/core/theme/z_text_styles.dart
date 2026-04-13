import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'z_colors.dart';

/// Typography tokens from DESIGN.md.
/// All text uses Lexend for neurodiversity-optimized readability.
abstract final class ZTextStyles {
  static TextStyle get h1 => GoogleFonts.lexend(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: ZColors.textPrimary,
        height: 1.2,
        letterSpacing: -0.5,
      );

  static TextStyle get h2 => GoogleFonts.lexend(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: ZColors.textPrimary,
        height: 1.2,
        letterSpacing: -0.3,
      );

  static TextStyle get body => GoogleFonts.lexend(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: ZColors.textPrimary,
        height: 1.6,
      );

  static TextStyle get caption => GoogleFonts.lexend(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: ZColors.textMuted,
        height: 1.4,
      );

  static TextStyle get micro => GoogleFonts.lexend(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: ZColors.textMuted,
        height: 1.4,
        letterSpacing: 0.5,
      );

  // ── Colored variants ──────────────────────────────────────────────────────
  static TextStyle get h1Cyan => h1.copyWith(color: ZColors.primary);
  static TextStyle get h1Magenta => h1.copyWith(color: ZColors.secondary);
  static TextStyle get h1Gold => h1.copyWith(color: ZColors.gold);

  static TextStyle get h2Cyan => h2.copyWith(color: ZColors.primary);
  static TextStyle get h2Muted => h2.copyWith(color: ZColors.textMuted);

  static TextStyle get bodyMuted => body.copyWith(color: ZColors.textMuted);
  static TextStyle get bodyCyan => body.copyWith(color: ZColors.primary);
  static TextStyle get bodySuccess => body.copyWith(color: ZColors.success);
  static TextStyle get bodyWarning => body.copyWith(color: ZColors.warning);
}
