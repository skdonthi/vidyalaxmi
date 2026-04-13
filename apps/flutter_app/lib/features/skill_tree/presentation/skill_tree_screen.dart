import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/z_colors.dart';
import '../../../core/theme/z_text_styles.dart';
import '../../../shared/providers/progress_provider.dart';
import '../../../shared/widgets/lcoin_counter.dart';
import '../../../shared/widgets/streak_badge.dart';
import '../domain/skill_node.dart';
import 'widgets/skill_node_widget.dart';

class SkillTreeScreen extends ConsumerWidget {
  const SkillTreeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressAsync = ref.watch(userProgressProvider);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Stack(
        children: [
          const _ParallaxBackground(),
          SafeArea(
            child: Column(
              children: [
                _AppBar(),
                Expanded(
                  child: progressAsync.when(
                    data: (progress) => _SkillTreeCanvas(
                      progress: progress,
                      size: size,
                    ),
                    loading: () => const Center(
                      child: CircularProgressIndicator(color: ZColors.primary),
                    ),
                    error: (e, _) => Center(
                      child: Text('Error loading progress', style: ZTextStyles.bodyWarning),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Text('Skill Tree', style: ZTextStyles.h2Cyan),
          const Spacer(),
          const StreakBadge(),
          const SizedBox(width: 16),
          const LCoinCounter(),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => context.push(ZRoutes.profile),
            child: const CircleAvatar(
              radius: 18,
              backgroundColor: ZColors.surfaceAlt,
              child: Icon(Icons.person, color: ZColors.primary, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillTreeCanvas extends ConsumerWidget {
  const _SkillTreeCanvas({required this.progress, required this.size});
  final Map<String, TopicProgress> progress;
  final Size size;

  TopicState _stateFor(SkillNode node, Map<String, TopicProgress> progress) {
    final p = progress[node.id];
    if (p != null) return p.state;
    if (node.prerequisiteIds.isEmpty) return TopicState.available;
    final allPrereqsDone = node.prerequisiteIds
        .every((id) => progress[id]?.state == TopicState.completed);
    return allPrereqsDone ? TopicState.available : TopicState.locked;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nodes = kDemoTopics.map((node) {
      return SkillNodeWithState(
        node: node,
        state: _stateFor(node, progress),
      );
    }).toList();

    final canvasH = size.height * 1.2;

    return SingleChildScrollView(
      child: SizedBox(
        height: canvasH,
        child: Stack(
          children: [
            // Connector lines
            CustomPaint(
              size: Size(size.width, canvasH),
              painter: _ConnectorPainter(nodes: nodes, canvasSize: Size(size.width, canvasH)),
            ),
            // Nodes
            ...nodes.map((ns) {
              final x = ns.node.position.x * size.width;
              final y = ns.node.position.y * canvasH;
              return Positioned(
                left: x - 44,
                top: y - 44,
                child: SkillNodeWidget(
                  node: ns,
                  onTap: ns.state == TopicState.available
                      ? () => context.push('/jingle/${ns.node.id}')
                      : null,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _ConnectorPainter extends CustomPainter {
  const _ConnectorPainter({required this.nodes, required this.canvasSize});
  final List<SkillNodeWithState> nodes;
  final Size canvasSize;

  @override
  void paint(Canvas canvas, Size size) {
    for (final ns in nodes) {
      for (final prereqId in ns.node.prerequisiteIds) {
        final prereq = nodes.firstWhere((n) => n.node.id == prereqId, orElse: () => ns);
        final from = Offset(
          prereq.node.position.x * canvasSize.width,
          prereq.node.position.y * canvasSize.height,
        );
        final to = Offset(
          ns.node.position.x * canvasSize.width,
          ns.node.position.y * canvasSize.height,
        );

        final isUnlocked = ns.state != TopicState.locked;
        final paint = Paint()
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

        if (isUnlocked) {
          paint.color = ZColors.primary.withOpacity(0.5);
        } else {
          paint.color = const Color(0xFF2A2A2A);
          paint
            ..strokeWidth = 1.5;
        }

        final path = Path();
        path.moveTo(from.dx, from.dy);
        final cpY = (from.dy + to.dy) / 2;
        path.cubicTo(from.dx, cpY, to.dx, cpY, to.dx, to.dy);

        if (!isUnlocked) {
          final dashPaint = Paint()
            ..color = const Color(0xFF2A2A2A)
            ..strokeWidth = 1.5
            ..style = PaintingStyle.stroke;
          _drawDashedPath(canvas, path, dashPaint);
        } else {
          canvas.drawPath(path, paint);
        }
      }
    }
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    const dashLength = 8.0;
    const gapLength = 5.0;
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double dist = 0;
      bool draw = true;
      while (dist < metric.length) {
        final length = draw ? dashLength : gapLength;
        if (draw) {
          canvas.drawPath(metric.extractPath(dist, dist + length), paint);
        }
        dist += length;
        draw = !draw;
      }
    }
  }

  @override
  bool shouldRepaint(_ConnectorPainter old) => false;
}

class _ParallaxBackground extends StatefulWidget {
  const _ParallaxBackground();

  @override
  State<_ParallaxBackground> createState() => _ParallaxBackgroundState();
}

class _ParallaxBackgroundState extends State<_ParallaxBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 30))
      ..repeat(reverse: true);
    _anim = Tween<double>(begin: -15, end: 15)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Stack(
        children: [
          Positioned.fill(
            child: Container(color: ZColors.base),
          ),
          Positioned.fill(child: CustomPaint(painter: _GridPainter())),
          Positioned(
            top: 40 + _anim.value * 0.2,
            right: -80 + _anim.value * 0.5,
            child: _Orb(color: ZColors.primary, size: 300),
          ),
          Positioned(
            bottom: 80 - _anim.value * 0.3,
            left: -60 + _anim.value * 0.4,
            child: _Orb(color: ZColors.secondary, size: 250),
          ),
        ],
      ),
    );
  }
}

class _Orb extends StatelessWidget {
  const _Orb({required this.color, required this.size});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: color.withOpacity(0.08), blurRadius: size)],
        ),
      );
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ZColors.primary.withOpacity(0.03)
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
