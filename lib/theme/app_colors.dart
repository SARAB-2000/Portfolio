import 'package:flutter/material.dart';

/// Semantic colors that adapt to light/dark theme.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceLight,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.navScrolled,
  });

  final Color background;
  final Color surface;
  final Color surfaceLight;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color navScrolled;

  static const dark = AppColors(
    background: Color(0xFF08080D),
    surface: Color(0xFF12121A),
    surfaceLight: Color(0xFF1A1A26),
    border: Color(0xFF2A2A3A),
    textPrimary: Color(0xFFF5F5F7),
    textSecondary: Color(0xFF9CA3AF),
    navScrolled: Color(0xD908080D),
  );

  static const light = AppColors(
    background: Color(0xFFFAFAFC),
    surface: Color(0xFFFFFFFF),
    surfaceLight: Color(0xFFF3F4F6),
    border: Color(0xFFE5E7EB),
    textPrimary: Color(0xFF111827),
    textSecondary: Color(0xFF6B7280),
    navScrolled: Color(0xE6FAFAFC),
  );

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceLight,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
    Color? navScrolled,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceLight: surfaceLight ?? this.surfaceLight,
      border: border ?? this.border,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      navScrolled: navScrolled ?? this.navScrolled,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceLight: Color.lerp(surfaceLight, other.surfaceLight, t)!,
      border: Color.lerp(border, other.border, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      navScrolled: Color.lerp(navScrolled, other.navScrolled, t)!,
    );
  }
}

extension AppColorsX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>() ?? AppColors.dark;
}
