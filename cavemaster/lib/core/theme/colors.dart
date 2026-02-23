import 'package:flutter/material.dart';

abstract final class AppColors {
  // ── Backgrounds ──────────────────────────────────────────────────────────
  static const background = Color(0xFF0D0D0D);
  static const surfacePrimary = Color(0xFF1A1A1A);
  static const surfaceSecondary = Color(0xFF252525);
  static const surfaceTertiary = Color(0xFF303030);

  // ── Accent (Burgundy) ────────────────────────────────────────────────────
  static const accent = Color(0xFF8B2252);
  static const accentLight = Color(0xFFC75B7A);
  static const accentDark = Color(0xFF5C1538);

  // ── Text ─────────────────────────────────────────────────────────────────
  static const textPrimary = Color(0xFFF5F5F5);
  static const textSecondary = Color(0xFFA0A0A0);
  static const textDisabled = Color(0xFF555555);

  // ── Status ───────────────────────────────────────────────────────────────
  static const success = Color(0xFF4CAF50);    // Drink now / peak
  static const warning = Color(0xFFFF9800);    // Drink soon
  static const danger = Color(0xFFF44336);     // Past peak
  static const info = Color(0xFF2196F3);       // Keep aging

  // ── Wine type palette ────────────────────────────────────────────────────
  static const wineRed = Color(0xFF722F37);
  static const wineWhite = Color(0xFFE8D5A3);
  static const wineRose = Color(0xFFE8A0B4);
  static const wineSparkling = Color(0xFFC0C0C0);
  static const wineDessert = Color(0xFFDAA520);
  static const wineFortified = Color(0xFF8B4513);
  static const wineOrange = Color(0xFFE8923F);
  static const wineNatural = Color(0xFF7B9E6B);

  // ── Misc ─────────────────────────────────────────────────────────────────
  static const divider = Color(0xFF2A2A2A);
  static const shimmerBase = Color(0xFF1E1E1E);
  static const shimmerHighlight = Color(0xFF2C2C2C);
  static const overlay = Color(0x80000000);
}
