import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../core/animations/haptic_utils.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/z_colors.dart';
import '../../../core/theme/z_text_styles.dart';
import '../../../shared/providers/economy_provider.dart';
import '../../../shared/providers/progress_provider.dart';
import '../../../shared/widgets/lcoin_counter.dart';
import '../../../shared/widgets/z_button.dart';

class RewardScreen extends ConsumerStatefulWidget {
  const RewardScreen({
    super.key,
    required this.topicId,
    required this.coinsEarned,
  });

  final String topicId;
  final int coinsEarned;

  @override
  ConsumerState<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends ConsumerState<RewardScreen>
    with TickerProviderStateMixin {
  late AnimationController _entryCtrl;

  @override
  void initState() {
    super.initState();

    _entryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    _awardCoins();
  }

  Future<void> _awardCoins() async {
    await Future.delayed(const Duration(milliseconds: 300));
    await ZHaptics.reward();

    // Update progress in Supabase
    await ref.read(userProgressProvider.notifier).updateProgress(
          topicId: widget.topicId,
          score: widget.coinsEarned * 10, // Approximate score from coins
          accuracy: 1.0, // Assuming 100% for MVP demo
          difficulty: 1,
          completed: true,
        );

    // Award L-Coins
    await ref.read(economyNotifierProvider.notifier).awardCoins(
          amount: widget.coinsEarned,
          description: 'Completed topic: ${widget.topicId}',
        );
  }

  @override
  void dispose() {
    _entryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZColors.base,
      body: Stack(
        children: [
          // Confetti Lottie
          Positioned.fill(
            child: IgnorePointer(
              child: LottieBuilder.asset(
                'assets/lottie/confetti.json',
                repeat: false,
                errorBuilder: (_, __, ___) => const _FallbackConfetti(),
              ),
            ),
          ),
          SafeArea(
            child: FadeTransition(
              opacity: _entryCtrl,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.85, end: 1.0).animate(
                  CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOutBack),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    children: [
                      const Spacer(),
                      // Trophy icon (mentor placeholder)
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: ZColors.gold, width: 3),
                          boxShadow: ZColors.glowGold(intensity: 0.5, blur: 32),
                          color: ZColors.surfaceAlt,
                        ),
                        child: const Icon(
                          Icons.emoji_events,
                          color: ZColors.gold,
                          size: 72,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text('Quest Complete!', style: ZTextStyles.h1Cyan),
                      const SizedBox(height: 8),
                      Text('You earned', style: ZTextStyles.bodyMuted),
                      const SizedBox(height: 12),
                      LCoinCounterLarge(amount: widget.coinsEarned),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.monetization_on, color: ZColors.gold, size: 20),
                          const SizedBox(width: 6),
                          Text('L-Coins', style: ZTextStyles.body.copyWith(color: ZColors.gold)),
                        ],
                      ),
                      const Spacer(),

                      // Customization unlock teaser
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: ZColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: ZColors.secondary),
                          boxShadow: ZColors.glowMagenta(intensity: 0.2),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: ZColors.secondary, size: 32),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Unlocked: Neon Visor', style: ZTextStyles.h2.copyWith(color: ZColors.secondary)),
                                  Text('New item for Arya!', style: ZTextStyles.bodyMuted),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Actions
                      ZButton(
                        label: 'Continue Quest',
                        icon: Icons.arrow_forward,
                        onPressed: () => context.go(ZRoutes.skillTree),
                        width: double.infinity,
                      ),
                      const SizedBox(height: 12),
                      ZButton(
                        label: 'View Manga Cheat Sheet',
                        variant: ZButtonVariant.secondary,
                        icon: Icons.auto_stories,
                        onPressed: () => context.push('/scroll/${widget.topicId}'),
                        width: double.infinity,
                      ),
                      const SizedBox(height: 12),
                      ZButton(
                        label: 'Customize Mentor',
                        variant: ZButtonVariant.ghost,
                        icon: Icons.brush,
                        onPressed: () => context.push(ZRoutes.mentorCustomizer),
                        width: double.infinity,
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FallbackConfetti extends StatefulWidget {
  const _FallbackConfetti();

  @override
  State<_FallbackConfetti> createState() => _FallbackConfettiState();
}

class _FallbackConfettiState extends State<_FallbackConfetti>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) => CustomPaint(
        painter: _ConfettiPainter(progress: _ctrl.value),
      ),
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter({required this.progress});
  final double progress;

  static final _colors = [
    ZColors.primary,
    ZColors.secondary,
    ZColors.success,
    ZColors.gold,
    ZColors.warning,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final rng = progress.hashCode;
    for (int i = 0; i < 60; i++) {
      final x = ((rng * (i + 1) * 1234567) % size.width.toInt()).abs().toDouble();
      final yStart = -20.0;
      final y = yStart + progress * size.height * 1.2 + (i * 13 % 80);
      final color = _colors[i % _colors.length];
      final paint = Paint()..color = color.withOpacity(1.0 - progress * 0.8);
      canvas.drawCircle(Offset(x, y), 4, paint);
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => old.progress != progress;
}
