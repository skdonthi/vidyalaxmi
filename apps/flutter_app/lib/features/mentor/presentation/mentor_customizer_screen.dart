import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/animations/haptic_utils.dart';
import '../../../core/theme/z_colors.dart';
import '../../../core/theme/z_text_styles.dart';
import '../../../shared/providers/economy_provider.dart';
import '../../../shared/widgets/lcoin_counter.dart';
import '../../../shared/widgets/z_button.dart';
import '../../../shared/widgets/z_card.dart';
import '../domain/mentor.dart';

class MentorCustomizerScreen extends ConsumerStatefulWidget {
  const MentorCustomizerScreen({super.key});

  @override
  ConsumerState<MentorCustomizerScreen> createState() => _MentorCustomizerScreenState();
}

class _MentorCustomizerScreenState extends ConsumerState<MentorCustomizerScreen> {
  MentorId _selectedMentor = MentorId.arya;
  final Set<String> _ownedItems = {};
  String? _equippedItem;

  @override
  Widget build(BuildContext context) {
    final mentor = kMentors.firstWhere((m) => m.id == _selectedMentor);
    final items = kCosmeticItems.where((i) => i.mentorId == _selectedMentor).toList();
    final balance = ref.watch(lCoinBalanceProvider).valueOrNull ?? 0;

    return Scaffold(
      backgroundColor: ZColors.base,
      appBar: AppBar(
        title: Text('Mentor Shop', style: ZTextStyles.h2Cyan),
        backgroundColor: ZColors.base,
        actions: [const Padding(padding: EdgeInsets.only(right: 16), child: LCoinCounter())],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mentor selector tabs
            Row(
              children: kMentors.map((m) {
                final active = m.id == _selectedMentor;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedMentor = m.id),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: active ? m.glowColor.withOpacity(0.15) : ZColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: active ? m.glowColor : ZColors.border),
                        boxShadow: active ? [BoxShadow(color: m.glowColor.withOpacity(0.25), blurRadius: 12)] : [],
                      ),
                      child: Text(
                        m.name,
                        style: ZTextStyles.body.copyWith(
                          color: active ? m.glowColor : ZColors.textMuted,
                          fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // Mentor preview
            ZCard(
              glowColor: mentor.glowColor,
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ZColors.surfaceAlt,
                      border: Border.all(color: mentor.glowColor, width: 2),
                      boxShadow: [BoxShadow(color: mentor.glowColor.withOpacity(0.35), blurRadius: 16)],
                    ),
                    child: Icon(Icons.person, color: mentor.glowColor, size: 40),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(mentor.name, style: ZTextStyles.h2.copyWith(color: mentor.glowColor)),
                        Text(mentor.subject, style: ZTextStyles.caption),
                        const SizedBox(height: 4),
                        Text(mentor.description, style: ZTextStyles.bodyMuted, maxLines: 2, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text('Headwear', style: ZTextStyles.h2),
            const SizedBox(height: 12),

            // Cosmetic items grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: items.map((item) {
                final owned = _ownedItems.contains(item.id);
                final equipped = _equippedItem == item.id;
                final canAfford = balance >= item.price;

                return ZHoverCard(
                  glowColor: owned ? mentor.glowColor : null,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.diamond, color: ZColors.gold, size: 28),
                      const SizedBox(height: 8),
                      Text(item.name, style: ZTextStyles.body, textAlign: TextAlign.center),
                      const SizedBox(height: 8),
                      if (!owned)
                        ZButton(
                          label: '${item.price} L',
                          variant: canAfford
                              ? ZButtonVariant.primary
                              : ZButtonVariant.ghost,
                          onPressed: canAfford ? () => _buy(item) : null,
                        )
                      else if (!equipped)
                        ZButton(
                          label: 'Equip',
                          variant: ZButtonVariant.secondary,
                          onPressed: () {
                            ZHaptics.tap();
                            setState(() => _equippedItem = item.id);
                          },
                        )
                      else
                        Text('Equipped ✓', style: ZTextStyles.bodySuccess),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _buy(CosmeticItem item) async {
    await ref.read(economyNotifierProvider.notifier).spendCoins(
          amount: item.price,
          description: 'Bought: ${item.name}',
        );
    await ZHaptics.reward();
    setState(() {
      _ownedItems.add(item.id);
      _equippedItem = item.id;
    });
  }
}
