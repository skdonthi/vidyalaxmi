import 'package:flutter/material.dart';

import '../../../../core/theme/z_colors.dart';
import '../../../../core/theme/z_text_styles.dart';
import '../../domain/question.dart';

class DragDropChallenge extends StatefulWidget {
  const DragDropChallenge({
    super.key,
    required this.pairs,
    required this.onAllCorrect,
    required this.onMistake,
  });

  final List<DragDropPair> pairs;
  final Future<void> Function() onAllCorrect;
  final Future<void> Function() onMistake;

  @override
  State<DragDropChallenge> createState() => _DragDropChallengeState();
}

class _DragDropChallengeState extends State<DragDropChallenge> {
  final Map<String, String?> _matched = {}; // targetId -> draggableId
  final Set<String> _used = {};

  bool get _allMatched =>
      _matched.length == widget.pairs.length &&
      _matched.values.every((v) => v != null);

  Future<void> _onDrop(String targetId, String dragId) async {
    if (dragId == targetId) {
      setState(() {
        _matched[targetId] = dragId;
        _used.add(dragId);
      });
      if (_allMatched) {
        await widget.onAllCorrect();
      }
    } else {
      await widget.onMistake();
    }
  }

  @override
  Widget build(BuildContext context) {
    final unmatched = widget.pairs
        .where((p) => !_used.contains(p.id))
        .toList();

    return Column(
      children: [
        // Draggable letters
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: unmatched.map((pair) {
            return Draggable<String>(
              data: pair.id,
              feedback: Material(
                color: Colors.transparent,
                child: _LetterChip(label: pair.label, scale: 1.1, glow: true),
              ),
              childWhenDragging: _LetterChip(
                label: pair.label,
                scale: 1.0,
                dimmed: true,
              ),
              child: _LetterChip(label: pair.label, scale: 1.0),
            );
          }).toList(),
        ),

        const SizedBox(height: 32),

        // Drop targets (images with description)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: widget.pairs.map((pair) {
            final isMatched = _matched[pair.id] != null;
            return DragTarget<String>(
              builder: (context, candidates, rejected) {
                final hovering = candidates.isNotEmpty;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: isMatched
                        ? ZColors.success.withOpacity(0.15)
                        : hovering
                            ? ZColors.primary.withOpacity(0.1)
                            : ZColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isMatched
                          ? ZColors.success
                          : hovering
                              ? ZColors.primary
                              : ZColors.border,
                      width: isMatched || hovering ? 2 : 1,
                    ),
                    boxShadow: hovering ? ZColors.glowCyan(intensity: 0.3) : [],
                  ),
                  child: isMatched
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check_circle, color: ZColors.success, size: 28),
                            Text(pair.label, style: ZTextStyles.h2.copyWith(color: ZColors.success)),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.image_not_supported_outlined, color: ZColors.textMuted, size: 28),
                            const SizedBox(height: 4),
                            Text(
                              pair.imageAsset.split('/').last.split('.').first,
                              style: ZTextStyles.micro,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                );
              },
              onAcceptWithDetails: (details) => _onDrop(pair.id, details.data),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _LetterChip extends StatelessWidget {
  const _LetterChip({
    required this.label,
    required this.scale,
    this.dimmed = false,
    this.glow = false,
  });

  final String label;
  final double scale;
  final bool dimmed;
  final bool glow;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: dimmed ? ZColors.surfaceAlt : ZColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: dimmed ? ZColors.border : ZColors.secondary),
          boxShadow: glow ? ZColors.glowMagenta(intensity: 0.4) : [],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: ZTextStyles.h2.copyWith(
            color: dimmed ? ZColors.textMuted : ZColors.secondary,
          ),
        ),
      ),
    );
  }
}
