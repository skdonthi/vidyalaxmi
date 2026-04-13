import 'package:flutter/material.dart';

import '../../core/theme/z_colors.dart';

/// Segmented neon progress bar that pulses when charging.
class ZProgressBar extends StatefulWidget {
  const ZProgressBar({
    super.key,
    required this.value,
    this.segments = 10,
    this.color = ZColors.primary,
    this.height = 10,
    this.animate = true,
    this.pulsing = false,
  });

  final double value;   // 0.0 to 1.0
  final int segments;
  final Color color;
  final double height;
  final bool animate;
  final bool pulsing;

  @override
  State<ZProgressBar> createState() => _ZProgressBarState();
}

class _ZProgressBarState extends State<ZProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _pulseAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.80, end: 1.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.80), weight: 50),
    ]).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    if (widget.pulsing) {
      _pulseController.repeat();
    }
  }

  @override
  void didUpdateWidget(ZProgressBar old) {
    super.didUpdateWidget(old);
    if (widget.pulsing && !_pulseController.isAnimating) {
      _pulseController.repeat();
    } else if (!widget.pulsing && _pulseController.isAnimating) {
      _pulseController.stop();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseAnim,
      builder: (context, _) {
        final opacity = widget.pulsing ? _pulseAnim.value : 1.0;
        return LayoutBuilder(
          builder: (context, constraints) {
            final totalWidth = constraints.maxWidth;
            final gap = 2.0;
            final segW = (totalWidth - gap * (widget.segments - 1)) / widget.segments;
            final filledCount = (widget.value * widget.segments).clamp(0, widget.segments);

            return Row(
              children: List.generate(widget.segments, (i) {
                final filled = i < filledCount;
                final partial = filled
                    ? 1.0
                    : (i == filledCount.floor() && filledCount % 1 != 0)
                        ? filledCount % 1
                        : 0.0;

                return Padding(
                  padding: EdgeInsets.only(right: i < widget.segments - 1 ? gap : 0),
                  child: Container(
                    width: segW,
                    height: widget.height,
                    decoration: BoxDecoration(
                      color: ZColors.surfaceAlt,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: FractionallySizedBox(
                      widthFactor: partial,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.color.withOpacity(opacity),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: widget.color.withOpacity(0.4 * opacity),
                              blurRadius: 6,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        );
      },
    );
  }
}
