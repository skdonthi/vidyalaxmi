import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/z_colors.dart';
import '../../../core/theme/z_text_styles.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/providers/economy_provider.dart';
import '../../../shared/providers/locale_provider.dart';
import '../../../shared/widgets/lcoin_counter.dart';
import '../../../shared/widgets/streak_badge.dart';
import '../../../shared/widgets/z_button.dart';
import '../../../shared/widgets/z_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final locale = ref.watch(localeProvider);

    return Scaffold(
      backgroundColor: ZColors.base,
      appBar: AppBar(
        title: Text('My Profile', style: ZTextStyles.h2Cyan),
        backgroundColor: ZColors.base,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats row
            ZCard(
              glowColor: ZColors.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _Stat(label: 'Streak', child: const StreakBadge()),
                  const _VertDivider(),
                  _Stat(label: 'L-Coins', child: const LCoinCounter()),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Text('Language', style: ZTextStyles.h2),
            const SizedBox(height: 12),

            // Language selector
            Row(
              children: [
                _LangButton(
                  label: 'English',
                  code: 'en',
                  current: locale.languageCode,
                  onTap: () => ref.read(localeNotifierProvider.notifier).setLocale(const Locale('en')),
                ),
                const SizedBox(width: 12),
                _LangButton(
                  label: 'తెలుగు',
                  code: 'te',
                  current: locale.languageCode,
                  onTap: () => ref.read(localeNotifierProvider.notifier).setLocale(const Locale('te')),
                ),
                const SizedBox(width: 12),
                _LangButton(
                  label: 'हिंदी',
                  code: 'hi',
                  current: locale.languageCode,
                  onTap: () => ref.read(localeNotifierProvider.notifier).setLocale(const Locale('hi')),
                ),
              ],
            ),

            const SizedBox(height: 32),

            ZButton(
              label: 'Sign Out',
              variant: ZButtonVariant.ghost,
              onPressed: () => ref.read(authNotifierProvider.notifier).signOut(),
              width: double.infinity,
            ),

            const SizedBox(height: 16),

            if (user != null)
              Text(
                'User ID: ${user.id.substring(0, 8)}...',
                style: ZTextStyles.micro,
              ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          child,
          const SizedBox(height: 4),
          Text(label, style: ZTextStyles.caption),
        ],
      );
}

class _VertDivider extends StatelessWidget {
  const _VertDivider();

  @override
  Widget build(BuildContext context) => Container(
        height: 40,
        width: 1,
        color: ZColors.border,
      );
}

class _LangButton extends StatelessWidget {
  const _LangButton({
    required this.label,
    required this.code,
    required this.current,
    required this.onTap,
  });
  final String label;
  final String code;
  final String current;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final active = code == current;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: active ? ZColors.primary.withOpacity(0.15) : ZColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: active ? ZColors.primary : ZColors.border),
          ),
          child: Text(
            label,
            style: ZTextStyles.body.copyWith(
              color: active ? ZColors.primary : ZColors.textMuted,
              fontWeight: active ? FontWeight.w700 : FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
