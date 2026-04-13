import 'package:flutter/material.dart';

import '../../../../core/theme/z_colors.dart';
import '../../../../core/theme/z_text_styles.dart';
import '../../domain/jingle.dart';

class KaraokeLyrics extends StatelessWidget {
  const KaraokeLyrics({
    super.key,
    required this.currentLine,
    required this.locale,
    required this.allLines,
    required this.positionMs,
  });

  final LyricLine? currentLine;
  final String locale;
  final List<LyricLine> allLines;
  final int positionMs;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: ZColors.surface.withOpacity(0.85),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ZColors.borderActive),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: currentLine != null
            ? Text(
                currentLine!.textFor(locale),
                key: ValueKey(currentLine!.startMs),
                style: ZTextStyles.h2.copyWith(color: ZColors.primary),
                textAlign: TextAlign.center,
              )
            : Text(
                '♪  ♪  ♪',
                style: ZTextStyles.h2.copyWith(color: ZColors.textMuted),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
