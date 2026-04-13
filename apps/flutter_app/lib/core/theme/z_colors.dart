import 'package:flutter/material.dart';

/// All color tokens for VidyaLaxmi Cyber-India design system.
/// Values derived from DESIGN.md — do not hardcode hex elsewhere.
abstract final class ZColors {
  // ── Surface ─────────────────────────────────────────────────────────────────
  static const Color base = Color(0xFF050505);
  static const Color surface = Color(0xFF0F1117);
  static const Color surfaceAlt = Color(0xFF1A1D27);
  static const Color surfaceHighlight = Color(0xFF2A2D3A);

  // ── Brand / Accent ───────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF00F2FF);    // Neon Cyan
  static const Color secondary = Color(0xFFFF00E5);  // Cyber Magenta
  static const Color success = Color(0xFF39FF14);    // Neon Green
  static const Color warning = Color(0xFFFF3131);    // Bright Red
  static const Color gold = Color(0xFFFFD700);       // L-Coin / Streak

  // ── Text ────────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFEAEAEA);
  static const Color textMuted = Color(0xFF6B7280);
  static const Color textInverted = Color(0xFF050505);

  // ── Subject Glow Mapping ────────────────────────────────────────────────────
  static const Color glowPhysics = primary;    // Zayn
  static const Color glowMath = secondary;     // Arya
  static const Color glowBio = success;        // Dhara

  // ── Utility ─────────────────────────────────────────────────────────────────
  static const Color border = Color(0x0FFFFFFF);        // ~6% white
  static const Color borderActive = Color(0x4D00F2FF);  // 30% cyan
  static const Color overlay = Color(0x1AFFFFFF);       // 10% white

  // ── Glow BoxShadows ─────────────────────────────────────────────────────────
  static List<BoxShadow> glowCyan({double intensity = 0.35, double blur = 16}) =>
      [BoxShadow(color: primary.withOpacity(intensity), blurRadius: blur)];

  static List<BoxShadow> glowMagenta({double intensity = 0.35, double blur = 16}) =>
      [BoxShadow(color: secondary.withOpacity(intensity), blurRadius: blur)];

  static List<BoxShadow> glowGreen({double intensity = 0.35, double blur = 16}) =>
      [BoxShadow(color: success.withOpacity(intensity), blurRadius: blur)];

  static List<BoxShadow> glowGold({double intensity = 0.35, double blur = 16}) =>
      [BoxShadow(color: gold.withOpacity(intensity), blurRadius: blur)];

  static List<BoxShadow> glowRed({double intensity = 0.35, double blur = 16}) =>
      [BoxShadow(color: warning.withOpacity(intensity), blurRadius: blur)];

  static List<BoxShadow> glowForSubject(String subject) {
    return switch (subject.toLowerCase()) {
      'physics' || 'tech' => glowCyan(),
      'math' || 'logic' => glowMagenta(),
      'bio' || 'social' => glowGreen(),
      _ => glowCyan(),
    };
  }
}
