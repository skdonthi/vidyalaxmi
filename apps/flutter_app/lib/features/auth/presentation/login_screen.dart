import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/z_colors.dart';
import '../../../core/theme/z_text_styles.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/widgets/z_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      body: Stack(
        children: [
          const _CyberCityBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 2),
                  Text('विद्याLaxmi', style: ZTextStyles.h1Cyan),
                  const SizedBox(height: 8),
                  Text(
                    'Cyber-India Edition',
                    style: ZTextStyles.h2.copyWith(color: ZColors.secondary),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Knowledge is the ultimate Power-Up.\nYour quest begins now.',
                    style: ZTextStyles.body,
                  ),
                  const Spacer(flex: 3),
                  ZButton(
                    label: 'Start Quest',
                    icon: Icons.play_arrow_rounded,
                    onPressed: authState.isLoading
                        ? null
                        : () async {
                            await ref
                                .read(authNotifierProvider.notifier)
                                .signInAnonymously();
                            if (context.mounted) {
                              context.go(ZRoutes.skillTree);
                            }
                          },
                    isLoading: authState.isLoading,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 16),
                  ZButton(
                    label: 'Sign In with Email',
                    variant: ZButtonVariant.ghost,
                    onPressed: () {},
                    width: double.infinity,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CyberCityBackground extends StatefulWidget {
  const _CyberCityBackground();

  @override
  State<_CyberCityBackground> createState() => _CyberCityBackgroundState();
}

class _CyberCityBackgroundState extends State<_CyberCityBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _parallaxAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat(reverse: true);

    _parallaxAnim = Tween<double>(begin: -20, end: 20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _parallaxAnim,
      builder: (context, _) => Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF050505), Color(0xFF0A0E1A), Color(0xFF050505)],
                ),
              ),
            ),
          ),
          // Grid overlay — cyber aesthetic
          Positioned.fill(
            child: CustomPaint(painter: _GridPainter()),
          ),
          // Parallax glow orbs
          Positioned(
            top: 80 + _parallaxAnim.value * 0.2,
            right: -60 + _parallaxAnim.value * 0.5,
            child: _GlowOrb(color: ZColors.primary, size: 200),
          ),
          Positioned(
            bottom: 120 - _parallaxAnim.value * 0.3,
            left: -40 + _parallaxAnim.value * 0.5,
            child: _GlowOrb(color: ZColors.secondary, size: 160),
          ),
        ],
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.color, required this.size});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: color.withOpacity(0.15), blurRadius: size)],
        ),
      );
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00F2FF).withOpacity(0.04)
      ..strokeWidth = 0.5;

    const step = 40.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) => false;
}
