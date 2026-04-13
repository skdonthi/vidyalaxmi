import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/z_colors.dart';
import '../../../core/theme/z_text_styles.dart';
import '../../../shared/providers/locale_provider.dart';
import '../../../shared/widgets/z_button.dart';
import '../domain/jingle.dart';
import 'widgets/karaoke_lyrics.dart';
import 'widgets/waveform_visualizer.dart';

class JingleScreen extends ConsumerStatefulWidget {
  const JingleScreen({super.key, required this.topicId});
  final String topicId;

  @override
  ConsumerState<JingleScreen> createState() => _JingleScreenState();
}

class _JingleScreenState extends ConsumerState<JingleScreen>
    with SingleTickerProviderStateMixin {
  final _player = AudioPlayer();
  final _tts = FlutterTts();
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _playing = false;
  bool _canSkip = false;
  bool _finished = false;

  late Jingle _jingle;

  @override
  void initState() {
    super.initState();
    _jingle = kDemoJingle; // TODO: load from repo by topicId

    _initTts();

    _player.onPositionChanged.listen((pos) {
      if (!mounted) return;
      setState(() {
        _position = pos;
        if (pos.inSeconds >= 10) _canSkip = true;
      });
    });

    _player.onDurationChanged.listen((dur) {
      if (!mounted) return;
      setState(() => _duration = dur);
    });

    _player.onPlayerComplete.listen((_) {
      if (!mounted) return;
      setState(() {
        _finished = true;
        _playing = false;
      });
    });

    _startPlayback();
  }

  Future<void> _initTts() async {
    await _tts.setLanguage(ref.read(localeProvider).languageCode);
    await _tts.setSpeechRate(0.5);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
  }

  Future<void> _speak(String text) async {
    final locale = ref.read(localeProvider).languageCode;
    await _tts.setLanguage(locale);
    await _tts.speak(text);
  }

  Future<void> _startPlayback() async {
    // Force TTS for MVP demo to avoid roar placeholder
    setState(() {
      _duration = Duration(milliseconds: _jingle.durationMs);
    });
    _simulatePlayback();
  }

  void _simulatePlayback() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!mounted) return;
      
      final oldLyric = _currentLyric;
      setState(() {
        _position = _position + const Duration(milliseconds: 100);
        if (_position.inSeconds >= 10) _canSkip = true;
        if (_position.inMilliseconds >= _jingle.durationMs) {
          _finished = true;
          return;
        }
      });

      final newLyric = _currentLyric;
      if (newLyric != null && newLyric != oldLyric) {
        _speak(newLyric.textFor(ref.read(localeProvider).languageCode));
      }

      if (!_finished) _simulatePlayback();
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  LyricLine? get _currentLyric {
    final ms = _position.inMilliseconds;
    try {
      return _jingle.lyrics.lastWhere(
        (l) => ms >= l.startMs && ms < l.endMs,
      );
    } catch (_) {
      return null;
    }
  }

  double get _progress =>
      _duration.inMilliseconds > 0
          ? _position.inMilliseconds / _jingle.durationMs
          : 0;

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProvider).languageCode;

    return Scaffold(
      backgroundColor: ZColors.base,
      body: Stack(
        children: [
          const Positioned.fill(child: _JingleBackground()),
          SafeArea(
            child: Column(
              children: [
                // Top bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: ZColors.primary),
                        onPressed: () => context.pop(),
                      ),
                      Expanded(
                        child: Text(
                          _jingle.titleEn,
                          style: ZTextStyles.h2Cyan,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // Language switcher
                      _LanguageChip(
                        locale: locale,
                        onChanged: (l) => ref
                            .read(localeNotifierProvider.notifier)
                            .setLocale(Locale(l)),
                      ),
                    ],
                  ),
                ),

                // Progress bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: LinearProgressIndicator(
                    value: _progress,
                    backgroundColor: ZColors.surfaceAlt,
                    color: ZColors.primary,
                    borderRadius: BorderRadius.circular(4),
                    minHeight: 4,
                  ),
                ),

                const Spacer(),

                // Waveform visualizer
                const WaveformVisualizer(),

                const SizedBox(height: 20),

                // Mentor placeholder
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ZColors.secondary, width: 2),
                    boxShadow: ZColors.glowMagenta(intensity: 0.4),
                    color: ZColors.surfaceAlt,
                  ),
                  child: const Icon(Icons.calculate, color: ZColors.secondary, size: 60),
                ),

                const SizedBox(height: 32),

                // Karaoke lyrics
                KaraokeLyrics(
                  currentLine: _currentLyric,
                  locale: locale,
                  allLines: _jingle.lyrics,
                  positionMs: _position.inMilliseconds,
                ),

                const Spacer(),

                // CTA buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                  child: Row(
                    children: [
                      if (_canSkip && !_finished)
                        Expanded(
                          child: ZButton(
                            label: 'Skip',
                            variant: ZButtonVariant.ghost,
                            onPressed: () => context.pushReplacement(
                              '/boss-fight/${widget.topicId}',
                            ),
                          ),
                        ),
                      if (_canSkip) const SizedBox(width: 12),
                      if (_finished)
                        Expanded(
                          child: ZButton(
                            label: 'Enter Boss Fight!',
                            icon: Icons.sports_kabaddi,
                            onPressed: () => context.pushReplacement(
                              '/boss-fight/${widget.topicId}',
                            ),
                          ),
                        ),
                    ],
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

class _LanguageChip extends StatelessWidget {
  const _LanguageChip({required this.locale, required this.onChanged});
  final String locale;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    final langs = ['en', 'te', 'hi'];
    final labels = {'en': 'EN', 'te': 'తె', 'hi': 'हि'};

    return PopupMenuButton<String>(
      initialValue: locale,
      onSelected: onChanged,
      color: ZColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: ZColors.primary),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          labels[locale] ?? 'EN',
          style: ZTextStyles.micro.copyWith(color: ZColors.primary),
        ),
      ),
      itemBuilder: (context) => langs
          .map((l) => PopupMenuItem(
                value: l,
                child: Text(labels[l]!, style: ZTextStyles.body),
              ))
          .toList(),
    );
  }
}

class _JingleBackground extends StatelessWidget {
  const _JingleBackground();

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.5),
            radius: 1.2,
            colors: [Color(0xFF0D1A2A), ZColors.base],
          ),
        ),
      );
}
