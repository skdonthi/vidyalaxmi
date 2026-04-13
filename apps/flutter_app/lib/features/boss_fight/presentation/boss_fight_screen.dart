import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/animations/haptic_utils.dart';
import '../../../core/theme/z_colors.dart';
import '../../../core/theme/z_text_styles.dart';
import '../../../shared/providers/locale_provider.dart';
import '../../../shared/widgets/z_card.dart';
import '../../../shared/widgets/z_progress_bar.dart';
import '../domain/question.dart';
import 'widgets/drag_drop_challenge.dart';
import 'widgets/speed_tap_challenge.dart';

class BossFightScreen extends ConsumerStatefulWidget {
  const BossFightScreen({super.key, required this.topicId});
  final String topicId;

  @override
  ConsumerState<BossFightScreen> createState() => _BossFightScreenState();
}

class _BossFightScreenState extends ConsumerState<BossFightScreen>
    with TickerProviderStateMixin {
  int _lives = 3;
  int _currentIndex = 0;
  int _score = 0;
  int _correctCount = 0;
  int _difficulty = 1;
  bool _isShaking = false;
  bool _showFlash = false;
  Color _flashColor = Colors.transparent;

  late List<Question> _questions;
  late AnimationController _shakeCtrl;
  late Animation<double> _shakeAnim;

  static const int _timerMaxMs = 15000;
  int _timerMs = _timerMaxMs;
  late AnimationController _timerCtrl;

  @override
  void initState() {
    super.initState();
    _questions = List.from(kDemoQuestions);

    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 8.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: -8.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 0.0), weight: 25),
    ]).animate(_shakeCtrl);

    _timerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _timerMaxMs),
    )..addListener(() {
        setState(() => _timerMs = (1 - _timerCtrl.value) * _timerMaxMs ~/ 1);
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _onWrong();
        }
      });

    _startTimer();
  }

  @override
  void dispose() {
    _shakeCtrl.dispose();
    _timerCtrl.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timerCtrl.forward(from: 0);
    setState(() => _timerMs = _timerMaxMs);
  }

  Future<void> _onCorrect() async {
    _timerCtrl.stop();
    await ZHaptics.correct();
    final responseTimeMs = _timerMaxMs - _timerMs;

    setState(() {
      _correctCount++;
      _score += _calcScore(responseTimeMs);
      _showFlash = true;
      _flashColor = ZColors.success.withOpacity(0.3);
    });

    await Future.delayed(const Duration(milliseconds: 400));
    _updateDifficulty(responseTimeMs: responseTimeMs, correct: true);

    setState(() => _showFlash = false);
    _next();
  }

  Future<void> _onWrong() async {
    _timerCtrl.stop();
    await ZHaptics.wrong();

    setState(() {
      _lives = (_lives - 1).clamp(0, 3);
      _showFlash = true;
      _flashColor = ZColors.warning.withOpacity(0.3);
      _isShaking = true;
    });

    _shakeCtrl.forward(from: 0).then((_) {
      if (mounted) setState(() => _isShaking = false);
    });

    await Future.delayed(const Duration(milliseconds: 500));
    _updateDifficulty(responseTimeMs: _timerMaxMs, correct: false);

    setState(() => _showFlash = false);

    if (_lives <= 0) {
      _finish();
    } else {
      _next();
    }
  }

  void _updateDifficulty({required int responseTimeMs, required bool correct}) {
    // ADL algorithm: weighted score
    final accuracy = correct ? 1.0 : 0.0;
    final timeScore = 1.0 - (responseTimeMs / _timerMaxMs).clamp(0.0, 1.0);
    final weighted = 0.6 * accuracy + 0.4 * timeScore;

    setState(() {
      if (weighted > 0.7) {
        _difficulty = (_difficulty + 1).clamp(1, 5);
      } else if (weighted < 0.3) {
        _difficulty = (_difficulty - 1).clamp(1, 5);
      }
    });
  }

  int _calcScore(int responseTimeMs) {
    final timeFactor = 1.0 - (responseTimeMs / _timerMaxMs).clamp(0.0, 1.0);
    return (100 + (timeFactor * 50)).round() * _difficulty;
  }

  void _next() {
    if (_currentIndex >= _questions.length - 1) {
      _finish();
      return;
    }
    setState(() => _currentIndex++);
    _startTimer();
  }

  void _finish() {
    final accuracy = _questions.isEmpty
        ? 0.0
        : _correctCount / _questions.length;
    final coins = (_score * 0.1).round().clamp(10, 500);

    context.pushReplacement(
      '/reward/${widget.topicId}?coins=$coins',
    );
  }

  double get _timerProgress => _timerMs / _timerMaxMs;

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProvider).languageCode;
    final question = _questions[_currentIndex];

    return Scaffold(
      backgroundColor: ZColors.base,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                _BossFightHeader(
                  lives: _lives,
                  question: _currentIndex + 1,
                  total: _questions.length,
                  timerProgress: _timerProgress,
                  timerMs: _timerMs,
                  difficulty: _difficulty,
                ),
                Expanded(
                  child: AnimatedBuilder(
                    animation: _shakeAnim,
                    builder: (context, child) => Transform.translate(
                      offset: Offset(_isShaking ? _shakeAnim.value : 0, 0),
                      child: child,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          ZCard(
                            glowColor: ZColors.secondary,
                            child: Text(
                              question.promptFor(locale),
                              style: ZTextStyles.h2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Expanded(
                            child: switch (question.type) {
                              QuestionType.dragDrop => DragDropChallenge(
                                  key: ValueKey('dd_${question.id}'),
                                  pairs: question.dragPairs,
                                  onAllCorrect: _onCorrect,
                                  onMistake: _onWrong,
                                ),
                              QuestionType.speedTap => SpeedTapChallenge(
                                  key: ValueKey('st_${question.id}'),
                                  options: question.options,
                                  correctId: question.correctOptionId,
                                  onCorrect: _onCorrect,
                                  onWrong: _onWrong,
                                  difficulty: _difficulty,
                                ),
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Flash overlay
          if (_showFlash)
            Positioned.fill(
              child: IgnorePointer(
                child: Container(color: _flashColor),
              ),
            ),
        ],
      ),
    );
  }
}

class _BossFightHeader extends StatelessWidget {
  const _BossFightHeader({
    required this.lives,
    required this.question,
    required this.total,
    required this.timerProgress,
    required this.timerMs,
    required this.difficulty,
  });

  final int lives;
  final int question;
  final int total;
  final double timerProgress;
  final int timerMs;
  final int difficulty;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: ZColors.textMuted),
                onPressed: () => context.pop(),
              ),
              Expanded(
                child: ZProgressBar(
                  value: timerProgress,
                  color: timerProgress < 0.3 ? ZColors.warning : ZColors.primary,
                  pulsing: timerProgress < 0.3,
                  segments: 15,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${(timerMs / 1000).toStringAsFixed(1)}s',
                style: ZTextStyles.caption.copyWith(
                  color: timerProgress < 0.3 ? ZColors.warning : ZColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: List.generate(3, (i) => Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Icon(
                    i < lives ? Icons.favorite : Icons.favorite_border,
                    color: ZColors.warning,
                    size: 20,
                  ),
                )),
              ),
              Text(
                'Q $question / $total',
                style: ZTextStyles.caption,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: ZColors.secondary),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'LVL $difficulty',
                  style: ZTextStyles.micro.copyWith(color: ZColors.secondary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
