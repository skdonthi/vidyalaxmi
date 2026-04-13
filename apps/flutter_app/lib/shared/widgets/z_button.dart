import 'package:flutter/material.dart';

import '../../core/animations/haptic_utils.dart';
import '../../core/theme/z_colors.dart';
import '../../core/theme/z_text_styles.dart';

enum ZButtonVariant { primary, secondary, ghost }

/// Glassmorphism button from DESIGN.md.
/// Blur 10px, 1px neon border, 10% white background.
class ZButton extends StatefulWidget {
  const ZButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = ZButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.width,
  });

  final String label;
  final VoidCallback? onPressed;
  final ZButtonVariant variant;
  final bool isLoading;
  final IconData? icon;
  final double? width;

  @override
  State<ZButton> createState() => _ZButtonState();
}

class _ZButtonState extends State<ZButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.96), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 0.96, end: 1.02), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.02, end: 1.0), weight: 30),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get _borderColor => switch (widget.variant) {
        ZButtonVariant.primary => ZColors.primary,
        ZButtonVariant.secondary => ZColors.secondary,
        ZButtonVariant.ghost => ZColors.border,
      };

  Color get _textColor => switch (widget.variant) {
        ZButtonVariant.primary => ZColors.primary,
        ZButtonVariant.secondary => ZColors.secondary,
        ZButtonVariant.ghost => ZColors.textMuted,
      };

  List<BoxShadow> get _glow => switch (widget.variant) {
        ZButtonVariant.primary => ZColors.glowCyan(intensity: 0.35, blur: 16),
        ZButtonVariant.secondary => ZColors.glowMagenta(intensity: 0.35, blur: 16),
        ZButtonVariant.ghost => [],
      };

  Future<void> _handleTap() async {
    if (widget.onPressed == null || widget.isLoading) return;
    await ZHaptics.tap();
    _controller.forward(from: 0);
    widget.onPressed!();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnim,
      child: GestureDetector(
        onTap: _handleTap,
        child: Container(
          width: widget.width,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color: ZColors.overlay,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _borderColor),
            boxShadow: _glow,
          ),
          child: widget.isLoading
              ? SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: _textColor,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(widget.icon, color: _textColor, size: 20),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.label,
                      style: ZTextStyles.body.copyWith(
                        color: _textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
