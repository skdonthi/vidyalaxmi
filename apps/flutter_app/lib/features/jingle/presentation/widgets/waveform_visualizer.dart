import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/theme/z_colors.dart';

/// Animated neon waveform behind mentor character.
class WaveformVisualizer extends StatefulWidget {
  const WaveformVisualizer({super.key, this.color = ZColors.primary});
  final Color color;

  @override
  State<WaveformVisualizer> createState() => _WaveformVisualizerState();
}

class _WaveformVisualizerState extends State<WaveformVisualizer>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final _rng = math.Random();
  final List<double> _heights = List.generate(32, (_) => 0.3);

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    )..addListener(() {
        setState(() {
          for (int i = 0; i < _heights.length; i++) {
            _heights[i] = 0.15 + _rng.nextDouble() * 0.85;
          }
        });
      })
      ..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(_heights.length, (i) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 80),
            width: 4,
            height: 60 * _heights[i],
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.6),
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.3),
                  blurRadius: 4,
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
