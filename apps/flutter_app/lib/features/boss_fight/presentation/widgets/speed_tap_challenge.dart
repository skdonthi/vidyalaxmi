import 'package:flutter/material.dart';

import '../../../../core/theme/z_colors.dart';
import '../../../../core/theme/z_text_styles.dart';
import '../../../../shared/widgets/z_card.dart';

class SpeedTapChallenge extends StatefulWidget {
  const SpeedTapChallenge({
    super.key,
    required this.options,
    required this.correctId,
    required this.onCorrect,
    required this.onWrong,
    required this.difficulty,
  });

  final List<({String id, String label})> options;
  final String correctId;
  final Future<void> Function() onCorrect;
  final Future<void> Function() onWrong;
  final int difficulty;

  @override
  State<SpeedTapChallenge> createState() => _SpeedTapChallengeState();
}

class _SpeedTapChallengeState extends State<SpeedTapChallenge> {
  String? _selected;
  bool _answered = false;

  Future<void> _onTap(String id) async {
    if (_answered) return;
    setState(() {
      _selected = id;
      _answered = true;
    });

    await Future.delayed(const Duration(milliseconds: 200));

    if (id == widget.correctId) {
      await widget.onCorrect();
    } else {
      await widget.onWrong();
    }
  }

  Color _colorFor(String id) {
    if (_selected == null) return ZColors.surface;
    if (id == widget.correctId && _answered) return ZColors.success.withOpacity(0.2);
    if (id == _selected && id != widget.correctId) return ZColors.warning.withOpacity(0.2);
    return ZColors.surface;
  }

  Color _borderFor(String id) {
    if (_selected == null) return ZColors.border;
    if (id == widget.correctId && _answered) return ZColors.success;
    if (id == _selected && id != widget.correctId) return ZColors.warning;
    return ZColors.border;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.8,
      children: widget.options.map((opt) {
        return GestureDetector(
          onTap: () => _onTap(opt.id),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: _colorFor(opt.id),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _borderFor(opt.id), width: 1.5),
              boxShadow: _answered && opt.id == widget.correctId
                  ? ZColors.glowGreen(intensity: 0.3)
                  : [],
            ),
            alignment: Alignment.center,
            child: Text(
              opt.label,
              style: ZTextStyles.h1.copyWith(
                color: _answered && opt.id == widget.correctId
                    ? ZColors.success
                    : _answered && opt.id == _selected
                        ? ZColors.warning
                        : ZColors.textPrimary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
