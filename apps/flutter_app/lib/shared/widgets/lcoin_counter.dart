import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/z_colors.dart';
import '../../core/theme/z_text_styles.dart';
import '../providers/economy_provider.dart';

class LCoinCounter extends ConsumerWidget {
  const LCoinCounter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balance = ref.watch(lCoinBalanceProvider);

    return balance.when(
      data: (coins) => _CoinDisplay(coins: coins),
      loading: () => const _CoinDisplay(coins: 0),
      error: (_, __) => const _CoinDisplay(coins: 0),
    );
  }
}

class _CoinDisplay extends StatefulWidget {
  const _CoinDisplay({required this.coins});
  final int coins;

  @override
  State<_CoinDisplay> createState() => _CoinDisplayState();
}

class _CoinDisplayState extends State<_CoinDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _countAnim;
  int _previousCoins = 0;

  @override
  void initState() {
    super.initState();
    _previousCoins = widget.coins;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _countAnim = IntTween(begin: widget.coins, end: widget.coins)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(_CoinDisplay old) {
    super.didUpdateWidget(old);
    if (widget.coins != old.coins) {
      _countAnim = IntTween(begin: _previousCoins, end: widget.coins)
          .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
      _controller.forward(from: 0);
      _previousCoins = widget.coins;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _countAnim,
      builder: (context, _) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ZColors.gold,
              boxShadow: ZColors.glowGold(intensity: 0.5, blur: 8),
            ),
            child: const Center(
              child: Text('L', style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '${_countAnim.value}',
            style: ZTextStyles.body.copyWith(
              color: ZColors.gold,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// Large roll-up coin counter for reward screen.
class LCoinCounterLarge extends StatefulWidget {
  const LCoinCounterLarge({super.key, required this.amount});
  final int amount;

  @override
  State<LCoinCounterLarge> createState() => _LCoinCounterLargeState();
}

class _LCoinCounterLargeState extends State<LCoinCounterLarge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _countAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _countAnim = IntTween(begin: 0, end: widget.amount)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _countAnim,
      builder: (context, _) => Text(
        '+${_countAnim.value}',
        style: ZTextStyles.h1Gold,
      ),
    );
  }
}
