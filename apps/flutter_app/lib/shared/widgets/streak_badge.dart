import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../core/theme/z_colors.dart';
import '../../core/theme/z_text_styles.dart';
import '../providers/economy_provider.dart';

class StreakBadge extends ConsumerWidget {
  const StreakBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streak = ref.watch(streakDaysProvider);

    return streak.when(
      data: (days) => _StreakDisplay(days: days),
      loading: () => const _StreakDisplay(days: 0),
      error: (_, __) => const _StreakDisplay(days: 0),
    );
  }
}

class _StreakDisplay extends StatefulWidget {
  const _StreakDisplay({required this.days});
  final int days;

  @override
  State<_StreakDisplay> createState() => _StreakDisplayState();
}

class _StreakDisplayState extends State<_StreakDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _pulseAnim = Tween<double>(begin: 1.0, end: 1.05)
        .animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _pulseAnim,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_fire_department, color: ZColors.warning, size: 22),
          const SizedBox(width: 4),
          Text(
            '${widget.days}',
            style: ZTextStyles.body.copyWith(
              color: ZColors.warning,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
