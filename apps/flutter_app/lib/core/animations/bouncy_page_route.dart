import 'package:flutter/material.dart';

/// Spring-physics page route for Duolingo-style navigation.
/// Use GoRouter for named routes; use this only for programmatic pushes.
class BouncyPageRoute<T> extends PageRouteBuilder<T> {
  BouncyPageRoute({
    required Widget page,
    super.settings,
  }) : super(
          pageBuilder: (_, __, ___) => page,
          transitionDuration: const Duration(milliseconds: 350),
          reverseTransitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final elasticIn = CurvedAnimation(
              parent: animation,
              curve: Curves.elasticOut,
              reverseCurve: Curves.easeIn,
            );

            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.06),
                end: Offset.zero,
              ).animate(elasticIn),
              child: FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                ),
                child: child,
              ),
            );
          },
        );
}

/// Modal scale-in transition (for overlays, reward screens).
class ZScaleRoute<T> extends PageRouteBuilder<T> {
  ZScaleRoute({
    required Widget page,
    super.settings,
  }) : super(
          pageBuilder: (_, __, ___) => page,
          transitionDuration: const Duration(milliseconds: 250),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          opaque: false,
          barrierDismissible: false,
          barrierColor: Colors.black54,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
              reverseCurve: Curves.easeIn,
            );

            return ScaleTransition(
              scale: Tween<double>(begin: 0.85, end: 1.0).animate(curved),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
}
