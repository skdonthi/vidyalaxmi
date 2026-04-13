import 'package:flutter/material.dart';

import '../../../../core/animations/haptic_utils.dart';
import '../../../../core/theme/z_colors.dart';
import '../../../../core/theme/z_text_styles.dart';
import '../../../../shared/providers/progress_provider.dart';
import '../../domain/skill_node.dart';

class SkillNodeWidget extends StatefulWidget {
  const SkillNodeWidget({
    super.key,
    required this.node,
    this.onTap,
  });

  final SkillNodeWithState node;
  final VoidCallback? onTap;

  @override
  State<SkillNodeWidget> createState() => _SkillNodeWidgetState();
}

class _SkillNodeWidgetState extends State<SkillNodeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _pulseAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
    if (widget.node.state == TopicState.available) {
      _pulseCtrl.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  Color get _glowColor => switch (widget.node.node.subject) {
        'physics' => ZColors.primary,
        'math' => ZColors.secondary,
        'bio' => ZColors.success,
        _ => ZColors.primary,
      };

  Color get _nodeColor {
    return switch (widget.node.state) {
      TopicState.locked => const Color(0xFF2A2A2A),
      TopicState.available => _glowColor,
      TopicState.completed => ZColors.success,
    };
  }

  IconData get _icon => switch (widget.node.state) {
        TopicState.locked => Icons.lock_outline,
        TopicState.completed => Icons.check_circle_outline,
        TopicState.available => switch (widget.node.node.mentor) {
            MentorId.zayn => Icons.flash_on,
            MentorId.arya => Icons.calculate,
            MentorId.dhara => Icons.eco,
          },
      };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.onTap != null) {
          await ZHaptics.tap();
          widget.onTap!();
        }
      },
      child: AnimatedBuilder(
        animation: _pulseAnim,
        builder: (context, child) {
          final scale = widget.node.state == TopicState.available
              ? _pulseAnim.value
              : 1.0;
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: SizedBox(
          width: 88,
          height: 88,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Glow ring
              if (widget.node.state != TopicState.locked)
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _glowColor.withOpacity(0.35),
                        blurRadius: 20,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                ),
              // Node circle
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ZColors.surface,
                  border: Border.all(
                    color: _nodeColor,
                    width: widget.node.state == TopicState.locked ? 1 : 2,
                  ),
                ),
                child: Icon(_icon, color: _nodeColor, size: 28),
              ),
              // Label
              Positioned(
                bottom: -2,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: ZColors.surface.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.node.node.titleEn,
                    style: ZTextStyles.micro.copyWith(
                      color: widget.node.state == TopicState.locked
                          ? ZColors.textMuted
                          : ZColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
