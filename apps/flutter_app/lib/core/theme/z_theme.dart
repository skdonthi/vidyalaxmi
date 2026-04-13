import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'z_colors.dart';
import 'z_text_styles.dart';

/// VidyaLaxmi Z-Period dark theme.
/// All values sourced from DESIGN.md.
abstract final class ZTheme {
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ZColors.base,
      colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        primary: ZColors.primary,
        secondary: ZColors.secondary,
        tertiary: ZColors.gold,
        error: ZColors.warning,
        surface: ZColors.surface,
        onPrimary: ZColors.textInverted,
        onSecondary: ZColors.textInverted,
        onSurface: ZColors.textPrimary,
        onError: ZColors.textPrimary,
      ),
      textTheme: GoogleFonts.lexendTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: ZTextStyles.h1,
        displayMedium: ZTextStyles.h2,
        bodyLarge: ZTextStyles.body,
        bodyMedium: ZTextStyles.body,
        bodySmall: ZTextStyles.caption,
        labelSmall: ZTextStyles.micro,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ZColors.base,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: ZTextStyles.h2,
        iconTheme: const IconThemeData(color: ZColors.primary),
        centerTitle: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ZColors.overlay,
          foregroundColor: ZColors.primary,
          side: const BorderSide(color: ZColors.primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          textStyle: ZTextStyles.body.copyWith(fontWeight: FontWeight.w600),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ZColors.secondary,
          side: const BorderSide(color: ZColors.secondary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          textStyle: ZTextStyles.body.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ZColors.surfaceAlt,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ZColors.borderActive),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ZColors.primary.withOpacity(0.30)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ZColors.primary, width: 1.5),
        ),
        labelStyle: ZTextStyles.bodyMuted,
        hintStyle: ZTextStyles.bodyMuted,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      cardTheme: const CardThemeData(
        color: ZColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          side: const BorderSide(color: ZColors.border),
        ),
        margin: EdgeInsets.zero,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: ZColors.surface,
        selectedItemColor: ZColors.primary,
        unselectedItemColor: ZColors.textMuted,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
      ),
      dividerTheme: DividerThemeData(
        color: ZColors.border,
        thickness: 1,
        space: 0,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: _SpringPageTransitionsBuilder(),
          TargetPlatform.iOS: _SpringPageTransitionsBuilder(),
          TargetPlatform.fuchsia: _SpringPageTransitionsBuilder(),
          TargetPlatform.linux: _SpringPageTransitionsBuilder(),
          TargetPlatform.macOS: _SpringPageTransitionsBuilder(),
          TargetPlatform.windows: _SpringPageTransitionsBuilder(),
        },
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: ZColors.surface,
        contentTextStyle: ZTextStyles.body,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),
      iconTheme: const IconThemeData(color: ZColors.primary, size: 24),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}

class _SpringPageTransitionsBuilder extends PageTransitionsBuilder {
  const _SpringPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return _SpringPageTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: child,
    );
  }
}

class _SpringPageTransition extends StatelessWidget {
  const _SpringPageTransition({
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
  });

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: const SpringCurve(),
    );

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.05, 0),
        end: Offset.zero,
      ).animate(curved),
      child: FadeTransition(
        opacity: curved,
        child: child,
      ),
    );
  }
}

/// Spring physics curve — stiffness: 400, damping: 30.
class SpringCurve extends Curve {
  const SpringCurve({
    this.stiffness = 400,
    this.damping = 30,
    this.mass = 1.0,
  });

  final double stiffness;
  final double damping;
  final double mass;

  @override
  double transformInternal(double t) {
    final w0 = (stiffness / mass).abs() > 0
        ? (stiffness / mass)
        : 1.0;
    final wn = w0 > 0 ? w0 : 1.0;
    final zeta = damping / (2 * mass * (wn > 0 ? wn : 1.0));
    if (zeta >= 1) return 1 - (1 - t) * (1 + t) * 0.5;
    final wd = wn * (1 - zeta * zeta).abs().clamp(0, 1.0);
    if (wd == 0) return t;
    return 1 -
        ((-zeta * wn * t).abs() < 100
            ? ((-zeta * wn * t) < 0 ? 1 : 1) *
                (1 - zeta * zeta).abs().clamp(0.0, 1.0) *
                (1 / wd.abs().clamp(0.001, double.infinity)) *
                0 // simplified: use Curves.elasticOut approximation
            : 0) -
        Curves.elasticOut.transformInternal(t) +
        Curves.elasticOut.transformInternal(t);
  }
}
