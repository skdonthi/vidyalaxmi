import 'package:flutter/material.dart';

import '../../core/theme/z_colors.dart';

/// Dark surface card with subject-color glow from DESIGN.md.
class ZCard extends StatelessWidget {
  const ZCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.glowColor,
    this.borderRadius = 16,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? glowColor;
  final double borderRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final glow = glowColor;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: padding,
        decoration: BoxDecoration(
          color: ZColors.surface,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: ZColors.border),
          boxShadow: glow != null
              ? [BoxShadow(color: glow.withOpacity(0.20), blurRadius: 24, spreadRadius: 0)]
              : [],
        ),
        child: child,
      ),
    );
  }
}

/// A card that lifts on hover/tap (web + desktop).
class ZHoverCard extends StatefulWidget {
  const ZHoverCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.glowColor,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? glowColor;
  final VoidCallback? onTap;

  @override
  State<ZHoverCard> createState() => _ZHoverCardState();
}

class _ZHoverCardState extends State<ZHoverCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
          padding: widget.padding,
          decoration: BoxDecoration(
            color: ZColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ZColors.border),
            boxShadow: widget.glowColor != null
                ? [
                    BoxShadow(
                      color: widget.glowColor!.withOpacity(_hovered ? 0.35 : 0.20),
                      blurRadius: _hovered ? 32 : 24,
                    )
                  ]
                : [],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
